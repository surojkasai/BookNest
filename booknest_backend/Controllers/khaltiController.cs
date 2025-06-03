


using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json; // Still needed for JsonConvert.SerializeObject for the payload
using System.Net.Http.Headers;
using System.Text;

[ApiController]
[Route("api/[controller]")]
public class KhaltiPaymentController : ControllerBase
{
    private readonly HttpClient _httpClient;

    public KhaltiPaymentController(IHttpClientFactory httpClientFactory)
    {
        _httpClient = httpClientFactory.CreateClient();
    }

    [HttpPost("initiate")]
    public async Task<IActionResult> InitiatePayment([FromBody] PaymentRequestDto request)
    {
        var url = "https://dev.khalti.com/api/v2/epayment/initiate/";

        var payload = new
        {
            return_url = request.ReturnUrl,
            website_url = request.WebsiteUrl,
            amount = request.Amount,
            purchase_order_id = request.OrderId,
            purchase_order_name = request.OrderName,
            customer_info = new
            {
                name = request.CustomerName,
                email = request.CustomerEmail,
                phone = request.CustomerPhone
            }
        };

        var jsonPayload = JsonConvert.SerializeObject(payload);
        var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

        _httpClient.DefaultRequestHeaders.Clear();
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Key", "abf4707d93ef4b78bfedef64a9d5764d");

        var response = await _httpClient.PostAsync(url, content);
        var responseContent = await response.Content.ReadAsStringAsync();
        Console.WriteLine("Khalti API Response: " + responseContent); // This should show the correct URL string

        if (response.IsSuccessStatusCode)
        {
            // *** CHANGE THIS LINE ***
            // Instead of deserializing and letting Ok() re-serialize, just return the raw string content
            return Content(responseContent, "application/json");
        }
        else
        {
            return StatusCode((int)response.StatusCode, responseContent);
        }
    }

    [HttpPost("lookup")]
    public async Task<IActionResult> LookupPayment([FromBody] LookupRequestDto request)
    {
        var url = "https://dev.khalti.com/api/v2/epayment/lookup/";

        var payload = new { pidx = request.Pidx };
        var jsonPayload = JsonConvert.SerializeObject(payload);
        var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

        _httpClient.DefaultRequestHeaders.Clear();
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Key", "abf4707d93ef4b78bfedef64a9d5764d");

        var response = await _httpClient.PostAsync(url, content);
        var responseContent = await response.Content.ReadAsStringAsync();

        if (response.IsSuccessStatusCode)
        {
            // *** CHANGE THIS LINE as well for consistency ***
            return Content(responseContent, "application/json");
        }
        else
        {
            return StatusCode((int)response.StatusCode, responseContent);
        }
    }
}

// DTOs for request payloads remain the same
public class PaymentRequestDto
{
    public string ReturnUrl { get; set; } = null!;
    public string WebsiteUrl { get; set; } = null!;
    public int Amount { get; set; }
    public string OrderId { get; set; } = null!;
    public string OrderName { get; set; } = null!;
    public string CustomerName { get; set; } = null!;
    public string CustomerEmail { get; set; } = null!;
    public string CustomerPhone { get; set; } = null!;
}

public class LookupRequestDto
{
    public string Pidx { get; set; } = null!;
}