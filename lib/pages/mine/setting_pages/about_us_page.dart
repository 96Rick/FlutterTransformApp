import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/mine/all_cars/add_car_setup2_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final legalTermsPageKey = GlobalKey<ScaffoldState>();

  Widget buildAppBar() {
    return Container(
      color: TTMColors.backgroundColor,
      width: TTMSize.screenWidth,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            top: 14,
            left: 30,
            width: 35,
            height: 35,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context);
              },
              alignment: Alignment.centerLeft,
              icon: Icon(
                CupertinoIcons.back,
                size: 35,
                color: TTMColors.titleColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 40, bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TTMImage.name(TTMImage.homePageBG),
                Container(
                  width: TTMSize.screenWidth - 40,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("客服电话", style: TTMTextStyle.secondTitle),
                          Text("400-183-2223",
                              style: TextStyle(
                                  color: TTMColors.mainBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: TTMColors.cellLineColor,
                      )
                    ],
                  ),
                ),
                Container(
                  width: TTMSize.screenWidth - 40,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("版本信息", style: TTMTextStyle.secondTitle),
                          Text("V1.0", style: TTMTextStyle.secondTitle),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: TTMColors.cellLineColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      color: TTMColors.backgroundColor,
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.copyright_outlined,
                  size: 15,
                  color: TTMColors.copyrightTitle,
                ),
                Container(
                  width: 5,
                ),
                const Text(
                  'Copyright 畅图慧通网络货运平台',
                  style:
                      TextStyle(fontSize: 12, color: TTMColors.copyrightTitle),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        key: legalTermsPageKey,
        backgroundColor: TTMColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: ColorfulSafeArea(
          topColor: TTMColors.backgroundColor,
          bottomColor: TTMColors.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildAppBar(),
              buildBody(),
              buildBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
