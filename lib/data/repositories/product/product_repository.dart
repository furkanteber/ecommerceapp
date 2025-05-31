import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong.Please try again.';
    }
  }
}
