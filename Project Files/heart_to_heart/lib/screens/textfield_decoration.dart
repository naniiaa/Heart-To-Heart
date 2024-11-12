import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String _hintText) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF2FD1CD)),
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: _hintText,
    fillColor: Colors.grey[100],
    filled: true,
  );
}