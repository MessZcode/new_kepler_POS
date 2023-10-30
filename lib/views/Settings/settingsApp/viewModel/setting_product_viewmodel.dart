import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kepler_pos/service/service.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../models/main_model.dart';

class SettingProductViewModel with ChangeNotifier {
  final services = Services();
  List<ProductModels> product = [];
  String fileName = "keplerImage";
  File? image;
  String productName = "";
  double productPrice = 0.0;
  int stockQty = 0;
  bool isSuggest = false;
  bool isPromotion = false;

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
      // notifyListeners();
      return oneProduct;
    } catch (e) {
      throw Exception("something went wong");
    }
  }

  // Future<void> getSluItemByProductId() async {
  //   try {} catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

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

  Future<void> saveProduct(File? imageData) async {
    if(imageData != null){
      saveImageToAssetsFolder(imageData);
      // Uint8List image = await convertImageToUint8List(imageData);
      // final file = File(r'D:\Dev\Project\new_kepler_POS\assets\images\imageProducts\'+productName+fileName);
      // await file.writeAsBytes(image);
    }
    await saveNewProductToDB();
  }

  Future<Uint8List> convertImageToUint8List(File imageFile) async {
    Uint8List uint8list = await imageFile.readAsBytes();
    return uint8list;
  }

  Future<void> getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      fileName = pickedFile.name;
      notifyListeners();
    } else {
      print("no image selected");
    }
  }
  Future<void> saveImageToAssetsFolder(File imageFile) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String assetsFolder = '${appDocumentsDirectory.path}/assets';

    if (!Directory(assetsFolder).existsSync()) {
      Directory(assetsFolder).createSync(recursive: true);
    }
    String filePath = '$assetsFolder/${productName+fileName}';

    imageFile.copySync(filePath);
  }
  Future<void> saveNewProductToDB() async {

    ProductModels newProduct = ProductModels(
        productId: 0,
        productName: productName,
        productPrice: productPrice,
        imageUrl: image,
        stockQTY: stockQty,
        isSuggest: isSuggest,
        isPromotion: isPromotion,
    );
    try{
      await services.createNewProduct(newProduct: newProduct);
    }catch(e){
      throw Exception(e);
    }
  }

  void clearValue(){
    image = null;
    productName = "";
    productPrice = 0.0;
    stockQty = 0;
    isSuggest = false;
    isPromotion = false;
    notifyListeners();
  }

  Future<void> clearProductByOne({required int productId}) async{

  }

  Future<void> saveEditProduct({required ProductModels newProductModel}) async {
    try {
       // saveImageToAssetsFolder();
      // await services.saveEditProduct(newProductModel: newProductModel);
    } catch (e) {
      throw Exception(e);
    }
  }
}
