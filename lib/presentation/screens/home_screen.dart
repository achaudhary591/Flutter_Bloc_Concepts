import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/constants/enums.dart';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';
import '../../logic/cubit/counter_cubit.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool internetConnected = false;


  Future<void> checkInternetConnectivity() async {
      final response = await http.head(Uri.parse("https://www.google.com"));
      if(response.statusCode >= 200 && response.statusCode < 300){
        setState(() {
          internetConnected = true;
        });
      }
      else{
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
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  // print('state is ===============================>$ConnectionType');
                  if (internetConnected) {
                    if (state is InternetConnected &&
                        state.connectionType == ConnectionType.Wifi) {
                      return Text(
                        'Wi-Fi',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.green,
                        ),
                      );
                    } else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.Mobile) {
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
                    }
                  }
                  return SizedBox(width: 350,height: 350,child: Image.asset('assets/img.gif'));
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
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
              ),
              // SizedBox(
              //   height: 24,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title}'),
              //       onPressed: () {
              //         BlocProvider.of<CounterCubit>(context).decrement();
              //         // context.bloc<CounterCubit>().decrement();
              //       },
              //       tooltip: 'Decrement',
              //       child: Icon(Icons.remove),
              //     ),
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title} 2nd'),
              //       onPressed: () {
              //         // BlocProvider.of<CounterCubit>(context).increment();
              //         context.bloc<CounterCubit>().increment();
              //       },
              //       tooltip: 'Increment',
              //       child: Icon(Icons.add),
              //     ),
              //   ],
              // ),
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
              const SizedBox(height: 20,),
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
      ),
    );
  }
}
