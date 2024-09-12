import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/product/init/theme/project_theme.dart';
import 'package:dogapp/product/navigation/app_router.dart';
import 'package:dogapp/product/repository/dog_repository.dart';
import 'package:dogapp/product/service/dog_service.dart';
import 'package:dogapp/product/service/project_dio.dart';
import 'package:dogapp/product/utility/constants/app_constants.dart';
import 'package:dogapp/product/utility/preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await PreferencesManager.preferencesInit();
  } catch (e) {
    print('Error initializing preferences: $e');
  }
  final dogRepository = DogRepository(DogService(ProjectDioMixin().service));
  runApp(MyApp(dogRepository: dogRepository));
}

class MyApp extends StatelessWidget {
  static final _appRouter = AppRouter();

  final DogRepository dogRepository;

  const MyApp({super.key, required this.dogRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BreedsBloc>(
              create: (BuildContext context) => BreedsBloc(dogRepository: dogRepository)..add(LoadAllBreeds())),
        ],
        child: MaterialApp.router(
          title: 'Dog App',
          theme: projectTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          // home: BlocBuilder<LoginBloc, LoginState>(
          //   builder: (context, state) {
          //
          //     return LoginPage();
          //   },
          // ),
        ));
  }
}
