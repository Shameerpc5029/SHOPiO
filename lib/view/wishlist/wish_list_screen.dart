import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishListProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wish List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.model?.products.length ?? 0,
              itemBuilder: (context, index) {
                return provider.isLoading == true
                    ? const LoadingWidget()
                    : provider.model == null || provider.model!.products.isEmpty
                        ? const Center(
                            heightFactor: 110,
                            child: Text('Wish List is Empty'),
                          )
                        : ListTile(
                            leading: Container(
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  '${ApiUrl.apiUrl}/products/${provider.model!.products[index].product.image[0]}',
                                ),
                              )),
                            ),
                            title: Text(
                              provider.model!.products[index].product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "₹${provider.model!.products[index].product.price}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: redColor,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.solidHeart,
                                color: redColor,
                              ),
                            ),
                          );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ));
  }
}