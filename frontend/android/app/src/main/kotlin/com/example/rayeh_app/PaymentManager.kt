//package com.rayeh.app
//
//import java.net.HttpURLConnection
//import java.net.URL
//import java.net.URLEncoder
//import java.io.InputStreamReader
//import android.util.JsonReader
//object PaymentManager {
////    class PaymentManager {
//        fun requestCheckoutId(urlString: String, amount: String, currency: String, paymentType: String): String? {
//        val url: URL
//        var connection: HttpURLConnection? = null
//        var checkoutId: String? = null
//
//        val fullUrl = "$urlString?amount=$amount&currency=$currency&paymentType=$paymentType"
//
//        try {
//            url = URL(fullUrl)
//            connection = url.openConnection() as HttpURLConnection
//
//            val reader = JsonReader(InputStreamReader(connection.inputStream, "UTF-8"))
//            reader.beginObject()
//
//            while (reader.hasNext()) {
//                if (reader.nextName() == "checkoutId") {
//                    checkoutId = reader.nextString()
//                    break
//                }
//            }
//
//            reader.endObject()
//            reader.close()
//        } catch (e: Exception) {
//            /* error occurred */
//        } finally {
//            connection?.disconnect()
//        }
//
//        return checkoutId
//    }
//
//    fun requestPaymentStatus(urlString: String, resourcePath: String): String? {
//        val url: URL
//        var connection: HttpURLConnection? = null
//        var paymentStatus: String? = null
//
//        val urlString = urlString + "/paymentStatus?resourcePath=" + URLEncoder.encode(resourcePath, "UTF-8")
//
//        try {
//            url = URL(urlString)
//            connection = url.openConnection() as HttpURLConnection
//
//            val jsonReader = JsonReader(InputStreamReader(connection.inputStream, "UTF-8"))
//            jsonReader.beginObject()
//
//            while (jsonReader.hasNext()) {
//                if (jsonReader.nextName() == "paymentResult") {
//                    paymentStatus = jsonReader.nextString()
//                    break
//                }
//            }
//
//            jsonReader.endObject()
//            jsonReader.close()
//        } catch (e: Exception) {
//            /* error occurred */
//        } finally {
//            connection?.disconnect()
//        }
//
//        return paymentStatus
//    }
//}