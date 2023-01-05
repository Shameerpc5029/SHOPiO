import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  CSizedBox().height10,
                  value.isLoading == true
                      ? const LoadingWidget()
                      : GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            childAspectRatio: 4 / 4,
                          ),
                          itemCount: value.categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                value.goToCategoryProductView(context, index);
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: 35,
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
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
