import 'package:flutter/material.dart';
import 'package:valyuta/apiService.dart';
import 'package:valyuta/model.dart';

class Homepageprovider extends ChangeNotifier {
  TextEditingController amountController = TextEditingController();
  TextEditingController amountFieldController = TextEditingController();
  TextEditingController convertedController = TextEditingController();
  TextEditingController convertedFieldController = TextEditingController();

  final Apiservice service = Apiservice();
  List<CurrencyModel> currenies = [];
  List<String> get nomlar => currenies.map((e) => e.ccy).toList();

  // amountFieldController — "dan" valyuta dropdown
  String get found => currenies
      .firstWhere(
        (element) => element.ccy == amountFieldController.text,
        orElse: () => CurrencyModel(ccy: '', rate: '1', date: ''),
      )
      .rate;

  // convertedFieldController — "ga" valyuta dropdown
  String get ali => currenies
      .firstWhere(
        (element) => element.ccy == convertedFieldController.text,
        orElse: () => CurrencyModel(ccy: '', rate: '1', date: ''),
      )
      .rate;

  void calculate() {
    if (amountController.text.isEmpty) return;
    if (amountFieldController.text.isEmpty) return;
    if (convertedFieldController.text.isEmpty) return;

    double amount = double.tryParse(amountController.text) ?? 0;
    double fromRate = double.tryParse(found) ?? 1;
    double toRate = double.tryParse(ali) ?? 1;

    double result = (amount * fromRate) / toRate;

    // convertedController — natija ko'rsatiladigan TextField
    convertedController.text = result.toStringAsFixed(2);
    notifyListeners();
  }

  Future<void> loadCurriens() async {
    currenies = await service.getCurrencies();
    notifyListeners();
  }
}