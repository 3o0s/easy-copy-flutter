import 'package:easycopy/bloc/app_cubit.dart';
import 'package:easycopy/bloc/app_states.dart';
import 'package:easycopy/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        AppCubit appCubit = AppCubit.appCubit(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Easy copy'), actions: [
            IconButton(
              onPressed: () {
                appCubit.getMessages();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                appCubit.removeAll();
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ]),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              itemsBuilder(
                list: appCubit.list,
                ctx: context,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              defaultFormFeild(
                  controller: appCubit.textcontroller,
                  label: 'Data to be sent',
                  prefix: Icons.delete_outline,
                  suffex: Icons.send,
                  perfixPressed: () {
                    appCubit.textcontroller.clear();
                  },
                  suffexPressed: () {
                    appCubit.send();
                  },
                  onSubmit: (String _) {
                    appCubit.send();
                  })
            ],
          ),
        );
      }),
    );
  }
}
