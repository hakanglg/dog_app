import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectDivider extends StatelessWidget {
  const ProjectDivider({super.key});



  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: CupertinoColors.systemGrey5,
    );
  }
}
