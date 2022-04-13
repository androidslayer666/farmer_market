import 'package:cloud_firestore/cloud_firestore.dart';

String firestoreErrorCodeToString(FirebaseException exception) {
  switch (exception.code) {
    case 'ABORTED':
      return 'Please try one more time';
    case 'ALREADY_EXISTS':
      return 'The instance of an object you want to create already exists';
    case 'CANCELLED':
      return 'TheOperation is cancelled';
    case 'DATA_LOSS':
      return 'The data has been lost';
    case 'DEADLINE_EXCEEDED':
      return 'The request took too long, please try one more time';
    case 'FAILED_PRECONDITION':
      return 'Something went wrong, please try to reboot the app';
    case 'INTERNAL':
      return 'Something went wrong, please try to reboot the app';
    case 'INVALID_ARGUMENT':
      return 'Some input is invalid';
    case 'NOT_FOUND':
      return 'Sorry, can\'t find this item on the server';
    case 'OUT_OF_RANGE':
      return 'Next item doesn\'t exist on the server';
    case 'PERMISSION_DENIED':
      return 'You have not got the permission to make this inquiry. Please log out and log in';
    case 'RESOURCE_EXHAUSTED':
      return 'Something went wrong, please contact to the developer';
    case 'UNAUTHENTICATED':
      return 'Please try to log in with valid credentials';
    case 'UNAVAILABLE':
      return 'The server is currently unavailable';
    case 'UNIMPLEMENTED':
      return 'Something went wrong, please contact to the developer';
    case 'UNKNOWN':
      return 'Something went wrong, please contact to the developer';
  }
  return 'Something went wrong, please contact to the developer';
}
