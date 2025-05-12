import 'package:ecommerceapp/data/repositories/categories/category_repositorry.dart';
import 'package:ecommerceapp/features/shop/models/category_model.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepositorry());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //Load Category Data
  Future<void> fetchCategories() async {
    try {
      //Show loader
      isLoading.value = true;

      //Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //Update featured categories
      allCategories.assignAll(categories);

      //Filter the categories list
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Load selected category data

  // Get Category or Sub-category Products
}
