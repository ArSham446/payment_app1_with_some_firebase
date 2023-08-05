import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:payment_app1/Pages/add_bill.dart';

import '../../component/colors.dart';
import '../../controllers/data_controller.dart';
import '../../widgets/button.dart';
import '../../widgets/multibuttons.dart';
import '../../widgets/textsize.dart';
import '../payment_page.dart';

import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tapCount = 0;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final DataController _controller = Get.put(DataController());
  bool btn = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        height: h,
        child: Stack(
          children: [
            _headSection(),
            Obx(() {
              if (_controller.loading == false) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _listBills();
              }
            }),
            _payButton(),
            _TextContainer(),
          ],
        ),
      ),
    );
  }

  _headSection() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          _mainBackground(),
          _curveImage(),
          _buttonContatiner(),
        ],
      ),
    );
  }

  _buttonContatiner() {
    return Positioned(
      bottom: 10,
      right: 50,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<dynamic>(
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return Container(
                  height: MediaQuery.of(context).size.height - 240,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: const Color(0xffeef1f4).withOpacity(0.7),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 300,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 50,
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 25),
                          width: 50,
                          height: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29),
                              color: AppColor.mainColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MultiButtons(
                                icon: Icons.cancel,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backGroundColor: Colors.white,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              MultiButtons(
                                icon: Icons.add,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backGroundColor: Colors.white,
                                onTap: () => Get.to(() => const AddBills()),
                                text: 'Add bill',
                              ),
                              MultiButtons(
                                icon: Icons.history,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backGroundColor: Colors.white,
                                onTap: () {},
                                text: 'History',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage('images/lines.png')),
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(0, 1),
                  color: const Color(0xff11324d).withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }

  _mainBackground() {
    return Positioned(
      bottom: 10,
      left: 0,
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/background.png'),
          ),
        ),
      ),
    );
  }

  _curveImage() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/curve.png'),
          ),
        ),
      ),
    );
  }

  _listBills() {
    return Positioned(
      top: 300,
      right: 0,
      left: 0,
      bottom: 0,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: _controller.list.length,
          itemBuilder: (_, index) {
            ImageProvider<Object>? imageProvider;
            String? imageUrl = _controller.list[index]['imageUrl'];

            if (imageUrl != null && imageUrl.isNotEmpty) {
              imageProvider = NetworkImage(imageUrl);
            } else {
              imageProvider = const AssetImage('images/brand1.png');
            }
            return Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              height: 130,
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffd8dbe0),
                    offset: Offset(1, 1),
                    blurRadius: 20.0,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.red, width: 3)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.list[index]['BrandName'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.mainColor),
                                ),
                                const Gap(10),
                                Text(
                                  "ID 93823",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.idColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedText(
                            text: 'Auto pay on 24th may 18',
                            color: AppColor.green),
                        const Gap(5)
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  btn = _controller.list[index]['status'] =
                                      !_controller.list[index]['status'];

                                  if (btn == true) {
                                    tapCount++;
                                  } else {
                                    tapCount--;
                                  }

                                  _controller.list.refresh();
                                });
                                print(_controller.newList);
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: _controller.list[index]['status'] ==
                                            false
                                        ? AppColor.backGroundColor
                                        : AppColor.green,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child:
                                      _controller.list[index]['status'] == false
                                          ? Text(
                                              'Select',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColor.selectColor),
                                            )
                                          : const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              '\$1284.00',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.mainColor,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'Due in 3 days',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.idColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Gap(10)
                          ],
                        ),
                        const Gap(5),
                        Container(
                          width: 5,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              color: AppColor.halfOval),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _payButton() {
    return Positioned(
      bottom: 20,
      child: Button(
        text: tapCount == 0 ? 'Pay All Bills' : 'Pay',
        textColor: Colors.white,
        onTap: () async {
          if (tapCount != 0) {
            for (int i = 0; i < _controller.newList.length; i++) {
              // await databaseReference
              //     .child("users/${_controller.newList[i]['key']}")
              //     .remove();
              Get.to(
                () => const PaymentPage(),
                arguments: {'tapCount': tapCount},
              );
            }
          } else {
            Get.to(
              () => const PaymentPage(),
              arguments: {'tapCount': tapCount},
            );
          }
        },
      ),
    );
  }

  _TextContainer() {
    return const Stack(
      children: [
        Positioned(
          top: 90,
          left: 0,
          child: Text(
            'My Bills',
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Color(0xff293952),
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 80,
          child: Text(
            'My Bills',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
