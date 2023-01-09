import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/view/profile/address/widgets/add_new_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false)
          .getAllAddress(context);
    });
    return Consumer<AddressProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Addresses'),
        ),
        floatingActionButton: const AddNewAddressWidget(),
        body: SingleChildScrollView(
            child: value.addressList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Text(
                      'NO SAVED ADDRESS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: greyColor,
                      ),
                    ),
                  )
                : ListView.separated(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          value.addressList[index].fullName
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        CSizedBox().width10,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              value.addressList[index].title,
                                              style: const TextStyle(
                                                color:
                                                    Color.fromARGB(83, 0, 0, 0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                            onTap: () {
                                              value.deleteAdderess(
                                                context,
                                                value.addressList[index].id,
                                              );
                                            },
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
                                Text(
                                  '''${value.addressList[index].address},${value.addressList[index].place},
${value.addressList[index].state} - ${value.addressList[index].pin}
Land Mark - ${value.addressList[index].landMark}
''',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  value.addressList[index].phone,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CSizedBox().height5,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: value.addressList.length,
                    separatorBuilder: (context, index) {
                      return CSizedBox().height10;
                    },
                  )),
      );
    });
  }
}
