import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_event.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_state.dart';
import 'package:dollor_convertation/ui/widgets/convert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<ConverCourseBloc>().add(SearchCurrencyEvent(query: _searchController.text));
    });
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search currency',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder(
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
                if (state is LoadedConverState || state is SearchResultState) {
                  final moneys = state is LoadedConverState ? state.moneys : (state as SearchResultState).searchResults;
                  return ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: moneys.length,
                    itemBuilder: (context, index) {
                      final money = moneys[index];
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
          ),
        ],
      ),
    );
  }
}
