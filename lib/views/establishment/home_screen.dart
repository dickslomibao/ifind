import 'package:flutter/material.dart';

import '../../pallete.dart';

class EstablishmentHomeScreen extends StatelessWidget {
  const EstablishmentHomeScreen({super.key});

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
    );
  }
}
