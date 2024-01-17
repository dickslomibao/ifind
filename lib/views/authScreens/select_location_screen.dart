import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifind/controller/reg_mark_map_controller.dart';
import 'package:ifind/model/establishment_model.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:provider/provider.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key, required this.establishment});
  final EstablishmentModel establishment;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = context.read<RegMapController>();
    return Scaffold(
      floatingActionButton: SizedBox(
        width: width * .92,
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF613cf6),
          onPressed: () {
            establishment.address = provider.address;
            establishment.coordinates = provider.coordinates;
            context.pushNamed('selectprofile', extra: establishment);
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
                    'Select Location',
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
                      left: 10.0,
                      right: 10.0,
                      bottom: 25.0,
                      top: 10.0,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Mark the location of your\nEstablishment.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<RegMapController>(
                          builder: (context, value, child) => Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              SizedBox(
                                height: height - 380,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    onTap: (positon) {
                                      value.tapMap(positon);
                                    },
                                    markers: value.marker,
                                    initialCameraPosition: const CameraPosition(
                                      zoom: 10,
                                      tilt: 60,
                                      target: LatLng(
                                        15.975803,
                                        120.570693,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (value.address.isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(
                                    right: 60,
                                    left: 55,
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Establishment Address',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        value.address,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
