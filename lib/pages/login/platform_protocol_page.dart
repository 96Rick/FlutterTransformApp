import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class PlatformProtocolPage extends StatelessWidget {
  const PlatformProtocolPage({Key? key}) : super(key: key);
  Widget buildAppBar() {
    return TTMAppBar(
        title: "法律条款与平台规则",
        bgColor: TTMColors.backgroundColor,
        titleColor: TTMColors.titleColor);
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
                // buildCarInfo(),
                Container(
                    width: TTMSize.screenWidth - 40,
                    height: 20,
                    child: Text(
                      "隐私政策",
                      style: TTMTextStyle.thirdTitle,
                    )),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: TTMColors.cellLineColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(TTMConstants.policyStr),
                ),

                Container(
                  height: 30,
                ),
                Container(
                  color: TTMColors.cellLineColor,
                  height: 1,
                ),
                Container(
                  height: 20,
                ),

                Container(
                    width: TTMSize.screenWidth - 40,
                    height: 20,
                    child: Text(
                      "平台规则",
                      style: TTMTextStyle.thirdTitle,
                    )),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: TTMColors.cellLineColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(TTMConstants.platformProtocol),
                ),
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
        backgroundColor: TTMColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: ColorfulSafeArea(
          topColor: TTMColors.backgroundColor,
          bottomColor: TTMColors.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
