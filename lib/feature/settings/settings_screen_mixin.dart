part of 'settings_screen.dart';

mixin _SettingsScreenMixin on State<SettingsScreen> {
  static const _platform = MethodChannel('com.hakangolge.dogapp/os_version');

  final ValueNotifier<String> _osVersionNotifier =
      ValueNotifier<String>("Unknown OS Version");
  final ValueNotifier<List<_SettingsItem>> _settingsItemsNotifier =
      ValueNotifier<List<_SettingsItem>>([]);

  @override
  void initState() {
    super.initState();
    _getOSVersion();
  }

  Future<void> _getOSVersion() async {
    String os;
    try {
      final String result = await _platform.invokeMethod('getOSVersion');
      os = result;
    } on PlatformException catch (e) {
      os = "Failed to get OS version: '${e.message}'.";
    }

    _osVersionNotifier.value = os;
    _settingsItemsNotifier.value = _buildSettingsItems();
  }

  List<_SettingsItem> _buildSettingsItems() {
    return [
      _SettingsItem(
        imageItem: ImageItems.helpIcon,
        title: 'Help',
        onTap: () {
          // Navigate to Help
        },
      ),
      _SettingsItem(
        imageItem: ImageItems.rateUsIcon,
        title: 'Rate Us',
        onTap: () {
          // Navigate to Rate Us
        },
      ),
      _SettingsItem(
        imageItem: ImageItems.exportIcon,
        title: 'Share with Friends',
        onTap: () {
          // Navigate to Share with Friends
        },
      ),
      _SettingsItem(
        imageItem: ImageItems.termsIcon,
        title: 'Terms of Use',
        onTap: () {
          // Navigate to Terms of Use
        },
      ),
      _SettingsItem(
        imageItem: ImageItems.privacyIcon,
        title: 'Privacy Policy',
        onTap: () {
          // Navigate to Privacy Policy
        },
      ),
      _SettingsItem(
        imageItem: ImageItems.versionIcon,
        title: 'OS Version',
        onTap: () {},
        trailing: ValueListenableBuilder<String>(
          valueListenable: _osVersionNotifier,
          builder: (context, osVersion, child) {
            return Text(osVersion);
          },
        ),
      ),
    ];
  }
}
