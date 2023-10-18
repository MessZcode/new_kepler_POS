import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Home/products.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
//
import 'package:provider/provider.dart';
import '../../ViewModel/base_viewmodel.dart';
import '../../widgets/ShowDedail/show_detail.dart';
import '../../widgets/searchfeild.dart';
import 'Category.dart';
import 'dialog/search_keyboard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return _buildRow();
  }

  Widget _buildRow() {
    final home = Provider.of<HomeViewModels>(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            home.tapStatusTextFeild(false);
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildColumn(),
                ),
              ),
              const ShowDetail(),
            ],
          ),
        ),
        if (home.statusTextFeild == true) const Positioned(bottom: 0, left: 0, right: 0, child: SearchKeyboard()),
      ],
    );
  }

  Widget _buildColumn() {
    final theme = Theme.of(context).colorScheme;
    final _user = context.watch<BaseViewModel>().profile.fname;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(
                "Hi!! $_user",
                maxLines: 1,
                minFontSize: 1,
                maxFontSize: 32,
                overflowReplacement: const ClipRRect(),
                style: TextStyle(
                  fontSize: 32,
                  color: theme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // Spacer(),
            const Expanded(
              flex: 1,
              child: SearchField(),
            ),
          ],
        ),
        const Categories(),
        const Expanded(
          child: Products(),
        ),
      ],
    );
  }
}
