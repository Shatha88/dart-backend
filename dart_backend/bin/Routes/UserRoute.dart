// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middlewares/checkTokenMiddleware.dart';
import '../Responses/User/addContactResponse.dart';
import '../Responses/User/deleteContactResponse.dart';
import '../Responses/User/displayAllContact.dart';
import '../Responses/User/displayContactResponse.dart';
import '../Responses/User/displayUserContact.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      ..post('/add_contact', addContactResponse) // Add contact
      ..get("/view_contact", displayContactResponse) // display contact
      ..delete('/delete_mycontact', deleteContactResponse) //delete contact
      ..get("/display_user", displayUserContact) // display user => contact
      ..get('/view_allcontact', displayAllContact);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
