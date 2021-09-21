// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/provider.dart';
import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';

class NewsCardAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        // color: Colors.white,
        child: Container(
          height: 52,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(FeatherIcons.chevronLeft),
                            color: AppColor.accent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            "Search",
                            style: AppTextStyle.appBarTitle,
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Consumer<FeedProvider>(
                    builder: (context, value, child) =>
                        value.getCurentArticalIndex != 0
                            ? IconButton(
                                icon: Icon(FeatherIcons.arrowUp),
                                onPressed: () {
                                  value.getfeedPageController.animateToPage(0,
                                      duration: Duration(milliseconds: 700),
                                      curve: Curves.easeInBack);
                                })
                            : Container(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
