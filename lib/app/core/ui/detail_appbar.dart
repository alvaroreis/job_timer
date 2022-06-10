import 'package:flutter/material.dart';

class DetailAppBar extends AppBar {
  DetailAppBar({super.key, required Color backgroundColor, String? title})
      : super(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: backgroundColor,
            centerTitle: true,
            title: Text(
              title ?? '',
              style: const TextStyle(color: Colors.black),
            ));
}
