import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concept/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_concept/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concept/presentation/screens/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CounterCubit _counterCubit = CounterCubit();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BloC Concept',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => BlocProvider.value(
              value: _counterCubit,
              child: const HomeScreen(
                title: 'HomeScreen',
                color: Colors.blueAccent,
              ),
            ),
        '/second': (context) => BlocProvider.value(
              value: _counterCubit,
              child: const SecondScreen(
                title: 'SecondScreen',
                color: Colors.orangeAccent,
              ),
            ),
        '/third': (context) => BlocProvider.value(
              value: _counterCubit,
              child: const ThirdScreen(
                title: 'ThirdScreen',
                color: Colors.greenAccent,
              ),
            ),
      },
    );
  }
}
