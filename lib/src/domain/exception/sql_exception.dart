import 'package:elevo/src/domain/enums/sql_error_enums.dart';

// This class represents errors that occur when interacting with a database.
class SQLException implements Exception {
  // Creates a new SQLException object with the specified error type.
  SQLException({this.error});

  // The type of database error that occurred.
  final SQLError? error;

  // A map of error types to error messages.
  final message = {
    // The requested information was not found in the database.
    SQLError.notFound: 'Sorry, but the requested information was not found in our database. Please check the details and try again.',
    // The requested information does not exist in the database.
    SQLError.notExist: 'Apologies, but the requested information does not exist in our database. Please double-check the details and attempt again.',
    // An error occurred while trying to save data to the database.
    SQLError.cantSave: '"An error occurred while trying to save the data to the database. Please try again later.',
    // An error occurred while trying to update data in the database.
    SQLError.cantUpdate: 'Failed to update data in the database. Please check your input and try again.',
    // An error occurred while trying to delete data from the database.
    SQLError.cantDelete: 'Error encountered while attempting to delete data from the database. Please verify the details and retry.',
    // The database is empty.
    SQLError.isEmpty: 'No records found in the database. It appears to be empty at the moment.',
  };

  // Returns a string representation of the exception, which includes the type of database error that occurred.
  @override
  String toString() {
    return message[error] ?? 'An unknown error has occurred. Try Again Later.';
  }
}
