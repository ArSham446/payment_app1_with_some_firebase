import 'package:flutter/material.dart';

class SizedText extends StatelessWidget {
  final String text;
  final Color color;
  const SizedText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final Size textSiz = _textSize(text);
    return Container(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.clip,
          ),
          Row(
            children: [
              for (int i = 0; i < textSiz.width / 5; i++)
                i.isEven
                    ? Container(
                        height: 2,
                        width: 5,
                        color: color,
                      )
                    : Container(
                        height: 2,
                        width: 5,
                        color: Colors.white,
                      )
            ],
          )
        ],
      ),
    );
  }

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }
}
