import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/main/main_screen.dart';
import 'package:dogapp/product/utility/enum/image_enum.dart';
import 'package:dogapp/product/widget/divider.dart';
import 'package:dogapp/product/widget/draggable_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

part 'settings_screen_mixin.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with _SettingsScreenMixin {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _bodySection(scrollController),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const SizedBox(),
      title: const DraggableDivider(),
    );
  }

  Widget _bodySection(ScrollController scrollController) {
    return ValueListenableBuilder<List<_SettingsItem>>(
        valueListenable: _settingsItemsNotifier,
        builder: (BuildContext context, List<_SettingsItem> value, Widget? child) {
          if (value.isNotEmpty) {
            return ListView.builder(
              controller: scrollController,
              itemCount: value.length,
              itemBuilder: (context, index) {
                final _SettingsItem settingsItem = value[index];
                return Column(
                  children: [
                    _buildSettingsTile(
                      imageItem: settingsItem.imageItem,
                      title: settingsItem.title,
                      onTap: settingsItem.onTap,
                      trailing: settingsItem.trailing,
                    ),
                    Padding(
                        padding: context.padding.onlyLeftNormal,
                        child: const ProjectDivider()),
                  ],
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _buildSettingsTile({
    required ImageItems imageItem,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        imageItem.imagePathSvg,
        fit: BoxFit.contain,
      ),
      title: Text(title),
      onTap: onTap,
      trailing: trailing ??
          SvgPicture.asset(
            ImageItems.linkIcon.imagePathSvg,
            fit: BoxFit.contain,
          ),
    );
  }
}



class _SettingsItem {
  final ImageItems imageItem;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const _SettingsItem({
    required this.imageItem,
    required this.title,
    required this.onTap,
    this.trailing,
  });
}
