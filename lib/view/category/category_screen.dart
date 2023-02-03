import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/connection/connecton_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetCheck>(context, listen: false).getConnectivity(context);

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
            return value.isLoading == true
                ? const LoadingWidget()
                : ListView.separated(
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
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:AppColor(). whiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              radius: 45,
                              onTap: () {
                                value.goToCategoryProductView(context, index);
                              },
                              child: value.isLoading == true
                                  ? const LoadingWidget()
                                  : CircleAvatar(
                                      backgroundColor: Colors.white24,
                                      radius: 40,
                                      child: Hero(
                                        transitionOnUserGestures: true,
                                        tag: value.categoryList[index].id,
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundColor:AppColor(). whiteColor,
                                          backgroundImage: NetworkImage(
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
