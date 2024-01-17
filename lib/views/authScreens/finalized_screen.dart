import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/auth_controller.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:ifind/views/widgets/build_finalized_data.dart';
import 'package:ifind/views/widgets/loader_widget.dart';
import 'package:path/path.dart';
import '../../services/user_type.dart';

class FinalizedScreen extends StatefulWidget {
  const FinalizedScreen({super.key, required this.establishment});
  final EstablishmentModel establishment;

  @override
  State<FinalizedScreen> createState() => _FinalizedScreenState();
}

class _FinalizedScreenState extends State<FinalizedScreen> with AuthController {
  bool show = false;

  String buildAsterisk(int count) {
    String data = "";
    for (int i = 0; i < count; i++) {
      data += '*';
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: width * .92,
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF613cf6),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => const LoadingWidget(),
            );
            if (await createAccount(widget.establishment) == 'success') {
              final data = await userFirestoreServices.getClientData();
              UserTypeServices.set(data![UserFirestoreServices.typeColumn]);
              if (context.mounted) {
                context.push('/');
              }
            }
          },
          label: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Sign Up',
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
                    'Business Information',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            'Please check your information\nand credentials.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuildDataLabel(
                          label: 'Establishment Name',
                          data: widget.establishment.businessName,
                        ),
                        BuildDataLabel(
                          label: 'Owner\'s Name',
                          data: widget.establishment.ownerName,
                        ),
                        BuildDataLabel(
                          label: 'Address',
                          data: widget.establishment.address,
                        ),
                        const Divider(),
                        BuildDataLabel(
                          label: 'Email',
                          data: widget.establishment.email,
                        ),
                        BuildDataLabel(
                          label: 'Username',
                          data: widget.establishment.username,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildDataLabel(
                              label: 'Password',
                              data: show
                                  ? widget.establishment.password
                                  : buildAsterisk(
                                      widget.establishment.password.length),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                              child: Icon(
                                show ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        BuildDataLabel(
                          label: 'Services',
                          data: widget.establishment.servicesName.join('\n'),
                        ),
                        const SizedBox(
                          height: 50,
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
