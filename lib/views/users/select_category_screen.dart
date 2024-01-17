import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/category_controller.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:ifind/pallete.dart';
import 'package:provider/provider.dart';

class ClientSelectCategoryScreen extends StatelessWidget {
  const ClientSelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = context.read<CategoryController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: mainColor,
        onPressed: () {},
        label: const Text(
          'iFind',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
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
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 20,
                    // bottom: 80,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Select the categories you want\nto locate.',
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
                                child: Center(
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
