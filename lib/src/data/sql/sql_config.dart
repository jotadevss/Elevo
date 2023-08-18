class SQLConfig {
  static const String transactionProperty = '''
      id TEXT, 
      value FLOAT, 
      type TEXT, 
      category TEXT, 
      createAt INTEGER, 
      frequency TEXT,
      description INTEGER
  ''';

  static const String transactionTableName = 'TransactionManager';

  static const String transactionDatabaseName = 'TransactionMinderBD';

  static const String schedulerProperty = '''
      referenceId TEXT,
      frequencyType TEXT
  ''';

  static const String schedulerTableName = 'ScheduleTransactionMinderBD';

  static const String schedulerDatabaseName = 'ScheduleTransactionMinderBD';
}
