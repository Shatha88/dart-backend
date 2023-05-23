// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../Models/UserModel.dart';
import '../../RespnseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

createResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    print(body);

    final supabaseVariable = SupabaseEnv().supabase.auth;
    UserResponse userInfo = await supabaseVariable.admin.createUser(
      AdminUserAttributes(email: body['email'], password: body['password'],),
    );
    UserModel userObject =
        UserModel(email: userInfo.user!.email!, idAuth: userInfo.user!.id, username: '');

    await supabaseVariable.signInWithOtp(email: body['email']);
    await SupabaseEnv().supabase.from("user1").insert(userObject.toMap());

    return CustomResponse().successResponse(
      msg: "create account page",
      data: {"email": body['email']},
    );
  } catch (error) {
    print(error);

    return CustomResponse().errorResponse(
      msg: "sorry you should have body",
    );
  }
}