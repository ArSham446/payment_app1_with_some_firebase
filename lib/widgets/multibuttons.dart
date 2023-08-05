import 'package:flutter/material.dart';

import '../component/colors.dart';

class MultiButtons extends StatelessWidget {
  final double? fontSize;
  final IconData icon;
  final Function()? onTap;
  final Color? backGroundColor;
  final Color? iconColor;
  final Color? textColor;
  final String? text;
  const MultiButtons({
    super.key,
    this.backGroundColor = AppColor.mainColor,
    this.fontSize,
    required this.icon,
    this.iconColor = Colors.white,
    this.onTap,
    this.textColor = AppColor.mainColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backGroundColor,
            ),
            child: Icon(
              icon,
              size: 25,
              color: iconColor,
            ),
          ),
          text != null
              ? Text(
                  text!,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
