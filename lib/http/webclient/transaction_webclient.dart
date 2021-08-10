import 'dart:convert';

import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/model/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll(String uri) async {
    Client client =
        InterceptedClient.build(interceptors: [LoggingInterceptor()]);
    var response =
        await client.get(Uri.parse(uri)).timeout(Duration(seconds: 5));

    final List<dynamic> decodejson = jsonDecode(response.body);
    return toTransactions(decodejson);
  }

  List<Transaction> toTransactions(List decodejson) {
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodejson) {
      // final Map<String, dynamic> contactJson = transactionJson['contact'];
      // final Transaction transaction = Transaction(
      //   transactionJson['value'],
      //   Contact(
      //     contactJson['name'],
      //     contactJson['accountNumber'],
      //   ),
      // );
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Future<Transaction> save(String uri, Transaction transaction) async {
    //Map<String, dynamic> transactionMap = _toMap(transaction);

    final String transactionJson = jsonEncode(transaction.toJson());

    Client client =
        InterceptedClient.build(interceptors: [LoggingInterceptor()]);
    var response = await client
        .post(
          Uri.parse(uri),
          headers: {'Content-type': 'application/json', 'password': '1000'},
          body: transactionJson,
        )
        .timeout(Duration(seconds: 5));
    return _toTransaction(response);
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    //final Map<String, dynamic> contactJson = json['contact'];
    return Transaction.fromJson(json);
    // Transaction(
    //   json['value'],
    //   Contact(
    //     contactJson['id'],
    //     contactJson['name'],
    //     contactJson['accountNumber'],
    //   ),
    // );
  }
}
