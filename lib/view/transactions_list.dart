import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          future: findAll('http://10.100.20.62:8080/transactions'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transaction transaction = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(
                          transaction.value.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.contact.accountNumber.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                );
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                break;
            }
            return Text('Unknown error');
          }),
    );
  }
}
