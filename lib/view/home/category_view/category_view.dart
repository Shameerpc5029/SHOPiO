// import 'package:ecommerce/common/constants/api_url.dart';
// import 'package:ecommerce/controller/home/home_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';

// class CategoryView extends StatelessWidget {
//   static const routeName = "/category_view.dart";

//   const CategoryView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//       final productId = ModalRoute.of(context)?.settings.arguments as String;
//     final provider = Provider.of<HomeProvider>(context).findById(productId);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage('${ApiUrl.apiUrl}/products/${provider.category.contains(productId)}'),
//               ),
//               title: Text(
//                 provider.category[index],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
