import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayUserContact(Request request) async {
  try {
  // create authorization wiht user token

  final jwt = JWT.decode(request.headers["authorization"]!);
  final userAuth = jwt.payload["sub"];
  final supabase = SupabaseEnv().supabase;
//get id from table user by use id auth
  final result =
      await supabase.from("users").select("id").eq("id_auth", userAuth);
//get contact
  final resultContact = await supabase
      .from("contact")
      .select("platform,value")
      .eq("id_user", result[0]["id"]);

  return Response.ok(
    json.encode(resultContact),
    headers: {"content-type": "application/json"},
  );
    
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
