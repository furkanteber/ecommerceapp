import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:ecommerceapp/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerceapp/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerceapp/features/personalization/screens/address/address.dart';
import 'package:ecommerceapp/features/personalization/screens/profile/profile.dart';
import 'package:ecommerceapp/features/shop/screens/cart/cart.dart';
import 'package:ecommerceapp/features/shop/screens/order/order.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // User Profile Card
                  TUserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            //Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                TSectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'My Adresses',
                  subTitle: 'Get shopping delivery address',
                  onTap: () => Get.to(() => UserAddressScreen()),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.shopping_cart,
                  title: 'My Cart',
                  subTitle: 'Add , remove products and move to checkout',
                  onTap: () => Get.to(() => CartScreen()),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.bag_tick,
                  title: 'My Orders',
                  subTitle: 'In-progress and Completed orders.',
                  onTap: () => Get.to(() => OrderScreen()),
                ),
                /*TSettingsMenuTile(
                  icon: Iconsax.bank,
                  title: 'Bank Account',
                  subTitle: 'Withdraw balance to registered bank account.',
                  onTap: () {},
                ),
                TSettingsMenuTile(
                  icon: Iconsax.discount_shape,
                  title: 'My Coupons',
                  subTitle: 'List of all the discounted coupons.',
                  onTap: () {},
                ),
                TSettingsMenuTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  subTitle: 'Set any kind of notification message.',
                  onTap: () {}, 
                ),*/
                TSettingsMenuTile(
                  icon: Iconsax.security_card,
                  title: 'Account Privacy',
                  subTitle: 'Manage data usage and connected accounts.',
                  onTap: () {},
                ),

                // App Settings

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TSectionHeading(
                  title: 'App Settings',
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                /*   TSettingsMenuTile(
                  icon: Iconsax.document_upload,
                  title: 'Load Data',
                  subTitle: 'Upload data to your Cloud Firebase.',
                  onTap: () {},
                ),
                TSettingsMenuTile(
                  icon: Iconsax.location,
                  title: 'GeoLocation',
                  subTitle: 'Set recommendation based on location.',
                  trailing: Switch(value: true, onChanged: (value) {}), 
                ), */
                TSettingsMenuTile(
                  icon: Iconsax.security_user,
                  title: 'Safe Mode',
                  subTitle: 'Search result safe for all ages.',
                  trailing: Switch(value: false, onChanged: (value) {}),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.image,
                  title: 'HD image quality',
                  subTitle: 'Set image quality to be seen.',
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),

                //Logout
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text('Logout')),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2.5,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
