class SQLConfig {
  // Transaction configurations for SQLite
  static const String transactionTableName = 'TransactionManager';
  static const String transactionDatabaseName = 'TransactionMinderBD';
  static const String transactionProperty = //
      '''
      id TEXT, 
      value FLOAT, 
      type TEXT, 
      category TEXT, 
      createAt INTEGER, 
      frequency TEXT,
      description TEXT
      ''';
}
