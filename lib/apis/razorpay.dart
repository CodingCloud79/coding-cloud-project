import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import './credentials/razorCredentials.dart' as razorcreds;
class RazorPayIntegration {
  final Razorpay _razorpay = Razorpay();

  
  initiateRazorPay() { 
   // To handle different event with previous functions  
   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess); 
   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError); 
   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet); 
 } 

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
