class Money {
  String title;
  String code;
  double cbPrice;
  String dateTime;
  Money({
    required this.title,
    required this.cbPrice,
    required this.code,
    required this.dateTime,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      title: json['title'],
      cbPrice: double.parse(json['cb_price']),
      code: json['code'],
      dateTime: json['date'],
    );
  }
}
