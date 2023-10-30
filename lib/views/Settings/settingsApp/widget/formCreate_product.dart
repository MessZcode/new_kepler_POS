import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/base_viewmodel.dart';

class FormCreateProductView extends StatefulWidget {
  const FormCreateProductView({super.key});

  @override
  State<FormCreateProductView> createState() => _FormCreateProductViewState();
}

class _FormCreateProductViewState extends State<FormCreateProductView> {
  final GlobalKey<FormFieldState<String>> _productName =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _productPrice =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stockQty =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final settingProduct = context.read<SettingProductViewModel>();
    final watchProduct = context.watch<SettingProductViewModel>();
    final baseViewModel = context.read<BaseViewModel>();
    return AlertDialog(
      title: const Text("Create Product"),
      content: SizedBox(
        width: 700,
        height: 450,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Product Name"),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                          key: _productName,
                          controller: null,
                          initialValue: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                          initialValue: null,
                          validator: (value) {
                            if (value == null ||
                                double.tryParse(value) == null) {
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
                          initialValue: null,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("isSuggest"),
                            Switch(
                                value: watchProduct.isSuggest,
                                onChanged: (value) {
                                  setState(() {
                                    watchProduct.isSuggest = value;
                                  });
                                },
                                activeColor: theme.onBackground),
                            const Text("isPromotion"),
                            Switch(
                                value: watchProduct.isPromotion,
                                onChanged: (value) {
                                  setState(() {
                                    watchProduct.isPromotion = value;
                                  });
                                },
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
                      child: watchProduct.image != null
                          ? Image.file(
                              watchProduct.image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/imageProducts/noImageKeplerProduuct.png',
                              width: 200,
                              height: 200,
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
        ),
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
        ElevatedButton(
          onPressed: () async {
            try {
              if (_productName.currentState!.validate()) {
                watchProduct.productName =
                    _productName.currentState!.value.toString();
              }
              if (_productPrice.currentState!.validate()) {
                watchProduct.productPrice =
                    double.parse(_productPrice.currentState!.value!.toString());
              }
              if (_stockQty.currentState!.validate()) {
                watchProduct.stockQty =
                    int.parse(_stockQty.currentState!.value!.toString());
              }

              await settingProduct.saveProduct(watchProduct.image);
              await settingProduct.getAllProduct();
              await baseViewModel.getProducts();
            } catch (e) {
              throw Exception(e);
            } finally {
              Navigator.pop(context);
              settingProduct.clearValue();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.onSurface,
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
