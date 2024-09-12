import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

/// radius is 32
final class NormalButton extends StatelessWidget {

  const NormalButton(
      {required this.title, required this.onPressed, super.key, this.width, this.height});

  /// title text
  final String title;

  /// button on pressed
  final VoidCallback onPressed;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(ProjectRadius.large.value)),
      child: CupertinoButton(
        color: CupertinoColors.systemBlue,
        onPressed: onPressed,
        child: Text(
          title,
          style: context.general.textTheme.titleMedium!
              .copyWith(color: CupertinoColors.white),
        ),
      ),
    );
  }
}
