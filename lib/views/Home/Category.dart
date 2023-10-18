import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/base_viewmodel.dart';

//
class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    final theme = Theme.of(context).colorScheme;
    final category = context.watch<BaseViewModel>().category;
    final selectcategory = context.watch<HomeViewModels>().selectCategoryId;
    final screen = MediaQuery.of(context).size;
    return SizedBox(
      height: screen.height * 0.115,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  context.read<HomeViewModels>().onPressedCategoryId(category[index].categoryId);
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor:
                    selectcategory.contains(category[index].categoryId) ? theme.onBackground : theme.onError,
              ),
              child: Text(
                category[index].categoryName,
                style: TextStyle(
                  color: selectcategory.contains(category[index].categoryId) ? theme.background : theme.onPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
