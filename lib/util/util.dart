Map<String, dynamic> toMap(data) {
  return {
    'name': data.displayName,
    'phone': data.phones.toList()[0].value,
    'amount': '200.0',
    'datetime': new DateTime.now().toIso8601String()
  };
}
