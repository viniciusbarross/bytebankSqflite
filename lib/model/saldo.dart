import 'package:flutter/cupertino.dart';

class Saldo extends ChangeNotifier {
  late double valor;

  Saldo(this.valor);

  @override
  String toString() {
    return 'R\$ $valor';
  }

  void adiciona(double valor) {
    this.valor += valor;
    notifyListeners();
  }

  void subtrai(double valor) {
    this.valor -= valor;
    notifyListeners();
  }
}
