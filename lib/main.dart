import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc.dart';
import 'package:dollor_convertation/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ConverCourseBloc(),
        )
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
