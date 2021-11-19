import 'dart:convert';

InfoUser infoUserFromMap(String str) => InfoUser.fromMap(json.decode(str));

String infoUserToMap(InfoUser data) => json.encode(data.toMap());

class InfoUser {
  late int id;
  late String userName;
  var nPassword;
  late String fullName;
  late String idCard;
  late int sex;
  late String email;
  var birthday;
  late String numberPhone;
  late String dateCreate;
  late int createBy;
  late String image;
  late int roleId;
  late int isActive;
  late String address;
  var passwordReset;
  var resetToken;
  var resetTokenExpires;
  var verificationToken;

  static var obs;

  InfoUser(
      {required this.id,
      required this.userName,
      this.nPassword,
      required this.fullName,
      required this.idCard,
      required this.sex,
      required this.email,
      this.birthday,
      required this.numberPhone,
      required this.dateCreate,
      required this.createBy,
      required this.image,
      required this.roleId,
      required this.isActive,
      required this.address,
      this.passwordReset,
      this.resetToken,
      this.resetTokenExpires,
      this.verificationToken});
  
  factory InfoUser.fromMap(Map<String, dynamic> json) => InfoUser(
      id : json['id'],
      userName : json['userName'],
      nPassword : json['_Password'],
      fullName : json['fullName'],
      idCard : json['idCard'],
      sex : json['sex'],
      email : json['email'],
      birthday : json['birthday'],
      numberPhone : json['numberPhone'],
      dateCreate : json['dateCreate'],
      createBy : json['createBy'],
      image : json['image'],
      roleId : json['roleId'],
      isActive : json['isActive'],
      address : json['address_'],
      passwordReset : json['passwordReset'],
      resetToken : json['resetToken'],
      resetTokenExpires : json['resetTokenExpires'],
      verificationToken : json['verificationToken'],
    );
  
  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "userName": userName == null ? null : userName,
    "_Password": nPassword == null ? null : nPassword,
    "fullName": fullName == null ? null : fullName,
    "idCard": idCard == null ? null : idCard,
    "sex": sex == null ? null : sex,
    "email": email == null ? null : email,
    "birthday": birthday,
    "numberPhone": numberPhone == null ? null : numberPhone,
    "dateCreate": dateCreate == null ? null : dateCreate,
    "createBy": createBy == null ? null : createBy,
    "image": image == null ? null : image,
    "roleId": roleId == null ? null : roleId,
    "isActive": isActive == null ? null : isActive,
    "address_": address == null ? null : address,
    "passwordReset": passwordReset == null ? null : passwordReset,
    "resetToken": resetToken == null ? null : resetToken,
    "resetTokenExpires": resetTokenExpires == null ? null : resetTokenExpires,
    "verificationToken": verificationToken == null ? null : verificationToken,
  };
}