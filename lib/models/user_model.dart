class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? password;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      password: map['password'],
    );
  }
} 