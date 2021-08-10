import 'package:bytebank/model/saldo.dart';
import 'package:bytebank/view/saldocard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoPage extends StatelessWidget {
  const SaldoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: SaldoCard(),
          ),
          Consumer<Saldo>(
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () {
                  value.adiciona(10);
                },
                child: Text('Adicionar'),
              );
            },
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar'),
            ),
          ),
          Consumer<Saldo>(
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () {
                  value.subtrai(10);
                },
                child: Text('Subtrair'),
              );
            },
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Subrair'),
            ),
          ),
        ],
      ),
    );
  }
}
