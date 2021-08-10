import 'package:bytebank/components/itemcontact_widget.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/view/contact_new.dart';
import 'package:bytebank/view/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    ContactDAO _dao = ContactDAO();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          List<Contact> contacts = [];
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data == null) {
                break;
              }
              contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return ItemContactCard(contact, onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionForm(contact),
                      ),
                    );
                  });
                },
                itemCount: contacts.length,
              );

            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
