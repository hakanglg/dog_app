import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:dogapp/feature/dog_detail/dog_detail_view.dart';
import 'package:dogapp/product/utility/extension/string_extension.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/utility/enum/project_enums.dart';

class DogCard extends StatelessWidget {
  const DogCard({super.key, required this.breed});

  final Breed breed;

  void _showDogDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => DogDetailPreview(item: breed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDogDetail(context),
      child: Stack(
        children: [
          _buildDogImage(context),
          Positioned(
            bottom: 0,
            left: 0,
            child: _buildDogTitle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDogImage(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
        child: Image.network(breed.imageUrl ?? '', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDogTitle(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(ProjectRadius.large.value),
        bottomLeft: Radius.circular(ProjectRadius.medium.value),
      ),
      child: Stack(
        children: [
          _buildBlurredBackground(context),
          _buildTitleText(context),
        ],
      ),
    );
  }

  Widget _buildBlurredBackground(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 5.0),
      child: Container(
        height: context.sized.height * .05,
        width: context.sized.width * .2,
        color: CupertinoColors.black.withOpacity(0.3),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Container(
      padding: context.padding.low,
      child: FittedBox(
        child: Text(
          breed.breed?.capitalizeFirstLetter() ?? '',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}