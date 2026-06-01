import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:valyuta/model.dart';

class Apiservice {
  Future<List<CurrencyModel>> getCurrencies() async {
    final response = await http.get(
      Uri.parse("https://cbu.uz/uz/arkhiv-kursov-valyut/json/"),
    );

    final List data = jsonDecode(response.body);

    return data.map((e) => CurrencyModel.fromJson(e)).toList();
  }
}
