import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/mine/all_cars/add_car_setup1_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

enum CarListBodyType { noCar, hasCar }

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final carListPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late CarListBodyType bodyType = CarListBodyType.noCar;

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    model.getUserBaseInfo(context);
    model.getAllCarInfoList(context);
    bodyType = model.allCarsInfoList.isEmpty
        ? CarListBodyType.noCar
        : CarListBodyType.hasCar;
    super.initState();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: "全部车辆",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildBody() {
    bodyType = model.allCarsInfoList.isEmpty
        ? CarListBodyType.noCar
        : CarListBodyType.hasCar;
    switch (bodyType) {
      case CarListBodyType.noCar:
        return Expanded(
          child: ListView(
            // shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    right: 60, left: 60, top: 5, bottom: 5),
                margin: const EdgeInsets.all(40),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      width: 245,
                      child: TTMImage.name(TTMImage.noDataPlaceholder),
                    ),
                    Container(
                      height: 20,
                    ),
                    const Text(
                      "暂无车辆信息",
                      textAlign: TextAlign.center,
                      style: TTMTextStyle.joinFleetBodyPlaceholderTitle,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case CarListBodyType.hasCar:
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.allCarsInfoList.length,
              itemBuilder: (context, index) {
                return buildCarListCell(index);
              }),
        );
    }
  }

  Widget buildCarListCell(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
      decoration: BoxDecoration(
          color: TTMColors.mainBlue,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 20.0,
              spreadRadius: -5,
            ),
          ]),
      child: GestureDetector(
        onTap: () {
          // edit car
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => AddCarSetupFirstPage(
                        carInfoModel: model.allCarsInfoList[index],
                      )));
        },
        child: Column(
          children: [
            // info top
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: TTMColors.allCarListSecondBGColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 20.0,
                      spreadRadius: -5,
                    ),
                  ]),
              child: Column(
                children: [
                  // car number status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.allCarsInfoList[index].license_plate_number ??
                            "未知车牌",
                        style: TTMTextStyle.allCarListCarNumberTitle,
                      ),
                      Row(
                        children: [
                          Text(
                            model.allCarsInfoList[index].status == "1"
                                ? "审核中"
                                : model.allCarsInfoList[index].status == "2"
                                    ? "已通过"
                                    : "已拒绝",
                            style: TTMTextStyle.allCarListCarStatusTitle,
                          ),
                          Container(
                            width: 10,
                          ),
                          ClipOval(
                            child: Container(
                                width: 15,
                                height: 15,
                                color: model.allCarsInfoList[index].status ==
                                        "1"
                                    ? Colors.yellow
                                    : model.allCarsInfoList[index].status == "2"
                                        ? Colors.green
                                        : Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(height: 10),
                  // 牌照颜色
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 牌照颜色
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: model.allCarsInfoList[index].license_color == 1
                              ? TTMColors.carCardLicenseBlueColor
                              : TTMColors.carCardLicenseYellowColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Text(
                          model.allCarsInfoList[index].license_color == 1
                              ? "蓝牌"
                              : "黄牌",
                          style: TTMTextStyle.allCarLiceseTypeTitle,
                        ),
                      ),

                      //右按钮
                      commonEnter1(size: 25, color: TTMColors.mainBlue)
                    ],
                  )
                ],
              ),
            ),

            // info Bottom
            Container(
              // margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "车辆所属",
                        style: TTMTextStyle.allCarBelongToTitle,
                      ),
                      Container(
                        width: 10,
                      ),
                      Container(
                        width: TTMSize.screenWidth - 210,
                        height: 20,
                        child: Text(
                          model.allCarsInfoList[index].owner_driver != null
                              ? "个人"
                              : model.allCarsInfoList[index].owner_company ??
                                  "未知车队",
                          style: TTMTextStyle.allCarBelongToValue,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // 解绑车辆
                      model
                          .unboundCar(model.allCarsInfoList[index])
                          .then((isSuccess) {
                        if (isSuccess) {
                          FlushBarWidget.createDone("解绑成功", context);
                          model.getAllCarInfoList(context);
                        } else {
                          FlushBarWidget.createDanger("解绑失败", context);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: const BoxDecoration(
                        color: TTMColors.dangerColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        "解绑车辆",
                        style: TTMTextStyle.allCarLiceseTypeTitle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAddBtn() {
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
            // add Car
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddCarSetupFirstPage()));
          },
          child: Container(
            height: 50,
            width: TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
            decoration: const BoxDecoration(
              color: TTMColors.myInfoSaveBtnColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
                child: const Text(
              "添加车辆",
              style: TTMTextStyle.bottomBtnTitle,
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
          key: carListPageKey,
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
                buildAddBtn(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
