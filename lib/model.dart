class CurrencyModel {
  int ?id;
  final String ccy;
  final String rate;
  final String date;

  CurrencyModel({required this.ccy, required this.rate, required this.date, this.id });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      ccy: json['Ccy'],
      rate: json['Rate'],
      date: json['Date'],
    );
  }
}
