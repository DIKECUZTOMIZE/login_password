import 'package:log_pass/data/local/dbHelper.dart';

class UserModel {
  int? idU;
  String nameU;
  String emailU;
  String phNoU;
  String passU;
  String created_atU;
  String adressU;

  UserModel(
      {this.idU,
      required this.nameU,
      required this.emailU,
      required this.phNoU,
      required this.passU,
      required this.created_atU,
      required this.adressU});

  factory UserModel.fromMapU(Map<String,dynamic>map){
    return UserModel(
        idU: map[DbHelper.USER_COLUMN_ID],
        nameU: map[DbHelper.USER_COLUMN_NAME],
        emailU: map[DbHelper.USER_COLUMN_EMAIL],
        phNoU: map[DbHelper.USER_COLUMN_PHNO],
        passU: map[DbHelper.USER_COLUMN_PASS],
        created_atU: map[DbHelper.USER_COLUMN_CREATED_AT],
        adressU: map[DbHelper.USER_COLUMN_ADRESS],
    );

  }

  Map<String,dynamic>toMapU(){
    return {
      DbHelper.USER_COLUMN_NAME : nameU,
      DbHelper.USER_COLUMN_EMAIL : emailU,
      DbHelper.USER_COLUMN_PHNO : phNoU,
      DbHelper.USER_COLUMN_PASS : passU,
      DbHelper.USER_COLUMN_CREATED_AT : created_atU,
      DbHelper.USER_COLUMN_ADRESS : adressU,
    };
  }
}
