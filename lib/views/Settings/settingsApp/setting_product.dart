import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_product_viewmodel.dart';
import 'package:kepler_pos/views/Settings/settingsApp/widget/formCreate_product.dart';
import 'package:kepler_pos/views/Settings/settingsApp/widget/formEdit_product.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class SettingProductView extends StatefulWidget {
  const SettingProductView({super.key});

  @override
  State<SettingProductView> createState() => _SettingProductViewState();
}

class _SettingProductViewState extends State<SettingProductView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(15),
              ),
              backgroundColor: MaterialStatePropertyAll(Colors.black12),
            ),
            onPressed: () {
              showDialog(context: context, builder: (context) => const FormCreateProductView(),);
            },
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
        ),
        FutureBuilder(
          future: context.read<SettingProductViewModel>().getAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final productList =
                  context.watch<SettingProductViewModel>().product;
              return Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 50,
                    dataRowMaxHeight: 120,
                    showBottomBorder: true,
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Text("Image"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("product name"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("price"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("stock"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("isSuggest"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("isPromotion"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Edit"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Delete"),
                        ),
                      ),
                    ],
                    rows: List.generate(productList.length, (index) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Image.asset(
                              'assets/images/imageProducts/${productList[index].imageUrl}',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 70,
                            ),
                          ),
                          DataCell(
                            Text(productList[index].productName),
                          ),
                          DataCell(
                            Text(productList[index]
                                .productPrice
                                .toStringAsFixed(2)),
                          ),
                          DataCell(
                            Text(productList[index].stockQTY.toString()),
                          ),
                          DataCell(
                            Switch(value: productList[index].isSuggest, onChanged: (value) {},activeColor: theme.onBackground),
                          ),
                          DataCell(
                            Switch(value: productList[index].isPromotion, onChanged: (value) {},activeColor: theme.onBackground),
                          ),
                          DataCell(
                            InkWell(
                              onTap: () {
                                showDialog(context: context, builder: (context) => FromEditProductView(productId: productList[index].productId),);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                  size: 24.0, // ตั้งค่าขนาดไอคอน
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            InkWell(
                              onTap: () {
                                // context.read<SettingUserViewModel>().deleteUserById(userId: snapshot.data![index].userId);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Text("something went wrong");
            }
            return SizedBox(
              width: 20,
              height: 20,
              child: LoadingIndicator(
                indicatorType: Indicator.lineSpinFadeLoader,
                colors: [theme.onPrimary],
              ),
            );
          },
        ),
      ],
    );
  }
}
