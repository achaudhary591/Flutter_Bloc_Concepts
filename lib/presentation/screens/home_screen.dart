import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concept/presentation/screens/third_screen.dart';

import '../../cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Increment'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decrement'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY! ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else if (state.counterValue % 5 == 0) {
                  return Text(
                    'HMMMM, number ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else {
                  return Text(
                    '${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  backgroundColor: widget.color,
                  onPressed: () {
                    //another way to fetch the method using bloc
                    context.read<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<CounterCubit>(context),
                      child: const SecondScreen(
                        title: 'Second Screen',
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                );
              },
              color: widget.color,
              child: const Text('Go to Second Screen'),
            ),
            const SizedBox(height: 20,),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<CounterCubit>(context),
                      child: const ThirdScreen(
                        title: 'Third Screen',
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                );
              },
              color: widget.color,
              child: const Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}