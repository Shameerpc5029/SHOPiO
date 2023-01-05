import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/profile/address/widgets/add_new_address_widget.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      bottomNavigationBar: const AddNewAddressWidget(),
      body: SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shameer",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  height: 30,
                                  onTap: () {},
                                  child: const Text(
                                    "Edit",
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 30,
                                  onTap: () {},
                                  child: const Text(
                                    "Remove",
                                  ),
                                ),
                              ];
                            },
                            elevation: 2,
                            child: const Icon(
                              Icons.more_vert_outlined,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      CSizedBox().height5,
                      const Text(
                        '''9932842312
Marikavil House Kuzhimanna 
kerala-673641''',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: 10,
          separatorBuilder: (context, index) {
            return CSizedBox().height10;
          },
        ),
      ),
    );
  }
}
