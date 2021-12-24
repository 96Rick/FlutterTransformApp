import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/pages/goods/contract_page.dart';
import 'package:ttm/pages/goods/intention_detail/intention_detail1_page.dart';
import 'package:ttm/pages/goods/intention_detail/intention_detail2_page.dart';
import 'package:ttm/pages/goods/intention_detail/intention_detail3_page.dart';
import 'package:ttm/pages/goods/intention_detail/intention_detail4_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/dialogs.dart';
import 'package:ttm/widgets/flush_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class IntentionDetailPage extends StatefulWidget {
  const IntentionDetailPage({Key? key, required this.intentionModel})
      : super(key: key);

  final IntentionModel intentionModel;
  @override
  _IntentionDetailPageState createState() => _IntentionDetailPageState();
}

class _IntentionDetailPageState extends State<IntentionDetailPage>
    with SingleTickerProviderStateMixin {
  final intentionDetailpageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late TabController intentionDetailTabController;

  late TextEditingController tvc;

  bool isAgreeContract = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    intentionDetailTabController = TabController(length: 4, vsync: this);
    tvc = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    intentionDetailTabController.dispose();
  }

  Widget buildSaveBtn() {
    return widget.intentionModel.status == "2"
        ? Container(
            decoration: BoxDecoration(color: TTMColors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -2),
                blurRadius: 20.0,
                spreadRadius: -5,
              )
            ]),
            // height: 75,
            width: TTMSize.screenWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => isAgreeContract = !isAgreeContract);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: TTMColors.mainBlue,
                                  width: 2),
                              value: isAgreeContract,
                              checkColor: TTMColors.white,
                              activeColor: TTMColors.mainBlue,
                              onChanged: (isAgree) {
                                setState(
                                    () => isAgreeContract = !isAgreeContract);
                              }),
                          Text(
                            "已阅读并同意",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => GoodContractPage(
                                        type: GoodContractPageType.intention,
                                        intentionModel: widget.intentionModel,
                                        userName:
                                            UserInfoModel().first_name ?? "",
                                        userTel: UserInfoModel().tel ?? "",
                                      )));
                        },
                        child: Text("《承运人合同》"))
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // search
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return ReasonsDialog(
                                  contentWidget: ReasonDialog(
                                    title: "请输入拒绝原因",
                                    okBtnTap: () async {
                                      if (widget.intentionModel.id != null &&
                                          widget.intentionModel.demand.id !=
                                              null) {
                                        await Future.delayed(const Duration(
                                                microseconds: 200))
                                            .then((value) {
                                          model
                                              .refusalIntentionAction(
                                                  context,
                                                  widget.intentionModel.id!,
                                                  tvc.text,
                                                  widget.intentionModel.demand
                                                      .id!)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              FlushBarWidget.createDone(
                                                  "拒绝成功", context);
                                              model.refreshAllGoods(context);
                                              model
                                                  .refreshAllIntention(context);
                                            } else {
                                              FlushBarWidget.createDanger(
                                                  "拒绝失败", context);
                                            }
                                          });
                                        });
                                      } else {
                                        FlushBarWidget.createDanger(
                                            "拒绝失败", context);
                                      }
                                    },
                                    vc: tvc,
                                    cancelBtnTap: () {},
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 50,
                          width: TTMSize.screenWidth < 260
                              ? TTMSize.screenWidth / 2 - 20
                              : 100,
                          decoration: const BoxDecoration(
                            color: TTMColors.dangerColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Text(
                            "拒绝",
                            style: TTMTextStyle.bottomBtnTitle,
                          )),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // search
                          if (!isAgreeContract) {
                            FlushBarWidget.createDanger("请先同意承运人合同", context);
                            return;
                          }
                          if (widget.intentionModel.id != null &&
                              widget.intentionModel.demand.id != null) {
                            await Future.delayed(Duration(microseconds: 200))
                                .then((value) {
                              model
                                  .agreeIntentionAction(
                                      context,
                                      widget.intentionModel.id!,
                                      tvc.text,
                                      widget.intentionModel.demand.id!)
                                  .then((isSuccess) {
                                if (isSuccess) {
                                  Navigator.pop(context);
                                  FlushBarWidget.createDone("同意成功", context);
                                  model.refreshAllGoods(context);
                                  model.refreshAllIntention(context);
                                } else {
                                  FlushBarWidget.createDanger("同意失败", context);
                                }
                              });
                            });
                          } else {
                            FlushBarWidget.createDanger("同意失败", context);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: TTMSize.screenWidth < 260
                              ? TTMSize.screenWidth / 2 - 20
                              : 100,
                          decoration: const BoxDecoration(
                            color: TTMColors.myInfoSaveBtnColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Text(
                            "同意",
                            style: TTMTextStyle.bottomBtnTitle,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return ColorfulSafeArea(
        topColor: TTMColors.mainBlue,
        bottomColor: TTMColors.white,
        child: Scaffold(
          key: intentionDetailpageKey,
          backgroundColor: TTMColors.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leadingWidth: 100,
            title: const Text(
              "意向详情",
              // style: TTMTextStyle.whiteAppBarTitle,
            ),
            centerTitle: true,
            backgroundColor: TTMColors.mainBlue,
            elevation: 0,
            bottom: TabBar(
                indicatorColor: TTMColors.white,
                indicatorSize: TabBarIndicatorSize.label,
                controller: intentionDetailTabController,
                isScrollable: true,
                labelStyle: TTMTextStyle.appBottomTabBarSecondSelectedTitle,
                unselectedLabelStyle:
                    TTMTextStyle.appBottomTabBarSecondUnselectedTitle,
                tabs: [
                  Tab(
                    text: "基本信息",
                  ),
                  Tab(
                    text: "托运方信息",
                  ),
                  Tab(
                    text: "承运方信息",
                  ),
                  Tab(
                    text: "货品信息及总计",
                  ),
                ]),
          ),
          body: Stack(
            children: [
              Positioned(
                top: 0,
                height: 50,
                right: 0,
                left: 0,
                child: Container(
                    height: 50,
                    color: TTMColors.warning,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "注意：请勿托运危险品货物！",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              const url = TTMConstants.warningUrl;
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                  forceWebView: false,
                                  headers: <String, String>{
                                    'my_header_key': 'my_header_value'
                                  },
                                );
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              "《禁止托运物品清单》",
                              style: TextStyle(
                                color: TTMColors.link,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Positioned(
                bottom: 75,
                right: 0,
                left: 0,
                top: 50,
                child: TabBarView(
                  children: [
                    IntentionDetailBaseInfoPage(
                      intentionModel: widget.intentionModel,
                    ),
                    IntentionShipperInfoPage(
                      intentionModel: widget.intentionModel,
                    ),
                    IntentionCarrierInfoPage(
                      intentionModel: widget.intentionModel,
                    ),
                    IntentionDetailGoodInfoPage(
                      intentionModel: widget.intentionModel,
                    ),
                  ],
                  controller: intentionDetailTabController,
                ),
              ),
              Positioned(bottom: 0, right: 0, left: 0, child: buildSaveBtn())
            ],
          ),
        ),
      );
    });
  }
}
