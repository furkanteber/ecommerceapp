import 'package:ecommerceapp/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerceapp/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerceapp/data/repositories/order/order_repository.dart';
import 'package:ecommerceapp/features/personalization/controllers/address_controller.dart';
import 'package:ecommerceapp/features/shop/controllers/cart_controller.dart';
import 'package:ecommerceapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerceapp/features/shop/models/order_model.dart';
import 'package:ecommerceapp/navigation_menu.dart';
import 'package:ecommerceapp/utils/constants/enums.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/popups/full_screen_loaders.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.docerAnimation);
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          totalAmount: totalAmount,
          deliveryDate: DateTime.now(),
          orderDate: DateTime.now());
      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(() => SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: 'Payment Success',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
