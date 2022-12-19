// import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
// import 'package:ecommerce/view/core/style_const.dart';
// import 'package:ecommerce/view/widgets/custum_textformfiled.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// GlobalKey<FormState> formKey = GlobalKey();

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final provider = Provider.of<SignInProvider>(context);
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: screenGradiant,
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: size.height / 5,
//                   child: const Center(
//                     child: Image(
//                       width: 200,
//                       image: AssetImage(
//                         'assets/images/logo.png',
//                       ),
//                     ),
//                   ),
//                 ),
//                 height20,
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.all(
//                         10,
//                       ),
//                       color: whiteColor,
//                       child: Center(
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: [
//                             Form(
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               key: formKey,
//                               child: Column(
//                                 children: [
//                                   Image(
//                                     width: size.width / 4,
//                                     image: const AssetImage(
//                                         'assets/images/logo 1.png'),
//                                   ),
//                                   height20,
//                                   const Text(
//                                     "Welcome Back!",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 35,
//                                     ),
//                                   ),
//                                   height10,
//                                   const Text(
//                                     'Sign In',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   height20,
//                                   TextFormFieldCustom(
//                                     validator: ((value) {
//                                       return provider.emailValidation(value);
//                                     }),
//                                     labelText: 'Email',
//                                     keyboardType: TextInputType.emailAddress,
//                                     prefixIcon: FontAwesomeIcons.at,
//                                     controller: provider.email,
//                                   ),
//                                   TextFormFieldCustom(
//                                     validator: ((value) {
//                                       return provider.passwordValidation(value);
//                                     }),
//                                     labelText: 'Password',
//                                     keyboardType: TextInputType.visiblePassword,
//                                     prefixIcon: FontAwesomeIcons.lock,
//                                     controller: provider.password,
//                                     obscureText: provider.obscureText,
//                                     suffix: IconButton(
//                                       onPressed: () {
//                                         provider.passwordIsVisble();
//                                       },
//                                       icon: Icon(
//                                         !provider.obscureText
//                                             ? FontAwesomeIcons.eye
//                                             : FontAwesomeIcons.eyeSlash,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {},
//                                     child: const Text('Forget Password?'),
//                                   ),
//                                   SizedBox(
//                                     width: 350,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         elevation: 3,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         provider.goToHome(context);
//                                       },
//                                       child: const Text(
//                                         'Sign In',
//                                       ),
//                                     ),
//                                   ),
//                                   height10,
//                                   RichText(
//                                     text: TextSpan(
//                                       text: 'Don’t have an account?',
//                                       style: const TextStyle(
//                                         color: blacColor,
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                           text: ' Sign Up',
//                                           style: const TextStyle(
//                                             color: Colors.red,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               provider.goToSignUp(context);
//                                             },
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
