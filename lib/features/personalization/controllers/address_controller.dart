import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/data/repositories/address/address_repository.dart';
import 'package:ecommerceapp/data/services/network_manager.dart';
import 'package:ecommerceapp/features/personalization/models/address_model.dart';
import 'package:ecommerceapp/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/popups/full_screen_loaders.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  //Variables
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.emty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> allUserAddress() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.emty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const CircularProgressIndicator(),
      );
      //Clear the "selected" field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      //Set the "selected" field to true for the newly selected address.
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Storing Address...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectedAddress(address);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved succesfuly');

      refreshData.toggle();

      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            FutureBuilder(
              future: allUserAddress(), builder: (_,snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No addresses found.');
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_,index) => TSingleAddress(address: snapshot.data![index], onTap: () async {
                  await selectedAddress(snapshot.data![index]);
                  Get.back();
                } ));
            }),
          ],
        ),
      ),
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
