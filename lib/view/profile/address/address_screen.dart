import 'dart:developer';

import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/model/address_model/address_screen_enum.dart';
import 'package:ecommerce/view/profile/address/widgets/add_edit_address_bottomsheet.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:ecommerce/view/widgets/show_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addressProvider.getAllAddress();
    });
    return Consumer<AddressProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                value.isButtonVisbile = true;
              },
              icon: const Icon(
                CupertinoIcons.back,
              ),
            ),
            title: const Text('My Addresses'),
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              value.isVisible(notification);
              return true;
            },
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: value.addressList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 10,
                        ),
                        child: Text(
                          'NO SAVED ADDRESS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor().greyColor,
                          ),
                        ),
                      )
                    : value.isLoding2 == true
                        ? const Center(
                            heightFactor: 20,
                            child: LoadingWidget(),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    value.addressSelect(index);
                                    log(index.toString());
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: index == value.selectIndex
                                        ? const Color.fromARGB(
                                            255, 228, 240, 249)
                                        : AppColor().whiteColor,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                value
                                                    .addressList[index].fullName
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              CSizedBox().width10,
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                    value.addressList[index]
                                                        .title,
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(200, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              index == value.selectIndex
                                                  ? const Text(
                                                      "Defualt",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : const SizedBox()
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(
                                                value.addressList[index].phone,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Row(


                                                children: [
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton.styleFrom(
                                                      textStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      foregroundColor:
                                                          AppColor().alertColor,
                                                    ),
                                                    onPressed: () {
                                                      showCupertinoDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return ShowAlertWidget(
                                                            yesPress: () {
                                                              value.deleteAdderess(
                                                                  context,
                                                                  value
                                                                      .addressList[
                                                                          index]
                                                                      .id);
                                                            },
                                                            title: 'Remove Address',
                                                            contant:
                                                                'Are you sure want to delete this address?',
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_outline_outlined,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Remove'),
                                                  ),
SizedBox(width: MediaQuery.of(context).size.width*.01,),
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton.styleFrom(
                                                      textStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      foregroundColor: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      addAndEditBottomSheet(
                                                        context,
                                                        formGlobalKey,
                                                        AddressScreenEnum
                                                            .editAddressScreen,
                                                        value.addressList[index].id,
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                              // CSizedBox().width10,


                                            ],
                                          ),
                                        ],
                                      ),
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
          ),
          bottomNavigationBar: Visibility(
            visible: value.isButtonVisbile,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .08,
              child: FloatingActionButton.extended(
                foregroundColor: AppColor().whiteColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: AppColor().themeColor,
                onPressed: () {
                  addAndEditBottomSheet(
                    context,
                    formGlobalKey,
                    AddressScreenEnum.addAddressScreen,
                    '',
                  );
                },
                label: const Text(
                  'Add new address',
                ),
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
