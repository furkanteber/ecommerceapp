import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/features/shop/models/category_model.dart';
import 'package:ecommerceapp/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerceapp/utils/exceptions/format_exceptions.dart';
import 'package:ecommerceapp/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepositorry extends GetxController {
  static CategoryRepositorry get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  //Get All categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapShot(document))
          .toList();
      return list;
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

  //Get Sub Categoties
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapShot(e)).toList();
      return result;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
