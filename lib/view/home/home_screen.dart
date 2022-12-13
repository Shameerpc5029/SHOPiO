import 'package:ecommerce/view/core/style_const.dart';
import 'package:ecommerce/view/home/widgets/home_item_list.dart';
import 'package:ecommerce/view/introduction/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          height: 30,
          image: AssetImage('assets/images/logo.png'),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const IntroductionScreen(),
              ));
            },
            icon: const Icon(
              FontAwesomeIcons.cartShopping,
            ),
            splashRadius: 18,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: screenGradiant,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 70,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: whiteColor,
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              height10,
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    color: whiteColor,
                    // child: ListView.builder(
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //     return const Padding(
                    //       padding: EdgeInsets.all(10),
                    //       child: HomeItemList(),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
