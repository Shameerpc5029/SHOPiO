import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/profile/profile_provider.dart';
import 'package:ecommerce/view/profile/address/address_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Hey! user name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    title: 'Edit Profile',
                    iconData: FontAwesomeIcons.solidUser,
                    onTap: () {},
                  ),
                  ProfileTextWidget(
                    title: 'Saved Addresses',
                    iconData: FontAwesomeIcons.locationDot,
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
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
                    iconData: FontAwesomeIcons.arrowRightToBracket,
                    onTap: () {
                      value.logOut(context);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            const Text(
              "Version 1.0.0",
              style: TextStyle(
                color: greyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTextWidget extends StatelessWidget {
  const ProfileTextWidget({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: themeColor,
        size: 20,
      ),
      title: Text(
        title,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
    );
  }
}
