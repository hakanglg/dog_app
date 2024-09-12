import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:flutter/material.dart';

class CorneredIconButton extends StatelessWidget {
  const CorneredIconButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white, // Arka plan rengini beyaz yapma
        shape: BoxShape.rectangle, // Köşeli yapmak için
        borderRadius: BorderRadius.circular(ProjectRadius.small.value), // Köşe yuvarlatmaları
      ),
      child: Center(
        child: FittedBox(
          child: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black, // İkon rengini siyah yapma
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
