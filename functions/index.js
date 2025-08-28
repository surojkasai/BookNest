const functions = require("firebase-functions");
const axios = require("axios");

exports.initiateKhaltiPayment = functions.https.onCall(async (data) => {
  // Simple validation example
  if (!data.returnUrl || !data.websiteUrl || !data.amount) {
    // eslint-disable-next-line max-len
    throw new functions.https.HttpsError("invalid-argument", "Missing required fields");
  }

  const khaltiUrl = "https://a.khalti.com/api/v2/epayment/initiate/";

  const payload = {
    return_url: data.returnUrl,
    website_url: data.websiteUrl,
    amount: data.amount,
    purchase_order_id: data.orderId,
    purchase_order_name: data.orderName,
    customer_info: data.customerInfo,
  };

  const config = {
    headers: {
      "Authorization": `Key ${functions.config().khalti.secretkey}`,
      "Content-Type": "application/json",
    },
  };

  try {
    const response = await axios.post(khaltiUrl, payload, config);
    return response.data;
  } catch (error) {
    // eslint-disable-next-line max-len
    console.error("Khalti API error:", (error.response && error.response.data) || error.message);
    throw new functions.https.HttpsError("internal", "Khalti payment failed");
  }
});

exports.verifyKhaltiPayment = functions.https.onCall(async (data, context) => {
  const {token, amount} = data;

  if (!token || !amount) {
    // eslint-disable-next-line max-len
    throw new functions.https.HttpsError("invalid-argument", "Token and amount are required");
  }

  try {
    const response = await axios.post(
        "https://khalti.com/api/v2/payment/verify/",
        {token, amount},
        {
          headers: {
            "Authorization": `Key ${functions.config().khalti.secretkey}`,
            "Content-Type": "application/json",
          },
        },
    );
    return response.data;
  } catch (error) {
    // eslint-disable-next-line max-len
    console.error("Khalti verification error:", (error.response && error.response.data) || error.message);
    // eslint-disable-next-line max-len
    throw new functions.https.HttpsError("internal", "Payment verification failed");
  }
});
