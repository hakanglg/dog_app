import 'package:dogapp/product/utility/enum/lottie_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kartal/kartal.dart';

class LottieWidget extends StatelessWidget {
  final LottieAnimation lottie;
  final double? height;


  const LottieWidget({
    super.key,
    required this.lottie, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottie.path,
      fit: BoxFit.cover,
      height: height ?? context.sized.dynamicHeight(0.2),
    );
  }
}