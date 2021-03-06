import 'package:bytebank/model/contact.dart';
import 'package:flutter/material.dart';

class ItemContactCard extends StatelessWidget {
  final Contact _contact;
  final Function? onClick;

  ItemContactCard(this._contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick!(),
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
