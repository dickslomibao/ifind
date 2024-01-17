import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/views/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../controller/establishment/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../pallete.dart';
import '../../../services/auth_services.dart';
import '../../../services/product_services.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Row(
          children: const [
            Icon(Icons.location_on_rounded),
            Text(
              'iFind',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          Icon(Icons.notifications_rounded),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.push('/');
            },
            child: Icon(Icons.logout_rounded),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product list',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: txtColor,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      context.pushNamed('addproduct');
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.add),
                        Text(
                          'Add Product',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextFieldBuildWidget(
                label: "",
                hint: 'Search Product...',
                controller: TextEditingController(),
                validator: (value) {},
                icon: Icons.search_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: context.watch<ProductController>().initProduct(authServices.getUid()!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return Expanded(
                    child: MasonryGridView.builder(
                      itemCount: context.read<ProductController>().size,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        List<ProductModel> data =
                            context.read<ProductController>().products;
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed('productview',
                                extra: data[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    data[index].images.first,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: txtColor,
                                  ),
                                ),
                                Text(
                                  'Price: ${data[index].price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const Text(
                                  'Ratings: 0',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// return Expanded(
//                     child: GridView.builder(
//                       itemCount: context.read<ProductController>().size,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 10,
//                         crossAxisCount: 2,
//                         mainAxisExtent: 275,
//                       ),
//                       itemBuilder: (context, index) {
//                         List<ProductModel> data =
//                             context.read<ProductController>().products;

//                         return Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 180,
//                                 width: double.infinity,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5),
//                                   child: Image.network(
//                                     data[index].images.first,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 data[index].name,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: txtColor,
//                                 ),
//                               ),
//                               Text(
//                                 'Price: ${data[index].price}',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               const Text(
//                                 'Ratings: 0',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );