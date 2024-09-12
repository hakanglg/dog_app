import 'package:dogapp/product/utility/constants/app_constants.dart';

enum ImageItems {
  icLogo,
  frameIcon,
  helpIcon,
  houseLineIcon,
  privacyIcon,
  settingsIcon,
  rateUsIcon,
  termsIcon,
  versionIcon,
  exportIcon,
  linkIcon,
}

extension ImageItemsExtension on ImageItems {
  String _path() {
    switch (this) {
      case ImageItems.icLogo:
        return "ic_logo";
      case ImageItems.houseLineIcon:
        return 'ic_house_line';
      case ImageItems.settingsIcon:
        return 'ic_settings';
      case ImageItems.rateUsIcon:
        return 'ic_star';
      case ImageItems.versionIcon:
        return 'ic_version';
      case ImageItems.helpIcon:
        return 'ic_help';
      case ImageItems.privacyIcon:
        return 'ic_privacy';
      case ImageItems.termsIcon:
        return 'ic_terms';
      case ImageItems.exportIcon:
        return 'ic_export';
      case ImageItems.frameIcon:
        return "ic_frame";
      case ImageItems.linkIcon:
        return "ic_link";
    }
  }

  String get imagePathPng => '${ApplicationConstants.IMAGE_ASSET_PATH}/${_path()}.png';

  String get imagePathJpg => '${ApplicationConstants.IMAGE_ASSET_PATH}/${_path()}.jpg';

  String get imagePathSvg => '${ApplicationConstants.IMAGE_ASSET_PATH}/${_path()}.svg';
}
