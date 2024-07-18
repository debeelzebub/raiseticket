import 'package:sqflite/sqflite.dart' as sql;

class SQlHelper{

    static Future<sql.Database> OpenDb() async {
    return sql.openDatabase('employeee', version: 1,
        onCreate: (sql.Database db, int version) async {
      await createTable(db);
    });
  }

  //create Table
  static Future<void> createTable(sql.Database db) async {
    await db.execute("""CREATE TABLE myemployee(
       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       empname TEXT,
       empcode String,
       designation TEXT,
       photo String,
       idBranch INTEGER,
       branchName String,
       cid INTEGER
      )""");
  }
  static Future<int> adddata({required String empname,required String empcode,required String designation,required String photo,required int bid,required int cid ,required String bname}) async {
     final db = await SQlHelper.OpenDb(); // to open database
    final data = {"empname": empname, "empcode": empcode,"designation": designation,"photo": photo,"idBranch":bid,"branchName":bname,"cid":cid};
    final id = db.insert('myemployee', data);
    return id;
  }

  static Future <List<Map<String,dynamic>>> readData({required int id}) async {
    final db = await SQlHelper.OpenDb();
    return db.query("myemployee",orderBy: 'id');// read all the datas by id

// mycontacts
  }

  // static Future<int> updatedata(int id, String text, String text2) async {
  //   final db = await SQlHelper.OpenDb();
  //   final udata = {'name':text,'phone':text2};
  //   final result = await db.update("", udata, where: "id=?",whereArgs: [id]);
  //   return result;

  // }

  static Future<void> deletedb() async {
    try{
    sql.deleteDatabase("employeee");

    }
    catch (e){
      print(e);
    }
    
  }

}