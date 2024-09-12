import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/feature/main/main_screen.dart';
import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:dogapp/product/widget/button/generate_button/generate_button.dart';
import 'package:dogapp/product/widget/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:dogapp/product/utility/extension/string_extension.dart';

class DogDetailPreview extends StatelessWidget {
  final Breed item;

  const DogDetailPreview({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CupertinoColors.systemBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
      ),
      child: SizedBox(
        width: double.infinity,
        height: context.sized.dynamicHeight(0.75),
        child: Column(
          children: [
            _buildImage(context),
            _buildDetails(context),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(ProjectRadius.medium.value),
          topLeft: Radius.circular(ProjectRadius.medium.value),
        ),
        child: Image.network(
          item.imageUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.sized.emptySizedHeightBoxLow,
          _buildSectionTitle(context, 'Breed'),
          _buildPaddingDivider(context),
          _buildDetailText(item.breed?.capitalizeFirstLetter() ?? "", context),
          context.sized.emptySizedHeightBoxLow,
          _buildSectionTitle(context, 'Sub-Breed'),
          _buildPaddingDivider(context),
          _buildSubBreedsList(context),
        ],
      ),
    );
  }

  Widget _buildPaddingDivider(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: const ProjectDivider(),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.general.textTheme.titleLarge!.copyWith(
        color: CupertinoColors.systemBlue,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDetailText(String text, BuildContext context) {
    return Text(
      text,
      style: context.general.textTheme.titleMedium,
    );
  }

  Widget _buildSubBreedsList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: item.subBreeds?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            item.subBreeds?[index].capitalizeFirstLetter() ?? "",
            style: context.general.textTheme.titleMedium,
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: GenerateButton(
        breed: item.breed,

      ),
    );
  }
}
