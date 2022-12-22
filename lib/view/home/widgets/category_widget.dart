
import 'package:ecommerce/controller/home/category_provider.dart';
import 'package:ecommerce/view/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                child: InkWell(
                  radius: 0,
                  onTap: () {},
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          'http://172.16.7.220:5005/uploads/category/${value.categoryList[index].image}',
                        ),
                      ),
                      height10,
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
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: value.categoryList.length,
          ),
        );
      },
    );
  }
}
