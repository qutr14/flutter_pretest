import 'package:flutter/material.dart';
import 'package:pre_test/data/sql_helper.dart';
import 'package:pre_test/models/contact.dart';
import 'package:pre_test/screens/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  SqlHelper sqlHelper = SqlHelper();
  final TextEditingController txtSearch = TextEditingController();
  List<Contact> contacts = [];
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: txtSearch,
                decoration: InputDecoration(
                  hintText: 'Enter a name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchContacts(txtSearch.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              for (final contact in contacts)
                Dismissible(
                  key: Key(contact.id.toString()),
                  child: Card(
                    key: ValueKey(contact.id.toString()),
                    child: ListTile(
                      title: Text(contact.name),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen(contact)));
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Color(settingColor),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactScreen(Contact('', ''))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getContacts() async {
    sqlHelper = SqlHelper();
    List<Contact> resContacts = await sqlHelper.getContacts();
    setState(() {
      contacts = resContacts;
    });
  }

  void searchContacts(String searchStr) async {
    sqlHelper = SqlHelper();
    List<Contact> resContacts = await sqlHelper.searchContacts(searchStr);
    setState(() {
      contacts = resContacts;
    });
  }
}
