import 'package:ecommerceapp/data/repositories/banners/banner_repository.dart';
import 'package:ecommerceapp/features/shop/models/banner_model.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      //Show loader
      isLoading.value = true;

      //Fetch banners from data source
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
