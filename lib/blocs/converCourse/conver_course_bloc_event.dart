sealed class ConverCourseBlocEvent {}

final class GetConverEvent extends ConverCourseBlocEvent {}

final class ConverToMoneyEvent extends ConverCourseBlocEvent {
  final double moneyTo;
  final double moneyFrom;
  ConverToMoneyEvent({
    required this.moneyTo,
    required this.moneyFrom,
  });
}

final class SearchCurrencyEvent extends ConverCourseBlocEvent {
  final String query;
  SearchCurrencyEvent({required this.query});
}
