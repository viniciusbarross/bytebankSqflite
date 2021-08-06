import 'package:bytebank/model/contact.dart';
import 'package:flutter/material.dart';

class ItemContactCard extends StatelessWidget {
  final Contact _contact;

  const ItemContactCard(this._contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contact.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
