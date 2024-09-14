import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/Contact.dart';
import '../../data/repositories/contact_repository.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class SubmitContact extends ContactEvent {
  final Contact contact;

  const SubmitContact(this.contact);

  @override
  List<Object> get props => [contact];
}

// State
abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactSubmitting extends ContactState {}

class ContactSuccess extends ContactState {}

class ContactFailure extends ContactState {
  final String error;

  const ContactFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(ContactInitial()) {
    // Event handler for SubmitContact
    on<SubmitContact>((event, emit) async {
      emit(ContactSubmitting()); // Emit ContactSubmitting state

      try {
        // Perform the Firestore operation to add contact
        await contactRepository.addContact(event.contact);
        emit(ContactSuccess()); // Emit ContactSuccess state
      } catch (error) {
        // Emit ContactFailure state with the error message
        emit(ContactFailure(error.toString()));
      }
    });
  }
}
