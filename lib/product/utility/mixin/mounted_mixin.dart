import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Stateful widget mixin to check async operations if the widget is mounted
mixin MountedMixin<T extends StatefulWidget> on State<T> {

  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    await callback.call();
  }
}