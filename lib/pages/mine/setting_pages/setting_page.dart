import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/mine/setting_pages/about_us_page.dart';
import 'package:ttm/pages/mine/setting_pages/legal_terms_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    super.initState();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: "设置",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // buildCarInfo(),
                SizedBox(
                  width: TTMSize.screenWidth - 40,
                  height: 80,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const LegalTermsPage()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnconstrainedBox(
                            child: Row(
                          children: [
                            mineLaw(size: 25, color: TTMColors.mainBlue),
                            Container(
                              width: 10,
                            ),
                            const Text("法律条款及平台规则",
                                style: TTMTextStyle.secondTitle),
                          ],
                        )),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: TTMColors.cellLineColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                  width: TTMSize.screenWidth - 40,
                  height: 80,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const AboutUsPage()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnconstrainedBox(
                            child: Row(
                          children: [
                            mineAboutus(size: 22, color: TTMColors.warning),
                            Container(
                              width: 15,
                            ),
                            const Text("关于我们", style: TTMTextStyle.secondTitle),
                          ],
                        )),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutBtn() {
    return Container(
      decoration: BoxDecoration(color: TTMColors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -2),
          blurRadius: 20.0,
          spreadRadius: -5,
        ),
      ]),
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            // save
            Navigator.pop(context);
            model.logout();
          },
          child: Container(
            height: 50,
            width: TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
            decoration: const BoxDecoration(
              color: TTMColors.dangerColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mineLogout3(size: 20, color: TTMColors.white),
                Container(
                  width: 5,
                ),
                Text(
                  "退出登陆",
                  style: TTMTextStyle.bottomBtnTitle,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          key: settingPageKey,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: false,
          body: ColorfulSafeArea(
            topColor: TTMColors.white,
            bottomColor: TTMColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAppBar(),
                buildBody(),
                buildLogoutBtn(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
