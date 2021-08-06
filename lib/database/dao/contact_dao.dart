import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/model/contact.dart';

class ContactDAO {
  static const String tablename = 'contacts';
  static const String name = 'name';
  static const String account_number = 'account_number';
  static const String sqlTable = 'CREATE TABLE contacts ('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';
  Future<int> save(Contact contact) async {
    final db = await getDatabase();

    final Map<String, dynamic> contactMap = Map();
    contactMap[name] = contact.name;
    contactMap[account_number] = contact.accountNumber;
    return db.insert(tablename, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();
    return db.query(tablename).then((maps) => _toList(maps));
  }

  _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> map in result) {
      final Contact contact = Contact(
        map[name],
        map[account_number],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
