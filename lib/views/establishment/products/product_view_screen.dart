import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../model/product_model.dart';
import '../../../pallete.dart';

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  width: double.infinity,
                  child: MasonryGridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.images.length,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index) {
                      List<String> image = product.images;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          child: Image.network(
                            image[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.black45,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.black45,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ),

                            // Array list of items
                            items: const [
                              DropdownMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              DropdownMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade50,
                ),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: txtColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Price: " + product.price.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 15,
                        color: txtColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: txtColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: secondaryColor,
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         onPressed: () async {},
              //         child: const Padding(
              //           padding: EdgeInsets.all(16.0),
              //           child: Text(
              //             'Edit product',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: mainColor,
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         onPressed: () async {},
              //         child: const Padding(
              //           padding: EdgeInsets.all(16.0),
              //           child: Text(
              //             'Delete product',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
