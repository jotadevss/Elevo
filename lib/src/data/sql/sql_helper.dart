import 'package:elevo/src/domain/enums/sql_error_enums.dart';
import 'package:elevo/src/domain/exception/sql_exception.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  final String databaseName;
  final String tableName;
  final String props;

  SQLHelper({
    required this.databaseName,
    required this.tableName,
    required this.props,
  });

  // Method to initialize the database.
  Future<Database> initializeDatabase() async {
    // Get the path to the database file.
    final path = join(await getDatabasesPath(), databaseName);

    // Open or create the database with the provided path.
    final db = openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        // Create the table in the database based on the provided table name and properties.
        database.execute(''' CREATE TABLE $tableName ($props) ''');
      },
    );

    // Return the initialized database.
    return db;
  }

  // Method to save data to the database.
  Future<void> saveDataQuery(Map<String, dynamic> data) async {
    final Database db = await initializeDatabase();

    // Query the database to check if the record exists based on the 'id'.
    final record = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );

    // Check if the record exists and update or insert the data accordingly.
    if (record.isNotEmpty) {
      // Update the existing record in the database.
      await db.update(
        tableName,
        data,
        where: 'id = ?',
        whereArgs: [data['id']],
      );
    } else {
      // Insert a new record into the database.
      await db.insert(tableName, data);
    }
  }

  // Method to delete data from the database.
  Future<void> deleteDataQuery(String id) async {
    final Database db = await initializeDatabase();

    // Delete the record from the database based on the provided ID.
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method to get all data from the database.
  Future<List<Map<String, dynamic>>> getDataQuery() async {
    final db = await initializeDatabase();
    // Return all data from the table in the database.
    final data = await db.query(tableName);
    if (data.isEmpty) {
      throw SQLException(error: SQLError.isEmpty);
    } else {
      return data;
    }
  }

  // Method to get data from the database based on the provided ID.
  Future<Map<String, dynamic>> getByIdDataQuery(String id) async {
    final db = await initializeDatabase();
    // Return the data from the table based on the provided ID.
    final data = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (data.isEmpty) {
      throw SQLException(error: SQLError.notFound);
    } else {
      return data[0];
    }
  }

  // Method to get data from the database based on a specific property and its value.
  Future<List<Map<String, dynamic>>> getByPropQuery(String props, String value) async {
    final db = await initializeDatabase();
    // Return data from the table based on the provided property and value.
    final data = await db.query(tableName, where: '$props = ?', whereArgs: [value]);
    return data;
  }

  // Method to update data in the database.
  Future<void> updateDataQuery(Map<String, dynamic> data) async {
    final db = await initializeDatabase();
    // Update the data in the table based on the provided ID.
    await db.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }
}
