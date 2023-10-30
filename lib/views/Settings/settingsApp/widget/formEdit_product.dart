import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kepler_pos/models/main_model.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_product_viewmodel.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../utils/assets_Images.dart';

class FromEditProductView extends StatefulWidget {
  const FromEditProductView({super.key, required this.productId});
  final int productId;
  @override
  State<FromEditProductView> createState() => _FromEditProductViewState();
}

class _FromEditProductViewState extends State<FromEditProductView> {
  final GlobalKey<FormFieldState<String>> _productName =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _productPrice =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stockQty =
      GlobalKey<FormFieldState<String>>();

  String imageProduct = "";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final settingProduct = context.read<SettingProductViewModel>();
    final watchProduct = context.watch<SettingProductViewModel>();

    return AlertDialog(
      title: const Text("Edit Product"),
      content: SizedBox(
        width: 700,
        height: 450,
        child: FutureBuilder(
            future: context
                .read<SettingProductViewModel>()
                .getProductByOne(productId: widget.productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // imageProduct = sna;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Product Name"),
                              SizedBox(
                                width: double.infinity,
                                height: 70,
                                child: TextFormField(
                                  key: _productName,
                                  controller: null,
                                  initialValue: snapshot.data!.productName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter product name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Text("Product price"),
                              SizedBox(
                                width: double.infinity,
                                height: 70,
                                child: TextFormField(
                                  key: _productPrice,
                                  controller: null,
                                  initialValue: snapshot.data!.productPrice.toString(),
                                  validator: (value) {
                                    if (value == null || double.tryParse(value) == null) {
                                      return 'price is not correct';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Text("stock"),
                              SizedBox(
                                width: double.infinity,
                                height: 70,
                                child: TextFormField(
                                  key: _stockQty,
                                  controller: null,
                                  initialValue: snapshot.data!.stockQTY.toString(),
                                  validator: (value) {
                                    if (value == null || int.tryParse(value) == null) {
                                      return 'number is not correct';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text("isSuggest"),
                                    Switch(
                                        value: snapshot.data!.isSuggest,
                                        onChanged: (value) {},
                                        activeColor: theme.onBackground),
                                    const Text("isPromotion"),
                                    Switch(
                                        value: snapshot.data!.isPromotion,
                                        onChanged: (value) {},
                                        activeColor: theme.onBackground),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 300,
                            child: Center(
                              child: Image.file(
                                watchProduct.image != null
                                    ? File(watchProduct.image!.path)
                                    : snapshot.data!.imageUrl!= null
                                        ? File(
                                            '${ImageAssets.productImagePath}/noImageKeplerProduuct.png')
                                        : File(
                                            'C:/Users/Poram/OneDrive/Documents/assets/${snapshot.data!.imageUrl}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await settingProduct.getImage();
                            },
                            child: const Text("Change Image"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    colors: [theme.onPrimary],
                  ),
                ),
              );
            }),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            settingProduct.clearValue();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          label: const Text("cancle"),
        ),
        TextButton(
          onPressed: () async {
            print("HEAR");
            try {
              print("HEAR2");
              if (_productName.currentState!.validate()) {
                watchProduct.productName =
                    _productName.currentState!.value.toString();
              }
              print("HEAR3");
              if (_productPrice.currentState!.validate()) {
                watchProduct.productPrice =
                    double.parse(_productPrice.currentState!.value!.toString());
              }
              print("HEAR4");
              if (_stockQty.currentState!.validate()) {
                watchProduct.stockQty =
                    int.parse(_stockQty.currentState!.value!.toString());
              }
              if(watchProduct.image != null){
                imageProduct = watchProduct.fileName;
              }
              // await settingProduct.saveProduct(watchProduct.image);
              // await settingProduct.getAllProduct();
              // await baseViewModel.getProducts();
              print("check Success");
              print("check Success : ${widget.productId}");
              print("check Success : ${watchProduct.productName}");
              print("check Success : ${watchProduct.productPrice}");
              print("check Success : $imageProduct");
              print("check Success : ${watchProduct.stockQty}");
              print("check Success : ${watchProduct.isSuggest}");
              print("check Success : ${watchProduct.isPromotion}");

              ProductModels newProductModel = ProductModels(
                      productId: widget.productId,
                      productName: watchProduct.productName,
                      productPrice: watchProduct.productPrice,
                      imageUrl: null,
                      stockQTY: watchProduct.stockQty,
                      isSuggest: watchProduct.isSuggest,
                      isPromotion: watchProduct.isPromotion);
              await settingProduct.saveEditProduct(newProductModel: newProductModel);
            } catch (e) {
              throw Exception(e);
            } finally {
              Navigator.pop(context);
              settingProduct.clearValue();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: theme.onPrimary,
          ),
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
