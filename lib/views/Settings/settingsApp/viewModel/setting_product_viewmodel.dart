import 'package:flutter/widgets.dart';
import 'package:kepler_pos/service/service.dart';

import '../../../../models/main_model.dart';

class SettingProductViewModel with ChangeNotifier {
  final services = Services();
  List<ProductModels> product = [];

  Future<ProductModels> getProductByOne({required int productId}) async {
      ProductModels oneProduct = ProductModels.initial();
    try {
      final results = await services.getproductByOne(productId: productId);
      if (results!.isEmpty) {
        throw Exception("something went wong");
      }
      oneProduct = ProductModels(
        productId: results.first[0],
        productName: results.first[1],
        productPrice: double.parse(results.first[2]),
        imageUrl: results.first[3],
        stockQTY: results.first[4],
        isSuggest: results.first[5],
        isPromotion: results.first[6],
      );
      notifyListeners();
      return oneProduct;
    } catch (e) {
      throw Exception("something went wong");
    }
  }

  Future<void> getSluItemByProductId() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<ProductModels>> getAllProduct() async {
    product.clear();
    try {
      final results = await services.fetchDataFromTable('products');
      if (results!.isEmpty) {
        return [];
      }
      product.addAll(results.map((row) {
        return ProductModels(
          productId: row[0],
          productName: row[1],
          productPrice: double.parse(row[2]),
          imageUrl: row[3],
          stockQTY: row[4],
          isSuggest: row[5],
          isPromotion: row[6],
        );
      }));
      notifyListeners();
      return product;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
