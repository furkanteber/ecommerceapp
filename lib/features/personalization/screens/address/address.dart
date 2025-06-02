import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/effects/vertical_product_shimmer.dart';
import 'package:ecommerceapp/features/personalization/controllers/address_controller.dart';
import 'package:ecommerceapp/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerceapp/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            ()=> FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
                future: controller.allUserAddress(),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loader;
                  }
            
                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Data Found!"),
                    );
                  }
            
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  final addresses = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (_, index) => TSingleAddress(
                            address: addresses[index],
                            onTap: () =>
                                controller.selectedAddress(addresses[index]),
                          ));
                }),
          ),
        ),
      ),
    );
  }
}
