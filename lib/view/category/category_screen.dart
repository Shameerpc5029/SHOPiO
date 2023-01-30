import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          stops: const [0.1, 0.3, 0.6, 0.9, 0.9],
                          colors: [
                            Colors.blue.shade300,
                            const Color.fromARGB(210, 18, 79, 129),
                            const Color.fromARGB(255, 5, 46, 79),
                            const Color.fromARGB(255, 0, 5, 40),
                            const Color.fromARGB(255, 0, 5, 40),
                          ],
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          value.goToCategoryProductView(context, index);
                        },
                        title: Text(
                          value.categoryList[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          value.goToCategoryProductView(context, index);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${ApiUrl.apiUrl}/category/${value.categoryList[index].image}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: value.categoryList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
