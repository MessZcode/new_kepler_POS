import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';

import '../../../widgets/Keyboard/keyboard.dart';

//
class SearchKeyboard extends StatefulWidget {
  const SearchKeyboard({super.key});

  @override
  State<SearchKeyboard> createState() => _SearchKeyboardState();
}

class _SearchKeyboardState extends State<SearchKeyboard> {
  @override
  Widget build(BuildContext context) {
    final homeviewmodel = Provider.of<HomeViewModels>(context);
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final home = Provider.of<HomeViewModels>(context);
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: theme.surface,
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(2),
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(),
            IconButton(
                onPressed: () {
                  home.tapStatusTextFeild(false);
                },
                icon: Icon(
                  Icons.close,
                  color: theme.background,
                ))
          ]),
          content: SizedBox(
            width: screen.width * 0.83,
            height: screen.height * 0.35,
            child: Keyboard(
              value: (String value) {
                homeviewmodel.getvaluekeyboard(value);
              },
              Bgcolorkeynumber: theme.onSurface,
              Textcolorkeynumber: theme.background,
            ),
          ),
        ),
      ],
    );
  }
}
