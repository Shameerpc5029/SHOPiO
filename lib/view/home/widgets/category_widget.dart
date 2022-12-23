import 'dart:developer';

import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
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
        return SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                child: InkWell(
                  radius: 0,
                  onTap: () {
                    log(value.productList[index].name.toString());
                  },
                  child: Column(
                    children: [
                      value.isLoading == true
                          ? const CircleAvatar(
                              radius: 35,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 33,
                              backgroundImage: NetworkImage(
                                '${ApiUrl.apiUrl}/uploads/category/${value.categoryList[index].image}',
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
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: value.categoryList.length,
          ),
        );
      },
    );
  }
}
