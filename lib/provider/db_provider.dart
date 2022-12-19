import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider{

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'contact_database.db'),
      onCreate: (db, version) async{
        print('oncreate is calling');
        await db.execute(
            'CREATE TABLE contactDetails(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , mobile INTEGER  , age INTEGER)'
        );
      },
      version: 1,
    );

  }

  Future<void> insertData(ContactDetails data) async {
    final db = await DbProvider().initializeDB();
    await db.insert(
      'contactDetails',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> deleteData(int mobile) async{
    final db = await DbProvider().initializeDB();
    db.delete('contactDetails',
      where: 'mobile = ?',
      whereArgs: [mobile],
    );
  }
  Future<void> clearDB() async{
    final db = await DbProvider().initializeDB();
    db.delete('contactDetails');
  }
  Future<dynamic> displayData(int index) async {
    final db = await DbProvider().initializeDB();
    final List<Map<String, dynamic>> mapsDB = await db.query('contactDetails');
    return mapsDB[index]['name'];
  }
  Future<Future<List<Map<String, Object?>>>> displayAllDBData() async {
    final db = await DbProvider().initializeDB();
   return db.query('contactDetails');
  }

}
class ContactDetails {
  final String name;
  final int mobile;
  final int age;
  const ContactDetails( {
    required this.name,
    required this.mobile,
    required this.age,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'ContactDetails({ name: $name, mobile: $mobile, age: $age})';
  }

}
