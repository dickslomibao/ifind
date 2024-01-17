import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/controller/auth_controller.dart';
import 'package:ifind/mixin/form_valdidation.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:ifind/views/widgets/loader_widget.dart';
import 'package:ifind/views/widgets/text_field_widget.dart';

class RegisterServicesScreen extends StatefulWidget {
  const RegisterServicesScreen({super.key});

  @override
  State<RegisterServicesScreen> createState() => _RegisterServicesScreenState();
}

class _RegisterServicesScreenState extends State<RegisterServicesScreen>
    with FormValidate, AuthController {
  final TextEditingController establishmentController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmController = TextEditingController();
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
                          height: 10,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldBuildWidget(
                                label: 'Establishment Name',
                                hint: 'Enter establishment name...',
                                validator: (value) {
                                  return validateFirstName(value);
                                },
                                controller: establishmentController,
                                icon: Icons.business_rounded,
                              ),
                              TextFieldBuildWidget(
                                label: 'Owner\'s name',
                                hint: 'Enter owner\'s name...',
                                controller: ownerController,
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
                                  backgroundColor: const Color(0xFF613cf6),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () async {
                                  if (sanitaize(usernameController)
                                      .isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (
                                        context,
                                      ) =>
                                          const LoadingWidget(),
                                    );
                                    await userFirestoreServices
                                        .usernameIsAlreadyUsed(
                                            usernameController.text);
                                  }
                                  if (_form.currentState!.validate()) {
                                    if (context.mounted) {
                                      context.pop();
                                      context.pushNamed(
                                        'select_category',
                                        extra: EstablishmentModel(
                                          businessName: sanitaize(
                                            establishmentController,
                                          ),
                                          ownerName: sanitaize(
                                            ownerController,
                                          ),
                                          email: sanitaize(
                                            emailController,
                                          ),
                                          password: sanitaize(
                                            passwordController,
                                          ),
                                          username: sanitaize(
                                            usernameController,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
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
