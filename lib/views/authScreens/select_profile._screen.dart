import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/category_controller.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:provider/provider.dart';
import '../../pallete.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SelectProfileScreen extends StatefulWidget {
  SelectProfileScreen({super.key, required this.establishment});
  final EstablishmentModel establishment;

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  File? _photo;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {}
    });
  }

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
            widget.establishment.photo = _photo;
            context.pushNamed('finalized', extra: widget.establishment);
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
                    'Profile Picture',
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
                          'Select your establishment\nprofile picture.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            await imgFromGallery();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Select image',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        _photo == null
                            ? const SizedBox(
                                height: 150,
                                width: 150,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _photo!,
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
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
