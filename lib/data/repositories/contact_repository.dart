import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Contact.dart';

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository(this.firestore);

  Future<void> addContact(Contact contact) {
    return firestore.collection('contacts').add(contact.toMap());
  }
}
