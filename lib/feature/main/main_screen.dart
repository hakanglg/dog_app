import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/feature/main/widget/dog_card.dart';
import 'package:dogapp/feature/main/widget/expandable_search/expandable_search.dart';
import 'package:dogapp/feature/settings/settings_screen.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/utility/enum/image_enum.dart';
import 'package:dogapp/product/widget/appbar/default_appbar.dart';
import 'package:dogapp/product/widget/bottom_nav_bar/project_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class MainScreen extends StatelessWidget {
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
      context.read<BreedsBloc>().add(SearchBreeds(text));
    });
  }
}


class _DogsList extends StatelessWidget {
  const _DogsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedsBloc, BreedsState>(
      builder: (context, state) {
        if (state is BreedsLoading) {
          return _buildLoadingIndicator();
        } else if (state is BreedsLoaded) {
          return _buildBreedGrid(context, state.breeds);
        } else if (state is BreedsError) {
          return _buildErrorMessage(context, state.message);
        } else if (state is BreedsNoResults) {
          return _buildNoResult(context);
        } else {
          return _buildInitialState(context);
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildBreedGrid(BuildContext context, List<Breed> breeds) {
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
  }

  Widget _buildErrorMessage(BuildContext context, String message) {
    return Center(
      child: Text(
        "Error: $message",
        style: context.general.textTheme.titleMedium!.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNoResult(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Text(
        "Start by searching for a breed",
        style: context.general.textTheme.titleMedium,
      ),
    );
  }
}