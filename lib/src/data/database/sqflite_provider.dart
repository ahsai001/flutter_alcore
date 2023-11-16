class SQFLiteProvider {
  // Future<Database> database() async {
  //   late DatabaseFactory databaseFactory;
  //   if (kIsWeb) {
  //     //databaseFactory = databaseFactoryWeb;
  //   } else if (Platform.isWindows || Platform.isLinux) {
  //     sqfliteFfiInit();
  //     databaseFactory = databaseFactoryFfi;
  //   }

  //   final Future<Database> database = databaseFactory.openDatabase(
  //     kIsWeb
  //         ? inMemoryDatabasePath
  //         : join(await getDatabasesPath(), 'database.db'),
  //     options: OpenDatabaseOptions(
  //         onConfigure: (Database db) async {
  //           await db.execute('PRAGMA foreign_keys = ON');
  //         },
  //         onCreate: (Database db, int version) async {
  //           Batch batch = db.batch();
  //           //createTables(batch);
  //           //createIndexes(batch);
  //           await batch.commit(continueOnError: false);
  //         },
  //         version: 1,
  //         onUpgrade: (db, oldVersion, newVersion) {}),
  //   );
  //   return database;
  // }
}
