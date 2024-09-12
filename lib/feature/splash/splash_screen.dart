import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/product/navigation/app_router.dart';
import 'package:dogapp/product/utility/enum/lottie_enum.dart';
import 'package:dogapp/product/widget/lottie/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedsBloc, BreedsState>(
      listener: (context, state) {
        if (state is BreedsLoaded) {
          context.router.replace(const MainRoute());
        }
      },
      child: Scaffold(
        body: BlocBuilder<BreedsBloc, BreedsState>(
          builder: (context, state) {

            if (state is BreedsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FittedBox(child: Text("No results found")),
                    FittedBox(child: Text(state.message)),
                  ],
                ),
              );
            }

            if (state is BreedsInitial || state is BreedsLoading) {
              return const Center(
                child: LottieWidget(lottie: LottieAnimation.splash),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}