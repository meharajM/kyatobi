import 'package:kyatobi/bills/model/bills.dart';

Map<String, dynamic> toMap(data) {
  return {
    'name': data.displayName,
    'phone': data.phones.toList()[0].value,
    'amount': '200.0',
    'datetime': new DateTime.now().toIso8601String()
  };
}

fromMap(data) {
  return List.generate(data.length, (i) {
    return BillModel(
      id: data[i]['id'],
      name: data[i]['name'],
      phone: data[i]['phone'],
      amount: data[i]['amount'],
      datetime: data[i]['datetime'],
    );
  });
}
