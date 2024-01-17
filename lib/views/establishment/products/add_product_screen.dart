import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/views/widgets/text_field_widget.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../../controller/establishment/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../pallete.dart';
import '../../widgets/multiline_text_field_widget.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Row(
          children: const [
            Icon(Icons.location_on_rounded),
            Text(
              'Add Product',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: mainColor,
        elevation: 0,
        actions: const [
          Icon(Icons.notifications_rounded),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout_rounded),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldBuildWidget(
                    label: "Product Name",
                    hint: 'Enter product name...',
                    controller: nameController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Product Name is required.";
                      }
                    },
                    icon: Icons.search_rounded,
                  ),
                  TextFieldBuildWidget(
                    label: "Price",
                    hint: 'Enter product price...',
                    controller: priceController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Product Name is required.";
                      }
                      if (double.tryParse(value) == null) {
                        return "Invalid product price.";
                      }
                    },
                    icon: Icons.search_rounded,
                  ),
                  SizedBox(
                    height: 200,
                    child: MultiLineTextFieldBuildWidget(
                      label: "Description",
                      hint: 'Enter product description...',
                      controller: descController,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Description is required.";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MultiImagePickerView(
                    controller: controller,
                    padding: const EdgeInsets.all(0),
                    initialContainerBuilder: (context, pickerCallback) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: pickerCallback,
                        child: const Padding(
                          padding: EdgeInsets.all(60),
                          child: Text(
                            'Upload Images',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ProductModel product = ProductModel(
                          available: true,
                          description: descController.text,
                          name: nameController.text,
                          price: double.parse(
                            priceController.text,
                          ),
                        );
                        final images = controller.images;
                        for (final image in images) {
                          if (image.hasPath) {
                            final photo = File(image.path!);

                            final fileName = basename(photo.path);
                            final destination =
                                'files/${DateTime.now().microsecondsSinceEpoch}$fileName';
                            try {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child(destination);
                              await ref.putFile(photo);
                              product.images.add(await ref.getDownloadURL());
                            } catch (e) {
                              print('error occured');
                            }
                          }
                        }
                        if (context.mounted) {
                          context.read<ProductController>().addProduct(product);
                          context.pop();
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
