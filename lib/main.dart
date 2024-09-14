import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/contact_repository.dart';
import 'firebase_options.dart';
import 'presentation/bloc/contact_bloc.dart';
import 'presentation/screens/form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ContactFormApp());
}

class ContactFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Form',
      home: BlocProvider(
        create: (context) =>
            ContactBloc(ContactRepository(FirebaseFirestore.instance)),
        child: ContactFormScreen(),
      ),
    );
  }
}
