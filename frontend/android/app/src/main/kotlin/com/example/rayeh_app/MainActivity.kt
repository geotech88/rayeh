package com.rayeh.app
//package com.example.rayeh_app

//import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResult
//import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
//import com.oppwa.mobile.connect.provider.Connect
//
//import androidx.annotation.NonNull
//import androidx.appcompat.app.AppCompatActivity
//import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResultContract
import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//import com.rayeh.app.PaymentManager.requestCheckoutId
//import com.rayeh.app.PaymentManager.requestPaymentStatus


class MainActivity: FlutterActivity() {
//class MainActivity: AppCompatActivity() {

//    private val CHANNEL = "com.rayeh.app/hyperpay"
//
////    private val checkoutLauncher = registerForActivityResult(CheckoutActivityResultContract()) {
////        result: CheckoutActivityResult -> handleCheckoutResult(result)
////    }
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // Note: this method is invoked on the main thread.
//            call, result ->
//            if (call.method == "requestCheckoutId") {
//                val url = call.argument<String>("url")
//                val amount = call.argument<String>("amount")
//                val currency = call.argument<String>("currency")
//                val paymentType = call.argument<String>("paymentType")
//                if (url != null && amount != null && currency != null && paymentType != null) {
//                    val checkoutId = requestCheckoutId(url, amount, currency, paymentType)
//                    result.success(checkoutId)
//                } else {
//                    result.error("UNAVAILABLE", "Some parameters are null.", null)
//                }
//            } else if (call.method == "requestPaymentStatus") {
//                val url = call.argument<String>("url")
//                val resourcePath = call.argument<String>("resourcePath")
//                if (url != null && resourcePath != null) {
//                    val paymentStatus = requestPaymentStatus(url, resourcePath)
//                    result.success(paymentStatus)
//                } else {
//                    result.error("UNAVAILABLE", "Some parameters are null.", null)
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun startCheckout(checkoutId: String) {
//        val paymentBrands = hashSetOf("VISA", "MASTER", "DIRECTDEBIT_SEPA")
////        TODO: here when we will make the app in the production we need to change the ProviderMode to LIVE
//        val checkoutSettings = CheckoutSettings(checkoutId, paymentBrands, Connect.ProviderMode.TEST)
////        checkoutSettings.shopperResultUrl = "companyname://result"
//
////        checkoutLauncher.launch(checkoutSettings)
//    }
//
//    private fun handleCheckoutResult(result: CheckoutActivityResult) {
//        if (result.isCanceled) {
//            // shopper cancelled the checkout process
//            return
//        }
//
//        val resourcePath = result.resourcePath
//
//        if (resourcePath != null) {
//            // get the payment status using the resourcePath
//        }
//    }
//
//    private fun startPayment() {
//        // Start HyperPay payment here
//    }
}
