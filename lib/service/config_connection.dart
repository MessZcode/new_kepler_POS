import 'package:postgres/postgres.dart';

class ConnectDatabase {
  // ConfigConnection
  static const hostName = "127.0.0.1";
  static const portNumber = 5432;
  static const defaultDatabase = keplerTest;
  static const userName = "postgres";
  static const password = "1234";

  //default database || Edit connection
  factory ConnectDatabase.withDefault() {
    return ConnectDatabase(databaseName: defaultDatabase);
  }

  // List Database
  //add database and Edit default
  static const String postgres = "postgres"; //Don't remove
  static const String keplerTest = "test";
  ConnectDatabase({required this.databaseName});

  final String databaseName;

  PostgreSQLConnection connection() {
    return PostgreSQLConnection(
      hostName,
      portNumber,
      databaseName,
      username: userName,
      password: password,
    );
  }

  factory ConnectDatabase.withDatabase(String dbName) {
    return ConnectDatabase(databaseName: dbName);
  }
}
