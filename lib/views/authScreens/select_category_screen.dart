import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/category_controller.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:provider/provider.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key, required this.establishment});
  final EstablishmentModel establishment;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = context.read<CategoryController>();
    return Scaffold(
      floatingActionButton: SizedBox(
        width: width * .92,
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF613cf6),
          onPressed: () {
            establishment.services.clear();
            establishment.servicesName.clear();
            for (var item in provider.category) {
              if (item.status) {
                establishment.services.add(item.id);
                establishment.servicesName.add(item.name);
              }
            }
            context.pushNamed('mark_location', extra: establishment);
          },
          label: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward_sharp)
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                color: Color(0xFF613cf6),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: const Color(0xFF7555f7),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 80,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      bottom: 25.0,
                      top: 25.0,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Select the categories offered\nby your services.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<CategoryController>(
                          builder: (context, value, child) {
                            if (value.isLoading) {
                              value.getAllCategory();
                              return const SizedBox(
                                height: 300,
                                child:  Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return ListView.builder(
                              physics: const ScrollPhysics(
                                parent: PageScrollPhysics(),
                              ),
                              shrinkWrap: true,
                              itemCount: value.category.length,
                              itemBuilder: (context, index) {
                                final item = value.category[index];
                                return ListTile(
                                  leading: Checkbox(
                                    activeColor: const Color(0xFF7555f7),
                                    value: item.status,
                                    onChanged: (_) {
                                      item.toggleStatus();

                                      value.reBuild();
                                    },
                                  ),
                                  title: Text(item.name),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
