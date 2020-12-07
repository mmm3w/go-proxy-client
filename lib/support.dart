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

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 400),
  ));
}

final loadingDialog = AlertDialog(
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [CircularProgressIndicator()],
  ),
);

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, //点击遮罩不关闭对话框
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        ),
      );
    },
  );
}
