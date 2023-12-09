import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String id;
  final String email;
  final String password;

  User({
    this.id='',
    required this.email,
    required this.password,
  });

  Map<String,dynamic> toJson()=>{
    'id':id,
    'email':email,
    'password':password,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}

Future createUser({required String email,required String password})async{
  final docUser=FirebaseFirestore.instance.collection('users').doc();

  final user=User(
      id:docUser.id,
      email: email,
      password: password
  );
  final json=user.toJson();

  await docUser.set(json);
}

Future<User?> loginUser({required String email, required String password}) async {
  try {
    final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await _usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first;
      var user = User.fromJson(userDoc.data() as Map<String, dynamic>);
      return user;
    } else {
      // No user found with the provided email and password
      return null;
    }
  } catch (e) {
    print("Error logging in: $e");
    // Handle the error (show a message, log, etc.)
    return null;
  }
}
