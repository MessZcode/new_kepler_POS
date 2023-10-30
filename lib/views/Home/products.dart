import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/utils/assets_Images.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';

//
class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModels>(context, listen: false).filterProductByCategory();
  }

  @override
  Widget build(BuildContext context) {
    final filterProduct = context.watch<HomeViewModels>().filterProducts;
    final billDetail = context.watch<HomeViewModels>().billDetail;
    final theme = Theme.of(context).colorScheme;
    final ScrollController controller = ScrollController();
    final screen = MediaQuery.of(context).size;

    return GridView.builder(
      itemCount: filterProduct.length,
      padding: EdgeInsets.only(right: screen.width * 0.01),
      controller: controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: screen.height * 0.015,
        crossAxisSpacing: screen.width * 0.01,
        childAspectRatio: 262 / 338,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          hoverColor: theme.onError,
          onTap: () => context.read<HomeViewModels>().onTapProduct(filterProduct[index].productId),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildProduct(context: context, index: index),
              if (billDetail.where((element) => element.productId == filterProduct[index].productId).isNotEmpty)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: screen.width * 0.035,
                    height: screen.height * 0.065,
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screen.height * 0.02),
                      ),
                    ),
                    child: FittedBox(
                      child: Icon(
                        Icons.check,
                        color: theme.background,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProduct({required BuildContext context, required int index}) {
    final theme = Theme.of(context).colorScheme;
    final billDetail = context.watch<HomeViewModels>().billDetail;
    final filterProduct = context.watch<HomeViewModels>().filterProducts;
    final screen = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(screen.height * 0.015),
      decoration: ShapeDecoration(
        color: theme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(screen.height * 0.01)),
          side: billDetail.where((billDetail) => billDetail.productId == filterProduct[index].productId).isNotEmpty
              ? BorderSide(width: 2, color: theme.secondary)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              // child: Image.file(
              //   // 'assets/Image2.png',
              //   filterProduct[index].imageUrl != null?File('${ImageAssets.productImagePath}/${'noImageKeplerProduuct.png'}'):
              //   File('C:/Users/Poram/OneDrive/Documents/assets/${filterProduct[index].imageUrl}'),
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      filterProduct[index].productName,
                      minFontSize: 1,
                      maxFontSize: 24,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: theme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      '${filterProduct[index].productPrice} ฿',
                      minFontSize: 1,
                      maxFontSize: 18,
                      maxLines: 1,
                      style: TextStyle(
                        color: theme.onBackground,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
