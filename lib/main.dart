import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/model/saldo.dart';
import 'package:bytebank/model/transaction.dart';
import 'package:bytebank/view/dashboard.dart';
import 'package:bytebank/view/saldopage.dart';
import 'package:bytebank/view/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Saldo(8),
    child: ByteBankApp(),
  ));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: DashBoard(),
    );
  }
}
