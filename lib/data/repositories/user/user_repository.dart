import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerceapp/features/authentication/models/user/user_model.dart';
import 'package:ecommerceapp/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerceapp/utils/exceptions/format_exceptions.dart';
import 'package:ecommerceapp/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  //Functions to fetch user details.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnaphot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnaphot.exists) {
        return UserModel.fromSnapshot(documentSnaphot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }

  //Function to update user data in FireStore.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }

  //Function to update user data in FireStore.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }

  //Function to remove user data in FireStore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }

  Future<String?> uploadImage(XFile imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dpgrgijlz/upload');
    try {
      final request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = 'urtlktin';
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url'];
      }
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }

    return null;
  }
}
