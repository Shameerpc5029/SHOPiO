import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/view/profile/address/widgets/add_new_address_widget.dart';
import 'package:ecommerce/view/widgets/show_alert.dart';
import 'package:flutter/cupertino.dart';
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
                Icons.arrow_back_ios,
              ),
            ),
            title: const Text('My Addresses'),
          ),
          bottomNavigationBar: Visibility(
            visible: value.isButtonVisbile,
            child: const AddNewAddressWidget(),
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              value.isVisible(notification);
              return true;
            },
            child: SingleChildScrollView(
                child: value.addressList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 10,
                        ),
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
                                      children: [
                                        Text(
                                          value.addressList[index].fullName
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 18,
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
                                                fontSize: 10,
                                              ),
                                            ),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone_android_outlined,
                                            ),
                                            CSizedBox().width10,
                                            Text(
                                              value.addressList[index].phone,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: alertColor,
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
                                                        Navigator.of(context)
                                                            .pop();
                                                        PopUpSnackBar.popUp(
                                                          context,
                                                          'Address removed successfully',
                                                          alertColor,
                                                        );
                                                        value.getAllAddress(
                                                            context);
                                                      },
                                                      title: 'Remove Address',
                                                      contant:
                                                          'Are you sure want to delete this address?',
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons
                                                  .delete_outline_outlined),
                                              label: const Text('Remove'),
                                            ),
                                            CSizedBox().width10,
                                            OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.green,
                                              ),
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit),
                                              label: const Text('Edit'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
          ),
        );
      },
    );
  }
}
