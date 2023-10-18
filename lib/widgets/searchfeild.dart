import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final home = Provider.of<HomeViewModels>(context);

    return Stack(
      children: [
        TextField(
          showCursor: true,
          readOnly: true,
          controller: home.controller,
          onTap: () {
            home.tapStatusTextFeild(true);
          },
          cursorColor: theme.onBackground,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.background,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 0.7, color: theme.onSecondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 0.7, color: theme.onBackground),
            ),
            hintText: "Search...",
            hintStyle: TextStyle(color: theme.onPrimary),
            suffixIcon: Icon(
              Icons.search,
              size: 25,
              color: theme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
