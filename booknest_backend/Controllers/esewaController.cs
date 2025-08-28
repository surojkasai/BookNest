using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Text;
using System.Security.Cryptography; // For SHA256 hashing if Esewa uses it
using System.Globalization; // For culture-invariant number formatting

[ApiController]
[Route("api/[controller]")]
public class EsewaPaymentController : ControllerBase
{
    private readonly HttpClient _httpClient;
    private readonly string _esewaMerchantCode = "EPAYTEST"; // Your actual merchant code
    private readonly string _esewaSecretKey = "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ=="; // THIS IS CRUCIAL: GET THIS FROM ESEWA. NEVER EXPOSE IN FRONTEND.
    private readonly string _esewaInitiateUrl = "https://rc-epay.esewa.com.np/api/epay/main/v2/initiate"; // VERIFY THIS WITH ESEWA DOCS!
    private readonly string _esewaVerificationUrl = "https://rc-epay.esewa.com.np/api/epay/main/v2/verification"; // VERIFY THIS WITH ESEWA DOCS!


    public EsewaPaymentController(IHttpClientFactory httpClientFactory)
    {
        _httpClient = httpClientFactory.CreateClient();
    }

    [HttpPost("initiate")]
    public async Task<IActionResult> InitiateEsewaPayment([FromBody] EsewaPaymentRequestDto request)
    {
        // 1. Calculate Total Amount in Esewa's expected format (usually Nepalese Rupee, without paisa conversion for tAmt, but verify)
        // Note: For Esewa's specific API, 'tAmt' is often expected in Rupees, not paisa.
        // It's crucial to confirm this with Esewa's *latest* documentation.
        // If your frontend 'amount' is in Rupees, use it directly.
        // For this example, let's assume Esewa's tAmt expects Rupees.
        double totalAmount = request.Amount; // Assuming request.Amount is already in Rupees from Flutter

        // 2. Generate Unique Order ID (pid)
        string orderId = $"ORDER_{Guid.NewGuid().ToString().Replace("-", "").Substring(0, 10)}"; // Example unique ID

        // 3. Generate Signature (if Esewa requires it for this API)
        // Esewa's checksum generation can vary. For the direct POST form, it might not be required
        // at the initiate stage, but for backend API calls, it's very common.
        // Check Esewa's documentation for "Signature", "Checksum", or "Hash" generation.
        // Example (hypothetical SHA256 based on some gateways):
        // var signature = GenerateEsewaSignature(request.Amount, request.ProductId, orderId, _esewaSecretKey);

        // 4. Prepare payload for Esewa
        var payload = new
        {
            amt = totalAmount.ToString("0.00", CultureInfo.InvariantCulture), // Amount without charges
            pdc = "0", // Product Delivery Charge
            psc = "0", // Product Service Charge
            txAmt = "0", // Tax Amount
            tAmt = totalAmount.ToString("0.00", CultureInfo.InvariantCulture), // Total Amount
            scd = _esewaMerchantCode,
            pid = orderId,
            su = request.SuccessUrl,
            fu = request.FailureUrl
            // signature = signature // Include if required by Esewa
        };

        var jsonPayload = JsonConvert.SerializeObject(payload);
        var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

        // 5. Make API call to Esewa
        _httpClient.DefaultRequestHeaders.Clear();
        // Esewa might require an Authorization header or other specific headers. Check their docs.
        // _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Key", "your_api_key");

        var response = await _httpClient.PostAsync(_esewaInitiateUrl, content);
        var responseContent = await response.Content.ReadAsStringAsync();
        Console.WriteLine($"Esewa API Initiate Response: {responseContent}");

        if (response.IsSuccessStatusCode)
        {
            // Esewa's initiate API might return a payment_url or other redirection info
            var esewaResponse = JsonConvert.DeserializeObject<EsewaInitiateResponse>(responseContent);
            if (!string.IsNullOrEmpty(esewaResponse?.path)) // 'path' is a common field for URL in Esewa response
            {
                // Return the URL to the frontend
                return Ok(new { payment_url = esewaResponse.path });
            }
            else
            {
                // Esewa response didn't contain a usable path
                return BadRequest(new { error_message = "Esewa did not return a valid payment URL." });
            }
        }
        else
        {
            // Esewa API call failed
            return StatusCode((int)response.StatusCode, responseContent);
        }
    }

    // Helper for signature generation (implement based on Esewa's exact spec)
    // private string GenerateEsewaSignature(double amount, string productId, string orderId, string secretKey)
    // {
    //     string message = $"{amount.ToString("0.00", CultureInfo.InvariantCulture)},{productId},{orderId},{secretKey}";
    //     using (var sha256 = SHA256.Create())
    //     {
    //         byte[] bytes = Encoding.UTF8.GetBytes(message);
    //         byte[] hashBytes = sha256.ComputeHash(bytes);
    //         return BitConverter.ToString(hashBytes).Replace("-", "").ToLowerInvariant();
    //     }
    // }

    // DTO for incoming request from Flutter
    public class EsewaPaymentRequestDto
    {
        public double Amount { get; set; } // Amount in Rupees
        public string ProductId { get; set; } = null!;
        public string SuccessUrl { get; set; } = null!;
        public string FailureUrl { get; set; } = null!;
        // You might need customer info here too, similar to Khalti
    }

    // DTO for parsing Esewa's initiate API response
    public class EsewaInitiateResponse
    {
        public string? status { get; set; }
        public string? path { get; set; } // The payment URL from Esewa
        public string? pidx { get; set; } // if present
        // Add other fields based on Esewa's response
    }
}