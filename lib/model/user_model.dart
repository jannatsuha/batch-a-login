class UserModel{
  String? name;
  String? id;
  String? phone;
  String? age;
  String? email;
  String? uid;
  String? dept;
  String? bloodGroup;

  UserModel({this.name,this.id, this.phone,
      this.age, this.email, this.uid,
    this.dept,this.bloodGroup});

  factory UserModel.fromMap(map){
    return UserModel(
        name: map['name'],
        id: map['id'],
        phone: map['phone'],
        age: map['age'],
        email: map['email'],
        uid: map['uid'],
        dept: map['dept'],
        bloodGroup: map['bloodGroup'],
    );
  }

  Map<String , dynamic> toMap(){
    return {
      'uid': uid,
      'id': id,
      'name': name,
      'email': email,
      'phone':phone,
      'age':age,
      'dept':dept,
      'bloodGroup':bloodGroup,
    };
  }

}