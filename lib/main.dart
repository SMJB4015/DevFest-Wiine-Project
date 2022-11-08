import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/blocs/auth/auth_bloc.dart';
import 'package:wiine/blocs/auth/auth_states.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/blocs/request/request_bloc.dart';
import 'package:wiine/repo/auth_repo.dart';
import 'package:wiine/repo/request_repo.dart';
import 'package:wiine/screens/home.dart';
import 'package:wiine/screens/sign_in.dart';
import 'blocs/request/request_states.dart';
import 'repo/map_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(LoginInitState(),AuthRepo())),
        ],child: SignIn())
    );
  }
}

