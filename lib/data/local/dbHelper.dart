import 'package:log_pass/data/local/model/userModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? mDataD;

  static const USER_TABLE = 'u_table';
  static const USER_COLUMN_ID = 'u_id';
  static const USER_COLUMN_NAME = 'u_name';
  static const USER_COLUMN_EMAIL = 'u_email';
  static const USER_COLUMN_PHNO = 'u_phNo';
  static const USER_COLUMN_PASS = 'u_pass';
  static const USER_COLUMN_CREATED_AT = 'u_created_at';
  static const USER_COLUMN_ADRESS = 'u_address';

  Future<Database> initDB() async {
    mDataD = mDataD ?? await openDB();
    print('open db');
    return mDataD!;
  }

  Future<Database> openDB() async {
    var appDir = await getApplicationDocumentsDirectory();
    var dbPath = join(appDir.path, 'logPssDB.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        print('creat db');
        db.execute(
            'create table $USER_TABLE ( $USER_COLUMN_ID integer primary key autoIncrement, $USER_COLUMN_NAME text, $USER_COLUMN_EMAIL text, $USER_COLUMN_PHNO text, $USER_COLUMN_PASS text, $USER_COLUMN_CREATED_AT text, $USER_COLUMN_ADRESS text)');
      },
    );
  }

  Future<bool> checkIfEmailAllreadyExits({required String emailDC}) async {
    var db = await initDB();

    List<Map<String, dynamic>> dataC = await db.query(USER_TABLE,
        where: '$USER_COLUMN_EMAIL = ?', whereArgs: [emailDC]);
    return dataC.isNotEmpty;
  }

  Future<bool> registerNewUser(UserModel newUserD) async {
    var db = await initDB();

    int rowsEffected = await db.insert(USER_TABLE, newUserD.toMapU());
    return rowsEffected >0;

    // if (!await checkIfEmailAllreadyExits(emailDC: newUserD.emailU)) {
    //   int rowsEffected = await db.insert(USER_TABLE, newUserD.toMapU());
    //   return rowsEffected > 0;
    // } else {
    //   return false;
    // }
  }

  Future<bool> authentication({required String emailDA, required String passDA})async{
    var db = await initDB();

    List<Map<String,dynamic>> dataA = await db.query(USER_TABLE,
    where: '$USER_COLUMN_EMAIL = ? AND $USER_COLUMN_PASS = ? ',whereArgs: [emailDA,passDA]);

    if(dataA.isNotEmpty){
     var prefs = await SharedPreferences.getInstance();
     prefs.setString('userId', dataA[0][USER_TABLE].toString());
    }

    return dataA.isNotEmpty;


  }

}
