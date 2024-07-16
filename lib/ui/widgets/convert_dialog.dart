import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_event.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_state.dart';
import 'package:dollor_convertation/data/models/money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertDialog extends StatefulWidget {
  final Money money;
  ConvertDialog({super.key, required this.money});

  @override
  State<ConvertDialog> createState() => _ConvertDialogState();
}

class _ConvertDialogState extends State<ConvertDialog> {
  double result = 0.0;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.money.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'UZS',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final inputValue = double.tryParse(value);
                if (inputValue != null) {
                  context.read<ConverCourseBloc>().add(
                        ConverToMoneyEvent(
                          moneyTo: widget.money.cbPrice,
                          moneyFrom: inputValue,
                        ),
                      );
                }
              },
            ),
            Row(
              children: [
                Text("${widget.money.code} : "),
                BlocListener<ConverCourseBloc, ConverCourseBlocState>(
                  listener: (context, state) {
                    if (state is CountConverState) {
                      setState(() {
                        result = state.result;
                      });
                    }
                  },
                  child: Text(result.toStringAsFixed(2)),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<ConverCourseBloc>().add(GetConverEvent());
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
