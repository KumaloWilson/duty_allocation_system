import 'package:flutter_dotenv/flutter_dotenv.dart';

class WooCommerceConfig {
  static String baseUrl = dotenv.env['WOOCOMMERCE_BASE_URL'].toString();
  static String consumerKey = dotenv.env['WOOCOMMERCE_CONSUMER_KEY'].toString();
  static String consumerSecret = dotenv.env['WOOCOMMERCE_SECRET_KEY'].toString();
}
