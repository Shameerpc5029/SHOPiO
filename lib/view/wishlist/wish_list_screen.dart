import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/widgets/circle_button.dart';
import 'package:ecommerce/view/wishlist/widgets/shimmer/wish_list_shimmer.dart';
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
      body: SingleChildScrollView(
        child: provider.model == null || provider.model!.products.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: const Center(
                  child: Text(
                    'Wish List is Empty',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.model?.products.length ?? 0,
                itemBuilder: (context, index) {
                  return provider.isLoading == true
                      ? const WishListShimmer()
                      : ListTile(
                          onTap: () {
                            provider.wishListToProduct(context, index);
                          },
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
                            "₹${provider.model!.products[index].product.price - provider.model!.products[index].product.discountPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: priceColor,
                            ),
                          ),
                          trailing: CircleButtonWidget(
                            onPressed: () {
                              provider.addAndRemoveWishList(context,
                                  provider.model!.products[index].product.id);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.xmark,
                              color: greyColor,
                            ),
                          ),
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
      ),
    );
  }
}
