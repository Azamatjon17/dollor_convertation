import 'dart:convert';

import 'package:dollor_convertation/data/models/money.dart';
import 'package:http/http.dart' as http;

class ConvertationHttpService {
  final url = Uri.parse('https://nbu.uz/exchange-rates/json/');
  Future<List<Money>> getCurses() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        List<Money> moneys = [];
        for (Map<String, dynamic> i in data) {
          moneys.add(Money.fromJson(i));
        }
        return moneys;
      } else {
        throw "Server bilan muamo bor iltmos qayta urinib ko'ring";
      }
    } catch (e) {
      rethrow;
    }
  }
}
