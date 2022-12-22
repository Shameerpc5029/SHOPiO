import 'package:ecommerce/controller/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<ProfileProvider>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  value.logOut(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Profile"),
      ),
    );
  }
}
