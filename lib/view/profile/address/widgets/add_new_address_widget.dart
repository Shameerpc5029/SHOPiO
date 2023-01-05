import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:flutter/material.dart';

class AddNewAddressWidget extends StatelessWidget {
  const AddNewAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .07,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
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
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                            ),
                          )
                        ],
                      ),
                      TextFormFieldCustom(
                        labelText: 'Full Name',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.person_outline,
                      ),
                      TextFormFieldCustom(
                        labelText: 'Phone number',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.phone_android_outlined,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormFieldCustom(
                              labelText: 'Pincode',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.pin_drop_outlined,
                            ),
                          ),
                          Flexible(
                            child: TextFormFieldCustom(
                              labelText: 'state',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.name,
                              prefixIcon: Icons.map_outlined,
                            ),
                          ),
                        ],
                      ),
                      TextFormFieldCustom(
                        labelText: 'Place',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.location_city_outlined,
                      ),
                      TextFormFieldCustom(
                        labelText: 'Address',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.add_location_alt_outlined,
                      ),
                      TextFormFieldCustom(
                        labelText: 'Land Mark',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.emoji_flags_outlined,
                      ),
                      CSizedBox().height10,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .90,
                        child: OutlinedButton(
                          onPressed: () {},
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
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Add a new address',
        ),
      ),
    );
  }
}
