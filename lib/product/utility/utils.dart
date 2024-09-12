import 'package:dogapp/feature/dog_detail/dog_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class Utils {
  Utils._privateConstructor();


  static final Utils _instance = Utils._privateConstructor();

  static Utils get instance => _instance;


  static bool _isDialogShowing = false;

  static void showAlert(BuildContext context, String message, String title, VoidCallback? callback) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    var alert = AlertDialog.adaptive(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              _isDialogShowing = false;
              Navigator.pop(context);
              if (callback != null) {
                callback();
              }
            },
            child: Text('Tamam', style: context.general.textTheme.bodySmall))
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return alert;
        });
  }

}