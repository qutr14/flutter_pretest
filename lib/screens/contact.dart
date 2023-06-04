import 'package:flutter/material.dart';
import 'package:pre_test/data/sql_helper.dart';
import 'package:pre_test/models/contact.dart';
import 'package:pre_test/screens/contacts.dart';

class ContactScreen extends StatefulWidget {
  final Contact contact;

  const ContactScreen(this.contact, {super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  SqlHelper helper = SqlHelper();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NoteText('Name', txtName),
            NoteText('Phone number', txtPhone),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //save Note
          widget.contact.name = txtName.text;
          widget.contact.phone = txtPhone.text;
          helper.insertNote(widget.contact);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ContactsScreen()),
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class NoteText extends StatelessWidget {
  final String description;
  final TextEditingController controller;

  const NoteText(this.description, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: description),
      ),
    );
  }
}
