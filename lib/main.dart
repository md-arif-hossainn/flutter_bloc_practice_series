import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_count/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_count/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter_bloc_count/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_count/ui/counter/counter_screen.dart';
import 'package:flutter_bloc_count/ui/image_picker/image_picker_screen.dart';
import 'package:flutter_bloc_count/ui/switch_example/switch_example.dart';
import 'package:flutter_bloc_count/utils/image_picker_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const CounterScreen(),
        home: const ImagePickerScreen(),
      ),
    );
  }
}
