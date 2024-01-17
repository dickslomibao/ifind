import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifind/controller/client/services_view_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../controller/client/home_controller.dart';
import '../../controller/establishment/product_controller.dart';
import '../../model/product_model.dart';
import '../../pallete.dart';
import '../../services/user_firestore.dart';

class ServicesViewScreen extends StatefulWidget {
  const ServicesViewScreen({super.key, required this.id});
  final String id;

  @override
  State<ServicesViewScreen> createState() => _ServicesViewScreenState();
}

class _ServicesViewScreenState extends State<ServicesViewScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
    _tabController = TabController(length: 3, vsync: this);
  }

  bool showAddReview = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final swcWatch = context.watch<ServicesViewController>();
    final swcRead = context.read<ServicesViewController>();
    if (swcWatch.loading) {
      swcRead.initData(widget.id);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: swcWatch.loading
          ? Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(),
                  child: Image.network(
                    swcRead.information[UserFirestoreServices.profileColumn],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(top: 300),
                  height: height - 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TabBar(
                          indicatorColor: mainColor,
                          isScrollable: true,
                          controller: _tabController,
                          labelColor: Colors.black,
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(
                              text: "Products",
                            ),
                            Tab(
                              text: "Explore",
                            ),
                            Tab(
                              text: "Reviews",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              FutureBuilder(
                                future: context
                                    .watch<ProductController>()
                                    .initProduct(widget.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  return MasonryGridView.builder(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    itemCount:
                                        context.read<ProductController>().size,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      List<ProductModel> data = context
                                          .read<ProductController>()
                                          .products;
                                      return GestureDetector(
                                        onTap: () {
                                          context.pushNamed('productview',
                                              extra: data[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                  );
                                },
                              ),
                              SizedBox(),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: ListView.builder(
                                        itemCount: 200,
                                        itemBuilder: (context, index) =>
                                            Text(index.toString()),
                                      ),
                                    )),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            useSafeArea: true,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(40),
                                              ),
                                            ),
                                            builder: (context) => Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 20,
                                                  right: 20,
                                                  left: 20,
                                                  bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom +
                                                      20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      'Review:',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          TextEditingController(),
                                                      maxLines: 5,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 18,
                                                          horizontal: 10,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        hintText:
                                                            'Enter your review here...',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      'Ratings:',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating:
                                                          _initialRating,
                                                      minRating: 1,
                                                      direction: _isVertical
                                                          ? Axis.vertical
                                                          : Axis.horizontal,
                                                      allowHalfRating: true,
                                                      unratedColor: Colors.amber
                                                          .withAlpha(50),
                                                      itemCount: 5,
                                                      itemSize: 30.0,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        _selectedIcon ??
                                                            Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        setState(() {
                                                          _rating = rating;
                                                          print(_rating);
                                                        });
                                                      },
                                                      updateOnDrag: true,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  mainColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              )),
                                                      onPressed: () async {},
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Text(
                                                          'Add review',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('Add review'),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: 120,
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 250,
                  ),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: const Offset(0, 15),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        swcRead.information[
                            UserFirestoreServices.businessNameColumn],
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: txtColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: txtColor,
                        ),
                      ),
                      Text(
                        swcRead
                            .information[UserFirestoreServices.addressColumn],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: txtColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 45,
                            width: 45,
                            color: Colors.black38,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            height: 45,
                            width: 45,
                            color: Colors.black38,
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.orange.shade700,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
