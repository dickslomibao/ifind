import 'package:flutter/material.dart';
import 'package:ifind/controller/auth_controller.dart';
import 'package:ifind/mixin/form_valdidation.dart';
import 'package:ifind/model/client_model.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:ifind/views/widgets/loader_widget.dart';
import 'package:ifind/views/widgets/text_field_widget.dart';

import '../../pallete.dart';
import '../../services/auth_services.dart';
import '../../services/user_type.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen>
    with FormValidate, AuthController {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   backgroundColor: Color(0xFF613cf6),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   foregroundColor: Colors.white,
      //   title:
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                color: mainColor,
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
                  const Text(
                    'Create an Account',
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
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldBuildWidget(
                                label: 'Firstname',
                                hint: 'Enter your firstname...',
                                validator: (value) {
                                  return validateFirstName(value);
                                },
                                controller: firstnameController,
                                icon: Icons.person_2_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Lastname',
                                hint: 'Enter your lastname...',
                                controller: lastnameController,
                                validator: (value) {
                                  return validateLastName(value);
                                },
                                icon: Icons.person_2_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Email',
                                hint: 'Enter your email...',
                                controller: emailController,
                                validator: (value) {
                                  return validateEmail(value);
                                },
                                icon: Icons.email_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Username',
                                hint: 'Enter your username...',
                                controller: usernameController,
                                validator: (value) {
                                  return validateUserName(value);
                                },
                                icon: Icons.contact_mail_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Password',
                                hint: 'Enter your password...',
                                controller: passwordController,
                                validator: (value) {
                                  return validatePassword(value);
                                },
                                icon: Icons.key_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Comfirm password',
                                hint: 'Enter your comfirm password...',
                                controller: comfirmController,
                                validator: (value) {
                                  return validateComfirmPassword(
                                      value, passwordController.text);
                                },
                                icon: Icons.key_rounded,
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
                                  showDialog(
                                    context: context,
                                    builder: (context) => const LoadingWidget(),
                                  );
                                  await userFirestoreServices
                                      .usernameIsAlreadyUsed(
                                          usernameController.text);
                                  if (_form.currentState!.validate()) {
                                    if (await createAccount(
                                          ClientModel(
                                            email: emailController.text,
                                            firstname: firstnameController.text,
                                            lastname: lastnameController.text,
                                            username: usernameController.text,
                                            password: passwordController.text,
                                          ),
                                        ) ==
                                        'success') {
                                      final data = await userFirestoreServices
                                          .getClientData();
                                      UserTypeServices.set(data![
                                          UserFirestoreServices.typeColumn]);
                                    }
                                  }
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
