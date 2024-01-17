import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifind/model/client_model.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:ifind/model/product_model.dart';
import 'package:ifind/pallete.dart';
import 'package:ifind/services/user_type.dart';
import 'package:ifind/views/authScreens/finalized_screen.dart';
import 'package:ifind/views/authScreens/login_screen.dart';
import 'package:ifind/views/authScreens/register_client_screen.dart';
import 'package:ifind/views/authScreens/register_services_screen.dart';
import 'package:ifind/views/authScreens/select_category_screen.dart';
import 'package:ifind/views/authScreens/select_location_screen.dart';
import 'package:ifind/views/first_screen.dart';
import 'package:ifind/views/users/user_navbar_screen.dart';

import 'services/auth_services.dart';
import 'services/user_firestore.dart';
import 'views/authScreens/select_profile._screen.dart';
import 'views/establishment/home_screen.dart';
import 'views/establishment/navbar_widget.dart';
import 'views/establishment/products/add_product_screen.dart';
import 'views/establishment/products/product_screen.dart';
import 'views/establishment/products/product_view_screen.dart';
import 'views/users/select_category_screen.dart';
import 'views/users/services_view_scree.dart';
import 'views/users/user_home_screen.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) async {
    final bool isLogin =
        (authServices.getUid() != null) && UserTypeServices.type().isNotEmpty;

    if (!isLogin) {
      if (state.location == '/login') {
        return state.location;
      } else if (state.location == '/register_client') {
        return state.location;
      } else if (state.location == '/register_services') {
        return state.location;
      } else if (state.location == '/register_services/select_category') {
        return state.location;
      } else if (state.location ==
          '/register_services/select_category/mark_location') {
        return state.location;
      } else if (state.location ==
          '/register_services/select_category/mark_location/selectprofile') {
        return state.location;
      } else if (state.location ==
          '/register_services/select_category/mark_location/selectprofile/finalized') {
        return state.location;
      } else {
        return '/';
      }
    } else {
      if (state.location == "/") {
        if (UserTypeServices.type() == ClientModel.type) {
          return '/client_main_screen';
        } else {
          return '/establishment_main_screen';
        }
      } else if (state.location == '/establishment_main_screen/addproduct') {
        return state.location;
      } else if (state.location == '/establishment_main_screen/productview') {
        return state.location;
      } else if (state.location ==
          '/client_main_screen/client_select_category') {
        return state.location;
      } else if (state.location == '/client_main_screen/servicesview') {
        return state.location;
      }
    }
  },
  routes: [
    GoRoute(
      name: '/',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const FirstScreen();
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: 'register_client',
      path: '/register_client',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterClientScreen();
      },
    ),
    GoRoute(
      name: 'register_services',
      path: '/register_services',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterServicesScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'select_category',
          path: 'select_category',
          builder: (BuildContext context, GoRouterState state) {
            return SelectCategoryScreen(
              establishment: state.extra as EstablishmentModel,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'mark_location',
              path: 'mark_location',
              builder: (BuildContext context, GoRouterState state) {
                return SelectLocationScreen(
                  establishment: state.extra as EstablishmentModel,
                );
              },
              routes: <RouteBase>[
                GoRoute(
                    name: 'selectprofile',
                    path: 'selectprofile',
                    builder: (BuildContext context, GoRouterState state) {
                      return SelectProfileScreen(
                        establishment: state.extra as EstablishmentModel,
                      );
                    },
                    routes: [
                      GoRoute(
                        name: 'finalized',
                        path: 'finalized',
                        builder: (BuildContext context, GoRouterState state) {
                          return FinalizedScreen(
                            establishment: state.extra as EstablishmentModel,
                          );
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'client_main_screen',
      path: '/client_main_screen',
      builder: (BuildContext context, GoRouterState state) {
        return ClientMainScreen();
      },
      routes: [
        GoRoute(
          name: 'client_select_category',
          path: 'client_select_category',
          builder: (BuildContext context, GoRouterState state) {
            return ClientSelectCategoryScreen();
          },
        ),
        GoRoute(
          name: 'servicesview',
          path: 'servicesview/:services_id',
          builder: (BuildContext context, GoRouterState state) {
            print(state.pathParameters);
            return ServicesViewScreen(
              id: state.pathParameters['services_id']!,
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: 'establishment_main_screen',
      path: '/establishment_main_screen',
      builder: (BuildContext context, GoRouterState state) {
        return EstablishmentMainScreen();
      },
      routes: [
        GoRoute(
          name: 'addproduct',
          path: 'addproduct',
          builder: (BuildContext context, GoRouterState state) {
            return AddProductScreen();
          },
        ),
        GoRoute(
          name: 'productview',
          path: 'productview',
          builder: (BuildContext context, GoRouterState state) {
            return ProductViewScreen(
              product: state.extra as ProductModel,
            );
          },
        ),
      ],
    ),
  ],
);
