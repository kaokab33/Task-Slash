import 'package:dio/dio.dart';
import 'package:slash/models/all_products.dart';

class GetProuducts {
  final String url = 'https://slash-backend.onrender.com/product';
  Dio dio = Dio();
  Future<List<AllProudcts>> getProducts(int page) async {
    final response = await dio.get('$url?limit=20&page=$page');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsondata = response.data;
      List<dynamic> allData = jsondata['data'];
      List<AllProudcts> allProducts = [];
      for (int i = 0; i < allData.length; i++) {
        AllProudcts product = AllProudcts.fromJson(allData[i]);
        allProducts.add(product);
      }
      return allProducts;
    } else {
      throw "Can't get products.";
    }
  }
}
