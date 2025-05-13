import 'package:car_rental/core/constants/api_keys.dart';
import 'package:dio/dio.dart';

class PaymentIntegration {
  final Dio _dio = Dio();

  Future<String> getPaymentKey({
    required int amount,
    required String currency,
  }) async {
    try {
      // 1. Get auth token
      String authToken = await _getAuthToken();
      print('Auth Token: $authToken');

      // 2. Get order ID
      int orderId = await _getOrderId(
        authToken: authToken,
        amountCents: (amount * 100).toString(),
      );
      print('Order ID: $orderId');

      // 3. Get payment key
      String paymentKey = await _getFinalPaymentKey(
        authToken: authToken,
        orderId: orderId,
        amountCents: (amount * 100).toString(),
        currency: currency,
      );
      print('Payment Key: $paymentKey');

      return paymentKey;
    } catch (e) {
      print('Error in getPaymentKey: $e');
      throw Exception("error getting payment_key: $e");
    }
  }

  Future<String> _getAuthToken() async {
    try {
      final response = await _dio.post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {
          'api_key': ApiKeys.paymentKey,
        },
      );
      return response.data['token'];
    } catch (e) {
      if (e is DioException) {
        print('Error in _getAuthToken: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get auth token: $e');
    }
  }

  Future<int> _getOrderId({
    required String authToken,
    required String amountCents,
  }) async {
    try {
      final response = await _dio.post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token": authToken,
          "delivery_needed": "false",
          "amount_cents": amountCents,
          "currency": "EGP",
          "items": [],
        },
      );
      return response.data['id'];
    } catch (e) {
      if (e is DioException) {
        print('Error in _getOrderId: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get order ID: $e');
    }
  }

  Future<String> _getFinalPaymentKey({
    required String authToken,
    required int orderId,
    required String amountCents,
    required String currency,
  }) async {
    try {
      final response = await _dio.post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "auth_token": authToken,
          "amount_cents": amountCents,
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "NA",
            "email": "test@example.com",
            "floor": "NA",
            "first_name": "Test",
            "street": "NA",
            "building": "NA",
            "phone_number": "+20123456789", // عدلت الرقم ليبدأ بكود الدولة
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": "User",
            "state": "NA"
          },
          "currency": currency,
          "integration_id": ApiKeys.integrationId, // استبدل بـ integration_id الصحيح من Paymob
        },
      );
      return response.data['token'];
    } catch (e) {
      if (e is DioException) {
        print('Error in _getFinalPaymentKey: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get payment key: $e');
    }
  }
}