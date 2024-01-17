import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/auth_controller.dart';
import 'package:ifind/mixin/form_valdidation.dart';
import 'package:ifind/model/client_model.dart';
import 'package:ifind/services/auth_services.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:ifind/views/widgets/loader_widget.dart';
import 'package:ifind/views/widgets/text_field_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../pallete.dart';
import '../../services/user_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with FormValidate, AuthController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/img-fscreen.png',
                          height: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Login your Account',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: txtColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldBuildWidget(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                },
                                label: 'Username',
                                hint: 'Enter your username...',
                                controller: usernameController,
                                validator: (value) {
                                  return validateUserName(value);
                                },
                                icon: Icons.contact_mail_rounded,
                              ),
                              TextFieldBuildWidget(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                },
                                label: 'Password',
                                hint: 'Enter your password...',
                                controller: passwordController,
                                validator: (value) {
                                  return validatePassword(value);
                                },
                                icon: Icons.key_rounded,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Forgot password ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: txtColor,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  showDialog(
                                    context: context,
                                    builder: (context) => const LoadingWidget(),
                                  );
                                  String result = await loginAccount(
                                    usernameController.text,
                                    passwordController.text,
                                  );

                                  if (result == 'success') {
                                    final data = await userFirestoreServices
                                        .getClientData();
                                    UserTypeServices.set(data![
                                        UserFirestoreServices.typeColumn]);
                                    if (context.mounted) {
                                      context.goNamed('/');
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.pop(context);

                                      final snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Opps',
                                          message: result,
                                          contentType: ContentType.failure,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    }
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Sign in',
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
