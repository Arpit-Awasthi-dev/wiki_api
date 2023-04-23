import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/wiki_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final _controller = TextEditingController();
  final Function(String) onSearch;
  final _searchSubject = PublishSubject<String>();

  void _debounceListener() {
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 350))
        .listen((searchText) {
      onSearch(searchText);
    });
  }

  TextFieldWidget({
    required this.onSearch,
    Key? key,
  }) : super(key: key) {
    _debounceListener();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        isDense: true,
        label: const Text(
          'Label',
          style: TextStyle(
            color: WikiColors.textSubtitleColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: WikiColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.redAccent.shade100,
          ),
        ),
      ),
      onChanged: (String value) {
        _searchSubject.add(value);
      },
    );
  }
}
