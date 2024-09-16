import 'package:app_prestamos/styles/colors.dart';
import 'package:flutter/material.dart';

Widget subtitleWidget(String titulo, TextEditingController controller) {
  final subtitle = controller;
  final FocusNode focusNode = FocusNode();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        maxLines: 5,
        controller: subtitle,
        focusNode: focusNode,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: titulo,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: greyColor, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: greyColor, width: 2.0))),
      ),
    ),
  );
}
