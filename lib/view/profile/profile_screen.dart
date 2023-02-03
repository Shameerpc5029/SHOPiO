import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/profile/profile_provider.dart';
import 'package:ecommerce/view/profile/address/address_screen.dart';
import 'package:ecommerce/view/profile/order/order_screen.dart';
import 'package:ecommerce/view/profile/widgets/profile_tile_widget.dart';
import 'package:ecommerce/view/profile/widgets/user_details_text.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:ecommerce/view/widgets/show_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getUser();
    });
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return value.isLoading == true
            ? const LoadingWidget()
            : Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text(
                    'Hey! ${value.userDetials?.fullname.toUpperCase()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "User Detials",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  CSizedBox().height5,
                                  UserDetialsText(
                                    title: "Name",
                                    result: value.userDetials?.fullname ?? '',
                                  ),
                                  UserDetialsText(
                                    title: "Email",
                                    result: value.userDetials?.email ?? "",
                                  ),
                                  UserDetialsText(
                                    title: "Phone Number",
                                    result: value.userDetials?.phone ?? "",
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Account Settings",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ProfileTextWidget(
                                  title: 'Orders',
                                  iconData: FontAwesomeIcons.box,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => const OrderScreen(),
                                    ));
                                  },
                                ),
                                ProfileTextWidget(
                                  title: 'Saved Addresses',
                                  iconData: FontAwesomeIcons.locationDot,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) {
                                        return const AddressScreen();
                                      },
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Feedback & Information",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ProfileTextWidget(
                                  title: 'Teams and conditions',
                                  iconData: FontAwesomeIcons.book,
                                  onTap: () {},
                                ),
                                ProfileTextWidget(
                                  title: 'Privacy Policy',
                                  iconData: FontAwesomeIcons.shieldHalved,
                                  onTap: () {},
                                ),
                                ProfileTextWidget(
                                  title: 'About',
                                  iconData: FontAwesomeIcons.circleInfo,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Consumer<ProfileProvider>(
                              builder: (context, value, child) {
                                return ProfileTextWidget(
                                  title: 'LogOut',
                                  iconData:
                                      FontAwesomeIcons.arrowRightToBracket,
                                  trailing: const SizedBox(),
                                  color: Colors.red,
                                  onTap: () {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return ShowAlertWidget(
                                          yesPress: () {
                                            value.logOut(context);
                                          },
                                          title: 'Logout',
                                          contant:
                                              'Are you sure you wnat to Logout?',
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "Version 1.0.0",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
