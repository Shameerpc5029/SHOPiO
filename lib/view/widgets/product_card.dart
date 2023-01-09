import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.onTap,
    required this.offer,
    required this.image,
    required this.name,
    required this.price,
    required this.discountPrice,
  }) : super(key: key);

  final void Function() onTap;
  final String offer;
  final String image;
  final String name;
  final String price;
  final String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: GridTile(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: offerColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    offer,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 120,
                image: NetworkImage(
                  image,
                ),
              ),
              CSizedBox().height10,
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
              CSizedBox().height10,
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: greyColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                discountPrice,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: priceColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
