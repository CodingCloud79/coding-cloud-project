import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/page/tabs/home_screen_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../../apis/credentials/razorCredentials.dart' as razorcreds;

class ActivateMembership extends StatefulWidget {
  const ActivateMembership({super.key});

  @override
  State<ActivateMembership> createState() => _ActivateMembershipState();
}

class _ActivateMembershipState extends State<ActivateMembership> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response.data);
    debugPrint("RazorPay : Payment Success ");
    // verifySignature(
    //   signature: response.signature,
    //   paymentId: response.paymentId,
    //   orderId: response.orderId,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text("Payment Successfull"),
    //   ),
    // );

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Congratulations 🎊'),
        content: const Text(
            'To become a member of Refer, learn, and earn community '),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
    debugPrint("RazorPay : Payment Failed ");

    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    debugPrint("RazorPay : External Wallet Response ");
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  void createOrder() async {
    String username = razorcreds.keyId;
    String password = razorcreds.keySecret;
    var options = {
      'key': username,
      'amout': 999,
      'name': "Coding Cloud",
      'description': "Coding Cloud Membership",
      'prefill': {
        'contact': "+911234567890",
        'email': 'codingcloud79@gmail.com'
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("$e");
    }
    // String basicAuth =
    //     'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    // Map<String, dynamic> body = {
    //   "amount": 100,
    //   "currency": "INR",
    //   "receipt": "rcptid_11"
    // };
    // var res = await http.post(
    //   Uri.https(
    //       "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
    //   headers: <String, String>{
    //     "Content-Type": "application/json",
    //     'authorization': basicAuth,
    //   },
    //   body: jsonEncode(body),
    // );

    // if (res.statusCode == 200) {
    //   openGateway(jsonDecode(res.body)['id']);
    // }
    // print(res.body);
  }

  // openGateway(String orderId) {
  //   var options = {
  //     'key': razorcreds.keyId,
  //     'amount': 100, //in the smallest currency sub-unit.
  //     'name': 'Coding Cloud ',
  //     'order_id': orderId, // Generate order_id using Orders API
  //     'description': 'Membership ',
  //     'timeout': 60 * 5, // in seconds // 5 minutes
  //     'prefill': {
  //       'contact': '9123456789',
  //       'email': 'codingCloud@example.com',
  //     }
  //   };
  //   _razorpay.open(options);
  // }

  // verifySignature({
  //   String? signature,
  //   String? paymentId,
  //   String? orderId,
  // }) async {
  //   Map<String, dynamic> body = {
  //     'razorpay_signature': signature,
  //     'razorpay_payment_id': paymentId,
  //     'razorpay_order_id': orderId,
  //   };

  //   var parts = [];
  //   body.forEach((key, value) {
  //     parts.add('${Uri.encodeQueryComponent(key)}='
  //         '${Uri.encodeQueryComponent(value)}');
  //   });
  //   var formData = parts.join('&');
  //   var res = await http.post(
  //     Uri.https(
  //       "10.0.2.2", // my ip address , localhost
  //       "razorpay_signature_verify.php",
  //     ),
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded", // urlencoded
  //     },
  //     body: formData,
  //   );

  //   print(res.body);
  //   if (res.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(res.body),
  //       ),
  //     );
  //   }
  // }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6],
            colors: [
              Color(0xFF8AD9FF),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Become a Member ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                ),
                Text(
                  "To",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color(0xFf3287BB),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Refer, Learn & Earn",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    createOrder();
                  },
                  child: const Text(" Pay Now "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
