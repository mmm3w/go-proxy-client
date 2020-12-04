
import 'package:flutter/material.dart';

textDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[350]),
      borderRadius: BorderRadius.circular(4),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
  );
}

titleText(String title) {
  return Text(
    title,
    maxLines: 1,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: Colors.blue,
      fontSize: 18.0,
    ),
  );
}

snackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}