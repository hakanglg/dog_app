import 'package:dogapp/feature/settings/settings_screen.dart';
import 'package:dogapp/product/utility/enum/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum NavItem { Home, Settings }

class ProjectBottomNavigation extends StatelessWidget {
  const ProjectBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 1) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const SettingsScreen();
            },
          );
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageItems.houseLineIcon.imagePathSvg),
          label: NavItem.Home.name,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageItems.settingsIcon.imagePathSvg),
          label: NavItem.Settings.name,
        ),
      ],
    );
  }
}