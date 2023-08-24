import 'package:elevo/src/domain/enums/sql_error_enums.dart';

class SQLException implements Exception {
  SQLException({this.error});

  final SQLError? error;

  final message = {
    SQLError.notFound: 'Sorry, but the requested information was not found in our database. Please check the details and try again.',
    SQLError.notExist: 'Apologies, but the requested information does not exist in our database. Please double-check the details and attempt again.',
    SQLError.cantSave: '"An error occurred while trying to save the data to the database. Please try again later.',
    SQLError.cantUpdate: 'Failed to update data in the database. Please check your input and try again.',
    SQLError.cantDelete: 'Error encountered while attempting to delete data from the database. Please verify the details and retry.',
    SQLError.isEmpty: 'No records found in the database. It appears to be empty at the moment.',
  };

  @override
  String toString() {
    return message[error] ?? 'An unknown error has occurred. Try Again Later.';
  }
}
