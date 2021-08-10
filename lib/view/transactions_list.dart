import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclient/transaction_webclient.dart';

import 'package:bytebank/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  List<Transaction> transactions = [];
  TransactionWebClient webclient = TransactionWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          future: webclient.findAll(hostApi + ':8080/transactions'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  transactions = snapshot.data as List<Transaction>;
                  if (transactions.isNotEmpty) {
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
                  }
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );

              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                break;
            }
            return CenteredMessage(
              'No transactions found',
              icon: Icons.warning,
            );
          }),
    );
  }
}
