import 'package:dogapp/feature/settings/settings_screen.dart';
import 'package:dogapp/product/utility/enum/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

enum NavItem { Home, Settings }

class ProjectBottomNavigation extends StatelessWidget {
  const ProjectBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sized.dynamicHeight(0.14),
      child: CustomPaint(
        painter: CustomShapePainter(cornerRadius: 60),
        child: BottomNavigationBar(
          elevation: 0,
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
              icon: SvgPicture.asset(
                ImageItems.houseLineIcon.imagePathSvg,
              ),
              label: NavItem.Home.name,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageItems.settingsIcon.imagePathSvg,
              ),
              label: NavItem.Settings.name,
            ),
          ],
          backgroundColor: Colors.transparent, // Arka plan rengini şeffaf yapıyoruz
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  final double cornerRadius;

  CustomShapePainter({required this.cornerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(cornerRadius, 0);
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - cornerRadius, size.height);
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);
    path.lineTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
