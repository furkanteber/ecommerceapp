import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerceapp/features/personalization/controllers/user_controller.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/product_review.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/popups/full_screen_loaders.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RatingController extends GetxController {
  static RatingController get instance => Get.find();
  final ratingFormKey = GlobalKey<FormState>();
  final comment = TextEditingController();
  var rating = 0.obs;

  Future<void> submitRating(ProductModel product) async {
    final isValid = ratingFormKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (rating.value == 0) {
      TLoaders.warningSnackBar(
          title: 'Warning', message: 'Please select a rating.');
      return;
    }

    try {
      final userId = UserController.instance;
      TFullScreenLoader.openLoadingDialog(
        'Submitting rating...',
        TImages.docerAnimation,
      );

      await FirebaseFirestore.instance
          .collection('Products')
          .doc(product.id)
          .collection('Reviews')
          .add({
        'userId': userId.user.value.fullName,
        'userPhoto': userId.user.value.profilePicture,
        'rating': rating.toDouble(),
        'comment': comment.text.trim(),
        'createdAt': DateTime.now(),
      });

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your comment added.');

      resetFormFields();
      Get.off(() => ProductReviewScreen(
            product: product,
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<double> fetchAverageRating(String productId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .collection('Reviews')
        .get();

    if (snapshot.docs.isEmpty) return 0.0;

    final ratings = snapshot.docs.map((doc) {
      final data = doc.data();
      return (data['rating'] as num?)?.toDouble() ?? 0.0;
    }).toList();

    double total = ratings.fold(0, (sum, rating) => sum + rating);
    return total / ratings.length;
  }

  Future<int> fetchRatingCount(String productId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .collection('Reviews')
        .get();

    if (snapshot.docs.isEmpty) return 0;

    final ratings = snapshot.docs.map((doc) {
      final data = doc.data();
      return (data['rating'] as num?)?.toDouble() ?? 0.0;
    }).toList();

    return ratings.length;
  }

  Future<Map<String, dynamic>> fetchRatingsData(String productId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .collection('Reviews')
        .get();

    if (snapshot.docs.isEmpty) {
      return {
        'average': 0.0,
        'counts': {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0},
        'total': 0,
      };
    }

    List<double> ratings = [];
    Map<String, int> counts = {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0};

    for (var doc in snapshot.docs) {
      final data = doc.data();
      double rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
      ratings.add(rating);

      int rounded = rating.round();
      String key = rounded.toString();
      if (counts.containsKey(key)) {
        counts[key] = counts[key]! + 1;
      }
    }

    int total = ratings.length;
    double average =
        ratings.fold(0.0, (prev, element) => prev + element) / total;

    return {
      'average': average,
      'counts': counts,
      'total': total,
    };
  }

  void resetFormFields() {
    comment.clear();
    rating.value = 0;
    ratingFormKey.currentState?.reset();
  }

  String formatTimestampToDate(DateTime? timestamp) {
    if (timestamp == null) return '';

    DateTime date = timestamp;
    return DateFormat('dd MMM yyyy').format(date);
  }
}
