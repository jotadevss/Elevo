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

  static const String scheduleTransactionTableName = "";
  static const String scheduleTransactionDatabaseName = "";
  static const String scheduleTransactionProperty = //
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
