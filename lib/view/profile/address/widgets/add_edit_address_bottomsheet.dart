import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/model/address_model/address_screen_enum.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> addAndEditBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formGlobalKey,
    AddressScreenEnum addressScreenCheck,
    String addressId) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Provider.of<AddressProvider>(context, listen: false)
        .setAddressScreen(addressScreenCheck, addressId, context);
  });
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Consumer<AddressProvider>(
            builder: (context, provider, child) {
              return Form(
                key: formGlobalKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            provider.clearController();
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        )
                      ],
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return provider.nameValidation(value);
                      },
                      labelText: 'Full Name',
                      controller: provider.fullName,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return provider.phoneNumberValidation(value);
                      },
                      labelText: 'Phone number',
                      controller: provider.phone,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone_android_outlined,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormFieldCustom(
                            validator: (value) {
                              return provider.pincodeValidation(value);
                            },
                            labelText: 'Pincode',
                            controller: provider.pincode,
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.pin_drop_outlined,
                          ),
                        ),
                        Flexible(
                          child: TextFormFieldCustom(
                            validator: (value) {
                              return provider.stateValidation(value);
                            },
                            labelText: 'state',
                            controller: provider.state,
                            keyboardType: TextInputType.name,
                            prefixIcon: Icons.map_outlined,
                          ),
                        ),
                      ],
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return provider.addressValidation(value);
                      },
                      labelText: 'Address',
                      controller: provider.address,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.add_location_alt_outlined,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return provider.placeValidation(value);
                      },
                      labelText: 'Place',
                      controller: provider.place,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.location_city_outlined,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return provider.landMarkValidation(value);
                      },
                      labelText: 'Land Mark',
                      controller: provider.landMark,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.emoji_flags_outlined,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Consumer<AddressProvider>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: value.isSelected == true
                                      ? themeColor
                                      : Colors.transparent,
                                  foregroundColor: value.isSelected == true
                                      ? whiteColor
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  value.typeButtonSelect();
                                },
                                icon: const Icon(
                                  Icons.home,
                                ),
                                label: const Text(
                                  'Home',
                                ),
                              ),
                              CSizedBox().width10,
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: value.isSelected == false
                                      ? themeColor
                                      : Colors.transparent,
                                  foregroundColor: value.isSelected == false
                                      ? whiteColor
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  value.typeButtonSelect();
                                },
                                icon: const Icon(
                                  Icons.apartment_outlined,
                                ),
                                label: const Text(
                                  'Office',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .90,
                      child: OutlinedButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();
                            provider.saveAddress(
                              context,
                              addressScreenCheck,
                              addressId,
                            );
                          }
                        },
                        child: const Text(
                          'Save Address',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
