import 'package:flutter/cupertino.dart';
class DraggableDivider extends StatelessWidget {
  const DraggableDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey3,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}