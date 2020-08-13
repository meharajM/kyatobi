import 'package:kyatobi/bills/model/bills.dart';

Map<String, dynamic> toMap(data) {
  return {
    'name': data.name,
    'phone': data.phone,
    'amount': data.amount,
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
