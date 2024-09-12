import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:dogapp/product/utility/mixin/mounted_mixin.dart';
import 'package:dogapp/product/utility/utils.dart';
import 'package:dogapp/product/widget/button/cornered_icon_button.dart';
import 'package:dogapp/product/widget/button/normal_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
part 'generate_button_mixin.dart';

final class GenerateButton extends StatefulWidget {
  const GenerateButton({super.key, this.breed});

  final String? breed;

  @override
  State<GenerateButton> createState() => _GenerateButtonState();
}

class _GenerateButtonState extends State<GenerateButton>
    with MountedMixin, _GenerateButtonMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isLoadingNotifier,
        builder: (BuildContext context, bool value, Widget? child) {
          if (value) {
            return const CircularProgressIndicator.adaptive();
          } else {
            return NormalButton(
              title: 'Generate',
              onPressed: () async {
                await _onPressed(context);
              },
            );
          }
        });
  }
}
