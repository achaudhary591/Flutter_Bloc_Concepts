import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/data/post_model.dart';
import 'package:flutter_bloc_concept/data/repository/post_repository.dart';
import 'package:flutter_bloc_concept/logic/bloc/bloc/internet_bloc_bloc.dart';
import 'package:flutter_bloc_concept/logic/cubit/post_cubit/cubit/post_cubit.dart';
import 'package:flutter_bloc_concept/logic/cubit/settings_cubit.dart';
import 'package:flutter_bloc_concept/logic/utility/app_bloc_observer.dart';
import 'package:flutter_bloc_concept/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());  

  Bloc.observer = AppBlocObserver();

  // PostRepository postRepository = PostRepository();
  // List<PostModel> postModels = await postRepository.fetchPosts();

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider<InternetBlocBloc>(
          create: (context) => InternetBlocBloc(),
          // lazy: false,
        ),
        BlocProvider<PostCubit>(
          create: (context) => PostCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter BloC Concept',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
