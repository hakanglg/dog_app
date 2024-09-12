import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/feature/main/widget/dog_card.dart';
import 'package:dogapp/feature/main/widget/expandable_search.dart';
import 'package:dogapp/feature/settings/settings_screen.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/utility/enum/image_enum.dart';
import 'package:dogapp/product/widget/appbar/default_appbar.dart';
import 'package:dogapp/product/widget/bottom_nav_bar/project_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildSearchField(context),
      bottomNavigationBar: const ProjectBottomNavigation(),
      body: const _DogsList(),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return ExpandableSearchField(onSearch: (text) {
      // context.read<BreedsBloc>().add(BreedsSearch(text));
    });
  }


}



class _DogsList extends StatelessWidget {
  const _DogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BreedsBloc, BreedsState, List<Breed>>(
      selector: (state) {
        if (state is BreedsLoaded) {
          return state.breeds;
        } else {
          return [];
        }
      },
      builder: (context, breeds) {
        if (breeds.isEmpty) {
          return _buildNoResult(context);
        }
        return Padding(
          padding: context.padding.horizontalNormal,
          child: GridView.builder(
            itemCount: breeds.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.sized.normalValue,
              mainAxisSpacing: context.sized.normalValue,
            ),
            itemBuilder: (context, index) {
              final breed = breeds[index];
              return DogCard(breed: breed);
            },
          ),
        );
      },
    );
  }

  Center _buildNoResult(BuildContext context) {
    return Center(
            child: Column(
          children: [
            Text(
              "No results found",
              style: context.general.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Try searching with another word",
              style: context.general.textTheme.bodyMedium!
                  .copyWith(color: CupertinoColors.systemGrey),
            ),
          ],
        ));
  }
}
