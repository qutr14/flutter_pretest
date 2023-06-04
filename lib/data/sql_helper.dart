import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pre_test/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  final String colId = 'id';
  final String colName = 'name';
  final String colPhone = 'phone';
  final String tableContact = 'contact';
  static Database? _db;
  static final SqlHelper _singleton = SqlHelper._internal();
  final int version = 1;
  factory SqlHelper() {
    return _singleton;
  }
  SqlHelper._internal();

  Future<Database> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'ContactDb.db');
    Database dbContact =
        await openDatabase(dbPath, version: version, onCreate: _createDb);
    return dbContact;
  }

  Future _createDb(Database db, int version) async {
    String query =
        'CREATE TABLE $tableContact ($colId INTEGER PRIMARY KEY, $colName TEXT, $colPhone)';
    await db.execute(query);
  }

  Future<int> insertNote(Contact contact) async {
    int result = await _db!.insert(tableContact, contact.toMap());
    return result;
  }

  Future<List<Contact>> getContacts() async {
    _db ??= await init();
    List<Contact> contacts = [];
    List<Map<String, dynamic>>? contactList =
        await _db?.query(tableContact, orderBy: colId);

    contactList?.forEach((element) {
      contacts.add(Contact.fromMap(element));
    });
    return contacts;
  }

  Future<List<Contact>> searchContacts(String searchStr) async {
    _db ??= await init();
    List<Contact> contacts = [];
    List<Map<String, dynamic>>? contactList =
        await _db?.query(tableContact, orderBy: colId);
    contactList?.forEach((element) {
      if (Contact.fromMap(element).name.contains(searchStr)) {
        contacts.add(Contact.fromMap(element));
      }
    });
    return contacts;
  }
}
