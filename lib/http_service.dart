import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class HttpService {
  final String productsURL = "http://127.0.0.1:8000/api/products";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(productsURL));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse['data'];
      List<Product> products = body
          .map(
            (dynamic item) => Product.fromJson(item),
          )
          .toList();

      return products;
    } else {
      throw "Failed to load products: ${response.statusCode}";
    }
  }
}