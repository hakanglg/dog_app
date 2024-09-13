import 'package:dogapp/product/utility/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const DefaultAppbar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? ApplicationConstants.appName,
        style: context.general.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
