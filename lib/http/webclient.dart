import 'dart:convert';

import 'package:bytebank/model/contact.dart';
import 'package:bytebank/model/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data);
    return data;
  }
}

Future<List<Transaction>> findAll(String uri) async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  var response = await client.get(Uri.parse(uri)).timeout(Duration(seconds: 5));

  final List<dynamic> decodejson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodejson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(String uri, Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };

  final String transactionJson = jsonEncode(transactionMap);

  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  var response = await client
      .post(
        Uri.parse(uri),
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson,
      )
      .timeout(Duration(seconds: 5));
  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
  ;
}
