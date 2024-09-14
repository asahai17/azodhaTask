class Contact {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
