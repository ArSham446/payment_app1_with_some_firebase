import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../component/colors.dart';
import '../controllers/data_controller.dart';
import '../widgets/button.dart';
import '../widgets/multibuttons.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final tapCount = arguments['tapCount'] as int;

    final DataController _controller = Get.put(DataController());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 61, left: 20, right: 20),
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/paymentbackground.png'),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: h * 0.14,
              padding: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('images/success.png'),
                ),
              ),
            ),
            const Text(
              'Success !',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.mainColor,
              ),
            ),
            Text(
              'Payment is completed for ${_controller.newList.length} bills',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.idColor,
              ),
            ),
            SizedBox(
              height: h * .045,
            ),
            Container(
              height: 160,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: tapCount == 0
                      ? _controller.list.length
                      : _controller.newList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(5),
                                  Text(
                                    tapCount == 0
                                        ? _controller.list[index]['BrandName']
                                        : _controller.newList[index]
                                            ['BrandName'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.mainColor),
                                  ),
                                  const Gap(10),
                                  Text(
                                    'ID 463674',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.idColor,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(30),
                              const Column(
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.mainColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Gap(10),
                                  Text(
                                    '\$1284.00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.mainColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Column(
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.idColor,
                  ),
                ),
                const Gap(5),
                const Text(
                  '\$2840.00',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColor.mainColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MultiButtons(
                  icon: Icons.share_sharp,
                  text: 'Share',
                  onTap: () {},
                ),
                SizedBox(
                  width: w * 0.2,
                ),
                MultiButtons(
                  icon: Icons.print_sharp,
                  text: 'Print',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: h * .02,
            ),
            Button(
              text: 'Done',
              backGroundColor: Colors.white,
              onTap: () {
                _controller.loadData;
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
