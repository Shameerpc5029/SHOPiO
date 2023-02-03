import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.name,
    required this.title,
    required this.address,
    required this.number,
    required this.onPreesed,
  }) : super(key: key);
  final String name;
  final String title;
  final String address;
  final String number;
  final void Function() onPreesed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color:AppColor(). whiteColor,
      padding: const EdgeInsets.all(
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deliver to:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor:AppColor(). themeColor,
                ),
                onPressed: onPreesed,
                child: const Text(
                  'Change',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CSizedBox().width10,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(83, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CSizedBox().height10,
          Text(
            address,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          CSizedBox().height5,
        ],
      ),
    );
  }
}
