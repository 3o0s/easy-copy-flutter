import 'package:easycopy/UI/main_screen.dart';
import 'package:easycopy/bloc/app_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        //TODO: ADD THESE PARMAETERS
          apiKey: "A",
          authDomain: "A",
          projectId: "A",
          storageBucket: "A",
          messagingSenderId: "A",
          appId: "A"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AppCubit()..getMessages();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const MainScreen(),
      ),
    );
  }
}
