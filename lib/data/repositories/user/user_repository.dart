import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/features/authentication/models/user/user_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Functions to save user data to Firestore
  Future<void> savedUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw 'Database error. $e.';
    } on FormatException catch (_) {
      throw 'Format error.';
    } on PlatformException catch (e) {
      throw 'Platform unknown. $e.';
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }
}
