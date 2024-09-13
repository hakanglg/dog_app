// lottie_enum.dart
import 'package:dogapp/product/utility/constants/app_constants.dart';

enum LottieAnimation {
  splash,
}

extension LottieAnimationExtension on LottieAnimation {
  String _path() {
    switch (this) {
      case LottieAnimation.splash:
        return 'splash';
    }
  }

  String get path => '${ApplicationConstants.LOTTIE_ASSET_PATH}/lottie_${_path()}.json';
}
