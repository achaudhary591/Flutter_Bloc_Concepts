import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/logic/bloc/bloc/internet_bloc_bloc.dart';

import '../../logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocListener<SettingsCubit, SettingsState>(
              listener: (context, state) {
                final notificationSnackBar = SnackBar(
                  duration: const Duration(milliseconds: 100),
                  content: Text(
                    'App ${state.appNotifications.toString().toUpperCase()}, Email ${state.emailNotifications.toString().toUpperCase()}',
                  ),
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(notificationSnackBar);
              },
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SwitchListTile(
                        value: state.appNotifications,
                        onChanged: (newValue) {
                          context
                              .read<SettingsCubit>()
                              .toggleAppNotifications(newValue);
                        },
                        title: const Text('App Notifications'),
                      ),
                      SwitchListTile(
                        value: state.emailNotifications,
                        onChanged: (newValue) {
                          context
                              .read<SettingsCubit>()
                              .toggleEmailNotifications(newValue);
                        },
                        title: const Text('Email Notifications'),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<InternetBlocBloc, InternetBlocState>(
              builder: (context, state) {
                if (state is InternetOpenedState) {
                  return Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset(
                        'assets/connected.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else if (state is InternetLostState) {
                  return SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      'assets/img.gif',
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
              listener: (context, state) {
                if (state is InternetOpenedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Internet Connected'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                else if (state is InternetLostState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Internet Disconnected'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            // BlocBuilder<InternetBlocBloc, InternetBlocState>(
            //     builder: (context, state) {
            //   if (state is InternetOpenedState) {
            //     return Center(
            //       child: SizedBox(
            //         width: 250,
            //         height: 250,
            //         child: Image.asset(
            //           'assets/connected.gif',
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     );
            //   }
            //   else if(state is InternetLostState){
            //     return SizedBox(
            //       width: 250,
            //       height: 250,
            //       child: Image.asset(
            //         'assets/img.gif',
            //         fit: BoxFit.cover,
            //       ),
            //     );
            //   }
            //   else{
            //     return const CircularProgressIndicator();
            //   }
            // },),
          ],
        ),
      ),
    );
  }
}
