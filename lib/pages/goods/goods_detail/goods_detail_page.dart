import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/pages/goods/contract_page.dart';
import 'package:ttm/pages/goods/goods_detail/goods_detail1_page.dart';
import 'package:ttm/pages/goods/goods_detail/goods_detail2_page.dart';
import 'package:ttm/pages/goods/goods_detail/goods_detail3_pag.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/dialogs.dart';
import 'package:ttm/widgets/flush_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class GoodDetailPage extends StatefulWidget {
  const GoodDetailPage({Key? key, required this.good}) : super(key: key);

  final GoodModel good;

  @override
  _GoodDetailPageState createState() => _GoodDetailPageState();
}

class _GoodDetailPageState extends State<GoodDetailPage>
    with SingleTickerProviderStateMixin {
  final goodDetailPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late TabController goodDetailTabController;
  bool isAgreeContract = false;

  // late double totalVolume = 0;
  // late double totalWeight = 0;
  // late double totalCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    goodDetailTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    goodDetailTabController.dispose();
  }

  // void calculateTotalNumber() {
  //   totalVolume = 0;
  //   totalWeight = 0;
  //   totalCount = 0;
  //   for (var item in widget.good.goods) {
  //     if (item.count != null) {
  //       totalCount += item.count!;
  //     }
  //     if (item.weight != null && item.count != 0 && item.count != null) {
  //       totalWeight += (item.weight! * item.count!);
  //     }
  //     if (item.volume != null) {
  //       totalVolume += item.volume!;
  //     }
  //   }
  // }

  Widget buildSaveBtn() {
    return Container(
      decoration: BoxDecoration(color: TTMColors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -2),
          blurRadius: 20.0,
          spreadRadius: -5,
        )
      ]),
      // height: 120,
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
                          setState(() => isAgreeContract = !isAgreeContract);
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
                                  type: GoodContractPageType.good,
                                  goodModel: widget.good,
                                  userName: UserInfoModel().first_name ?? "",
                                  userTel: UserInfoModel().tel ?? "",
                                )));
                  },
                  child: Text("《承运人合同》"))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () async {
                // search
                if (!isAgreeContract) {
                  FlushBarWidget.createDanger("请先同意承运人合同", context);
                  return;
                }
                if (UserInfoModel().driver == null ||
                    UserInfoModel().driver == "") {
                  FlushBarWidget.createDanger("司机信息不完全或审核未通过，无法进行抢单操作!", context);
                  return;
                }
                if (model.myDetailInfoModel.status == "3" ||
                    model.myDetailInfoModel.status == "1") {
                  FlushBarWidget.createDanger(
                      "您的个人信息申请正等待审核或已被拒绝，无法抢单", context);
                  return;
                }
                var carList = await model.getAllGoodBidCarsList(context);
                if (carList.isEmpty) {
                  FlushBarWidget.createDanger("当前暂无可用承运车辆，不能进行抢单操作", context);
                  return;
                }
                if (widget.good.id != null) {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CarListDialog(
                          contentWidget: CarListsDialog(
                            goodTotalWidget: widget.good.totalWeight ?? 100000,
                            title: "请选择您的承运车辆",
                            cancelBtnTitle: "取消",
                            okBtnTitle: "确认",
                            carList: carList,
                            okBtnTap: (id) async {
                              await Future.delayed(Duration(microseconds: 200))
                                  .then((value) {
                                model
                                    .goodBidRequest(
                                  context,
                                  widget.good.id!,
                                  id,
                                )
                                    .then((isSuccess) {
                                  if (isSuccess) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    FlushBarWidget.createDone("抢单成功", context);
                                    model.refreshAllGoods(context);
                                    model.refreshAllIntention(context);
                                  } else {
                                    FlushBarWidget.createDone("抢单失败", context);
                                  }
                                });
                              });
                            },
                            cancelBtnTap: () {},
                          ),
                        );
                      });
                } else {
                  FlushBarWidget.createDanger("当前货物出错，不能进行抢单操作", context);
                }
              },
              child: Container(
                height: 50,
                width:
                    TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
                decoration: BoxDecoration(
                  color: (model.myDetailInfoModel.status == "3" ||
                          model.myDetailInfoModel.status == "1")
                      ? Colors.grey
                      : TTMColors.myInfoSaveBtnColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      "抢单",
                      style: TTMTextStyle.bottomBtnTitle,
                    )),
                    Container(
                      width: 5,
                    ),
                    waybillQiangdan(size: 20, color: TTMColors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // calculateTotalNumber();
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return ColorfulSafeArea(
        topColor: TTMColors.mainBlue,
        bottomColor: TTMColors.white,
        child: Scaffold(
          backgroundColor: TTMColors.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leadingWidth: 100,
            title: const Text(
              "货品详情",
              // style: TTMTextStyle.whiteAppBarTitle,
            ),
            centerTitle: true,
            backgroundColor: TTMColors.mainBlue,
            elevation: 0,
            bottom: TabBar(
                indicatorColor: TTMColors.white,
                indicatorSize: TabBarIndicatorSize.label,
                controller: goodDetailTabController,
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
                    GoodDetailBaseInfoPage(
                      goodModel: widget.good,
                    ),
                    GoodDetailShipperInfoPage(
                      goodModel: widget.good,
                    ),
                    GoodDetailGoodInfoPage(
                      goodModel: widget.good,
                    ),
                  ],
                  controller: goodDetailTabController,
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
