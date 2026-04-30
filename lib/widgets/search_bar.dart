import 'package:flutter/material.dart';
import '../core/theme/app_color.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String hintText;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = "Search",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(Icons.search, color: AppColor.grey),

        filled: true,
        fillColor: AppColor.lighter,

        contentPadding: const EdgeInsets.symmetric(vertical: 4),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
