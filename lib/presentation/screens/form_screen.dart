import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Contact.dart';
import '../bloc/contact_bloc.dart';

class ContactFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is ContactSubmitting) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Submitting...')),
              );
            } else if (state is ContactSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Contact added!')),
              );
            } else if (state is ContactFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Submission failed: ${state.error}')),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final contact = Contact(
                        name: _nameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        address: _addressController.text,
                      );
                      context.read<ContactBloc>().add(SubmitContact(contact));
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
