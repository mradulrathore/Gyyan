// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';

Widget headLine(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyle.headline,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 36,
          height: 2.5,
          color: AppColor.iconGrey,
        ),
      ],
    ),
  );
}
