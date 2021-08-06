import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/model/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberControllerr =
      TextEditingController();
  ContactDAO _dao = ContactDAO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full name'),
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _accountNumberControllerr,
              decoration: InputDecoration(labelText: 'Account number'),
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                  width: double.maxFinite, //MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        final String name = _nameController.text;
                        final int accountNumber =
                            int.parse(_accountNumberControllerr.text);
                        final Contact newContact = Contact(name, accountNumber);
                        _dao
                            .save(newContact)
                            .then((id) => Navigator.pop(context, newContact));
                      },
                      child: Text('Cadastrar'))),
            )
          ],
        ),
      ),
    );
  }
}
