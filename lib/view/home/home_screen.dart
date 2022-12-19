// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ecommerce/controller/home/carosal_provider.dart';
// import 'package:ecommerce/view/core/style_const.dart';
// import 'package:ecommerce/view/introduction/introduction_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 50,
//         title: const Image(
//           height: 30,
//           image: AssetImage('assets/images/logo.png'),
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) => const IntroductionScreen(),
//               ));
//             },
//             icon: const Icon(
//               FontAwesomeIcons.gears,
//             ),
//             splashRadius: 18,
//           )
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: screenGradiant,
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                 ),
//                 child: CupertinoSearchTextField(
//                   placeholder: 'Search Products',
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       15,
//                     ),
//                     color: whiteColor,
//                   ),
//                 ),
//               ),
//               height10,
              // SizedBox(
              //   height: 90,
              //   child: ListView.builder(
              //     itemCount: 20,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Container(
              //           width: 70,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(20)),
              //             color: whiteColor,
              //           ),
              //         ),
              //       );
              //     },
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
//               height10,
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   child: Container(
//                     color: whiteColor,
//                     // child: ListView.builder(
//                     //   itemCount: 10,
//                     //   itemBuilder: (context, index) {
//                     //     return const Padding(
//                     //       padding: EdgeInsets.all(10),
//                     //       child: HomeItemList(),
//                     //     );
//                     //   },
//                     // ),
//                     child: Column(
//                       children: [
//                         height20,
                        // Consumer<CarosalProvider>(
                        //   builder: (context, value, child) {
                        //     return CarouselSlider.builder(
                        //       itemCount: 5,
                        //       itemBuilder: (context, index, realIndex) {
                        //         return SizedBox(
                        //           height: 50,
                        //           width: 500,
                        //           child: Card(
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(20.0),
                        //             ),
                        //             color: Colors.grey,
                        //           ),
                        //         );
                        //       },
                        //       options: CarouselOptions(
                        //         onPageChanged: (index, reason) {
                        //           value.carosal(index);
                        //         },
                        //         height: 150,
                        //         viewportFraction: 0.9,
                        //         initialPage: value.activeIndex,
                        //         enableInfiniteScroll: false,
                        //         reverse: false,
                        //         autoPlay: true,
                        //         autoPlayInterval: const Duration(seconds: 3),
                        //         autoPlayAnimationDuration:
                        //             const Duration(milliseconds: 800),
                        //         autoPlayCurve: Curves.fastOutSlowIn,
                        //         enlargeCenterPage: true,
                        //         enlargeFactor: 0.3,
                        //         scrollDirection: Axis.horizontal,
                        //       ),
                        //     );
                        //   },
                        // ),
                        // height10,
                        // Consumer<CarosalProvider>(
                        //   builder: (context, value, child) =>
                        //       AnimatedSmoothIndicator(
                        //     effect: const ExpandingDotsEffect(
                        //       spacing: 10,
                        //       dotHeight: 10,
                        //       dotWidth: 10,
                        //     ),
                        //     curve: Curves.ease,
                        //     activeIndex: value.activeIndex,
                        //     count: 5,
                        //   ),
                        // )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
