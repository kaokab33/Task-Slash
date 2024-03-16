import 'package:dio/dio.dart';
import 'package:slash/models/product.dart';

class GetDetails {
  final String url = 'https://slash-backend.onrender.com/product';
  Dio dio = Dio();
  Future<Product> getDetails(int id) async {
    try {
      final response = await dio.get('$url/$id');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsondata = response.data;
        Product product = Product.fromJson(jsondata['data']);
        return product;
      } else {
        throw "Can't get product.";
      }
    } on Exception {
      rethrow;
    }
  }
}
