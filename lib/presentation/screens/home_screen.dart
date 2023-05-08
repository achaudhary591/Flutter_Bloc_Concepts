import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/constants/enums.dart';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';
import '../../logic/cubit/counter_cubit.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool internetConnected = false;

  Future<void> checkInternetConnectivity() async {
    final response = await http.head(Uri.parse("https://www.google.com"));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        internetConnected = true;
      });
    } else {
      setState(() {
        internetConnected = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      checkInternetConnectivity();
    });
    checkInternetConnectivity();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    (state.connectionType == ConnectionType.Wifi && (state.connectionType == ConnectionType.Mobile || state.connectionType != ConnectionType.Mobile))) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.green,
                        ),
                  );
                } else if (state is InternetConnected &&
                    (state.connectionType == ConnectionType.Mobile && state.connectionType != ConnectionType.Wifi)) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.red,
                        ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.grey,
                        ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Counter: ${counterState.counterValue} Internet: Mobile',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Wifi) {
                return Text(
                  'Counter: ${counterState.counterValue} Internet: WiFi',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else {
                return Text(
                  'Counter: ${counterState.counterValue} Internet: Dis',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }
            }),
            const SizedBox(
              height: 24,
            ),
            Builder(
              builder: (context) {
                final counterValue = context
                    .select((CounterCubit cubit) => cubit.state.counterValue);
                return Text(
                  'Counter: $counterValue',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
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
                Navigator.of(context).pushNamed('/second');
              },
              color: widget.color,
              child: const Text('Go to Second Screen'),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
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
