import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/status/main_status_model.dart';

enum CarAvailableStatus { underReview, avaliable, notPass }

enum CarLicenseColor { yellow, blue }

enum CarBelongType { fleet, personal }

class CarCardListCell extends StatefulWidget {
  const CarCardListCell(
      {Key? key, required this.currentIndex, required this.onEditCarTapd})
      : super(key: key);
  final int currentIndex;
  final Function(int) onEditCarTapd;

  @override
  State<CarCardListCell> createState() => _CarCardListCellState();
}

class _CarCardListCellState extends State<CarCardListCell> {
  late MainStatusModel model;
  late String? carCardNumber;
  late CarAvailableStatus carStatus = CarAvailableStatus.avaliable;
  late CarLicenseColor carLicenseColor = CarLicenseColor.blue;

  @override
  void initState() {
    model = ScopedModel.of(context);

    carCardNumber =
        model.profileCarCardList[widget.currentIndex].license_plate_number ??
            "";
    carStatus = model.profileCarCardList[widget.currentIndex].status == "1"
        ? CarAvailableStatus.underReview
        : model.profileCarCardList[widget.currentIndex].status == "2"
            ? CarAvailableStatus.avaliable
            : CarAvailableStatus.notPass;
    carLicenseColor =
        model.profileCarCardList[widget.currentIndex].license_color == 1
            ? CarLicenseColor.blue
            : CarLicenseColor.yellow;
    // TODO: implement initState
    super.initState();
  }

  void changeValue() {
    carCardNumber =
        model.profileCarCardList[widget.currentIndex].license_plate_number ??
            "";
    carStatus = model.profileCarCardList[widget.currentIndex].status == "1"
        ? CarAvailableStatus.underReview
        : model.profileCarCardList[widget.currentIndex].status == "2"
            ? CarAvailableStatus.avaliable
            : CarAvailableStatus.notPass;
    carLicenseColor =
        model.profileCarCardList[widget.currentIndex].license_color == 1
            ? CarLicenseColor.blue
            : CarLicenseColor.yellow;
  }

  @override
  Widget build(BuildContext context) {
    changeValue();
    return Container(
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: TTMColors.carCardBGBlueColor,
      ),
      child: Stack(
        children: [
          Positioned(
              top: 40,
              left: 10,
              bottom: 0,
              child: SizedBox(
                  height: 130,
                  width: 57,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 57,
                          height: 40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "车辆状态",
                              style: TextStyle(
                                  color: TTMColors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w200),
                            ),
                          )),
                      SizedBox(
                        width: 57,
                        height: 50,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "牌照颜色",
                                    style: TextStyle(
                                        color: TTMColors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w200),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    carLicenseColor == CarLicenseColor.blue
                                        ? "蓝色"
                                        : carLicenseColor ==
                                                CarLicenseColor.yellow
                                            ? "黄色"
                                            : "未知",
                                    style: TextStyle(
                                        color: TTMColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      SizedBox(
                        width: 57,
                        height: 50,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "车辆所属",
                                    style: TextStyle(
                                        color: TTMColors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w200),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "个人",
                                    style: TextStyle(
                                        color: TTMColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                    ],
                  )
                  // Container(
                  //   child: Center(
                  //     child: Text(
                  //       carCardNumber,
                  //       style: TextStyle(
                  //           color: TTMColors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 22),
                  //     ),
                  //   ),
                  // ),
                  )),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: carLicenseColor == CarLicenseColor.blue
                        ? TTMColors.carCardLicenseBlueColor
                        : TTMColors.carCardLicenseYellowColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 4),
                          blurRadius: 10.0,
                          spreadRadius: -5)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      carCardNumber ?? "未知",
                      style: TextStyle(
                          color: carLicenseColor == CarLicenseColor.blue
                              ? TTMColors.white
                              : TTMColors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: 10,
            right: 10,
            child: TextButton(
              onPressed: () {
                widget.onEditCarTapd(widget.currentIndex);
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: TTMColors.carCardEditBtnColor,
                  ),
                  child: Center(
                      child: Text(
                    "编辑\n车辆",
                    style: TextStyle(
                        color: TTMColors.white, fontWeight: FontWeight.w200),
                  )),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 40,
            left: 0,
            child: Container(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      carStatus == CarAvailableStatus.avaliable
                          ? "已审核"
                          : carStatus == CarAvailableStatus.underReview
                              ? "审核中"
                              : carStatus == CarAvailableStatus.notPass
                                  ? "已拒绝"
                                  : " 未知",
                      style: TextStyle(
                          color: TTMColors.white, fontWeight: FontWeight.w200),
                    ),
                    Container(
                      width: 5,
                    ),
                    ClipOval(
                      child: Container(
                        width: 10,
                        height: 10,
                        color: carStatus == CarAvailableStatus.avaliable
                            ? Colors.green
                            : carStatus == CarAvailableStatus.underReview
                                ? Colors.yellow
                                : carStatus == CarAvailableStatus.notPass
                                    ? Colors.red
                                    : Colors.grey,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
