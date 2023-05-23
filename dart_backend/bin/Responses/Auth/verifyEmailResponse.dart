// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';

verifyEmailResponse(Request _) async {
  try {
    return CustomResponse().successResponse(
      msg: "",
      statusCode: 201,
      data: [],
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
