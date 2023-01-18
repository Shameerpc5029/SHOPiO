import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/widgets/circle_button.dart';
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
      body: provider.model == null || provider.model!.products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    width: 100,
                    image: AssetImage(
                      "assets/images/wishlist.png",
                    ),
                  ),
                  CSizedBox().height10,
                  const Text(
                    "Your wishlist is empty!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  const Text(
                    'Click ❤️to save products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: greyColor,
                    ),
                  ),
                  CSizedBox().height20,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Provider.of<BottomNavProvider>(context, listen: false)
                          .gotoHomescreen();
                    },
                    child: const Text('Find items to save'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.model?.products.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
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
                      "₹${(provider.model!.products[index].product.price - provider.model!.products[index].product.discountPrice).round()}",
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
