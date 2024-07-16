import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_event.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_state.dart';
import 'package:dollor_convertation/ui/widgets/convert_dialog.dart';
import 'package:dollor_convertation/utils/datetime_reformat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ConverCourseBloc>().add(GetConverEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<ConverCourseBloc>().add(GetConverEvent());
                setState(() {});
              },
              icon: const Icon(Icons.replay))
        ],
      ),
      body: BlocBuilder(
        bloc: context.read<ConverCourseBloc>(),
        builder: (context, state) {
          if (state is LoadingConverState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorConverState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is LoadedConverState) {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: state.moneys.length,
              itemBuilder: (context, index) {
                final money = state.moneys[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConvertDialog(money: money);
                        },
                      );
                    },
                    title: Text(
                      money.cbPrice.toString(),
                    ),
                    subtitle: Text(money.title),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(money.code),
                        Text(
                          money.dateTime,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text("Inetiol"),
          );
        },
      ),
    );
  }
}
