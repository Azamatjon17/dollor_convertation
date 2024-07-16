import 'dart:async';

import 'package:dollor_convertation/data/models/money.dart';

sealed class ConverCourseBlocState {}

final class InitialConverState extends ConverCourseBlocState {}

final class LoadingConverState extends ConverCourseBlocState {}

final class LoadedConverState extends ConverCourseBlocState {
  List<Money> moneys;
  LoadedConverState({
    required this.moneys,
  });
}

final class CountConverState extends ConverCourseBlocState {
  final double result;
  CountConverState({required this.result});
}

final class ErrorConverState extends ConverCourseBlocState {
  final String message;
  ErrorConverState({required this.message});
}
