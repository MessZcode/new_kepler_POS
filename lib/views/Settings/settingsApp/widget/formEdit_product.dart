import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_product_viewmodel.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class FromEditProductView extends StatefulWidget {
  const FromEditProductView({super.key, required this.productId});
  final int productId;
  @override
  State<FromEditProductView> createState() => _FromEditProductViewState();
}

class _FromEditProductViewState extends State<FromEditProductView> {
  final GlobalKey<FormFieldState<String>> _productName =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<double>> _productPrice =
      GlobalKey<FormFieldState<double>>();
  final GlobalKey<FormFieldState<String>> _stockQty =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text("Edit Product"),
      actions: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: theme.onPrimary,
          ),
          child: const Text("Submit"),
        ),
      ],
      content: SizedBox(
        width: 700,
        height: 450,
        child: FutureBuilder(
            future: context
                .read<SettingProductViewModel>()
                .getProductByOne(productId: widget.productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                              _buildTextFormField(
                                  key: _productName,
                                  controller: null,
                                  initialValue: snapshot.data!.productName),
                              const Text("Product price"),
                              _buildTextFormField(
                                key: _productPrice,
                                controller: null,
                                initialValue: snapshot.data!.productPrice
                                    .toStringAsFixed(2),
                              ),
                              const Text("stock"),
                              _buildTextFormField(
                                key: _stockQty,
                                controller: null,
                                initialValue:
                                    snapshot.data!.stockQTY.toString(),
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
                              child: Image.asset(
                                  'assets/images/imageProducts/${snapshot.data!.imageUrl}'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // กระทำเมื่อปุ่มถูกกด
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
    );
  }

  Widget _buildTextFormField(
      {required Key key,
      required TextEditingController? controller,
      required String? initialValue}) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: TextFormField(
        key: key,
        controller: controller,
        initialValue: initialValue,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
