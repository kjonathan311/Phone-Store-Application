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
}