import 'dart:convert';
import 'package:reflectable/reflectable.dart' show ClassMirror, InstanceMirror;

typedef S ItemCreator<S>();

class JsonGeneric<T> {
  ItemCreator<T>? creator;

  List<T> fromJson(String json) {
    List<T> list = [];
    final List<dynamic> decodejson = jsonDecode(json);
    for (Map<String, dynamic> item in decodejson) {
      T instance = creator!();

      //  InstanceMirror im = reflect(instance);
      //  ClassMirror classMirror = im.type;
    } //ainda vai dar certo falta apenas alguns detalhes pouco muito ainda
    return list;
    //   // instance[''];
    //   // item.keys

    //   final Map<String, dynamic> contactJson = item['contact'];
    //   final Transaction transaction = Transaction(
    //     transactionJson['value'],
    //     Contact(
    //       contactJson['name'],
    //       contactJson['accountNumber'],
    //     ),
    //   );
    //   transactions.add(transaction);
    // }
    // return transactions;

    // return ;
  }
}
