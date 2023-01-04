import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/category/category_view/category_view.dart';
import 'package:ecommerce/view/home/widgets/shimmer/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return value.categoryList.isEmpty
            ? const CategoryShimmer()
            : SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            CategoryView.routeName,
                            arguments: value.categoryList[index].id,
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 33,
                              backgroundImage: NetworkImage(
                                '${ApiUrl.apiUrl}/category/${value.categoryList[index].image}',
                              ),
                            ),
                            CSizedBox().height10,
                            Text(
                              value.categoryList[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.categoryList.length,
                ),
              );
      },
    );
  }
}
