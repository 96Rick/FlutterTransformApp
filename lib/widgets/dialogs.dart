import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/goods_models/good_bid_car_model.dart';
import 'package:ttm/widgets/flush_bar.dart';

double btnHeight = 60;
double borderWidth = 2;

class ReasonsDialog extends AlertDialog {
  ReasonsDialog({Key? key, required Widget contentWidget})
      : super(
          key: key,
          content: contentWidget,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
}

// ignore: must_be_immutable
class ReasonDialog extends StatefulWidget {
  String? title;
  String? cancelBtnTitle;
  String? okBtnTitle;
  VoidCallback cancelBtnTap;
  VoidCallback okBtnTap;
  TextEditingController vc;
  ReasonDialog(
      {Key? key,
      @required this.title,
      this.cancelBtnTitle = "取消",
      this.okBtnTitle = "拒绝",
      required this.cancelBtnTap,
      required this.okBtnTap,
      required this.vc})
      : super(key: key);

  @override
  _ReasonDialogState createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: 200,
        width: 10000,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                      color: TTMColors.titleColor, fontWeight: FontWeight.bold),
                )),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                cursorColor: TTMColors.secondTitleColor,
                style: TextStyle(color: TTMColors.titleColor),
                controller: widget.vc,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TTMColors.cellLineColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TTMColors.cellLineColor),
                    )),
              ),
            ),
            Container(
              // color: Colors.red,
              height: btnHeight,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [
                  Container(
                    // 按钮上面的横线
                    width: double.infinity,
                    color: TTMColors.cellLineColor,
                    height: borderWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          widget.vc.text = "";
                          widget.cancelBtnTap();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.cancelBtnTitle ?? "",
                          style: TextStyle(
                              fontSize: 18, color: TTMColors.secondTitleColor),
                        ),
                      ),
                      Container(
                        // 按钮中间的竖线
                        width: borderWidth,
                        color: TTMColors.cellLineColor,
                        height: btnHeight - borderWidth - borderWidth,
                      ),
                      TextButton(
                          onPressed: () {
                            if (widget.vc.text == "" ||
                                widget.vc.text == null) {
                              FlushBarWidget.createDanger("请输入拒绝原因", context);
                            } else {
                              widget.okBtnTap();
                              widget.vc.text = "";
                            }
                          },
                          child: Text(
                            widget.okBtnTitle ?? "",
                            style: TextStyle(
                                fontSize: 18, color: TTMColors.dangerColor),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CarListDialog extends AlertDialog {
  CarListDialog({Key? key, required Widget contentWidget})
      : super(
          key: key,
          content: contentWidget,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
}

// ignore: must_be_immutable
class CarListsDialog extends StatefulWidget {
  String? title;
  String? cancelBtnTitle;
  String? okBtnTitle;
  double goodTotalWidget;
  List<GoodBidCar> carList;
  VoidCallback cancelBtnTap;
  Function(String) okBtnTap;
  CarListsDialog({
    Key? key,
    @required this.title,
    this.cancelBtnTitle = "取消",
    this.okBtnTitle = "拒绝",
    required this.goodTotalWidget,
    required this.carList,
    required this.cancelBtnTap,
    required this.okBtnTap,
  }) : super(key: key);

  @override
  _CarListsDialogState createState() => _CarListsDialogState();
}

class _CarListsDialogState extends State<CarListsDialog> {
  late String chosenCarID = "";
  late String chosenCarLoad = "";

  Widget buildCarListCell(GoodBidCar carModel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          chosenCarID = carModel.id ?? "";
          chosenCarLoad = carModel.load?.name ?? "";
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: TTMColors.white, borderRadius: BorderRadius.circular(10)),
        height: 60,
        width: 10000,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                children: [
                  const Text(
                    "车牌号: ",
                    style: TTMTextStyle.goodsFilterTitle,
                  ),
                  Container(
                    width: 5,
                  ),
                  Text(
                    carModel.licensePlateNumber ?? "暂无车牌号信息",
                    style: const TextStyle(
                        fontSize: 16,
                        color: TTMColors.mainBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Row(
                children: [
                  Text(
                    "载重: ",
                    style: TTMTextStyle.goodsFilterTitle,
                  ),
                  Container(
                    width: 5,
                  ),
                  Text(
                    carModel.load?.name ?? "暂无载重信息",
                    style: const TextStyle(
                        fontSize: 16,
                        color: TTMColors.titleColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 10,
                  ),
                  chosenCarID == carModel.id
                      ? Icon(Icons.done, color: Colors.green)
                      : Icon(CupertinoIcons.add)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: TTMSize.screenHeight - TTMSize.statusBarHeight - 250,
        width: 10000,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                      fontSize: 20,
                      color: TTMColors.titleColor,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              height: 5,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "当前货物总重量：${widget.goodTotalWidget}T",
                  style: TextStyle(
                      fontSize: 14,
                      color: TTMColors.titleColor,
                      fontWeight: FontWeight.normal),
                )),
            // const Spacer(),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(color: TTMColors.backgroundColor),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.carList.length,
                        itemBuilder: (context, index) {
                          return buildCarListCell(widget.carList[index]);
                        }),
                  )),
            ),
            Container(
              // color: Colors.red,
              height: btnHeight,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Container(
                    // 按钮上面的横线
                    width: double.infinity,
                    color: TTMColors.cellLineColor,
                    height: borderWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          widget.cancelBtnTap();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.cancelBtnTitle ?? "",
                          style: TextStyle(
                              fontSize: 18, color: TTMColors.secondTitleColor),
                        ),
                      ),
                      Container(
                        // 按钮中间的竖线
                        width: borderWidth,
                        color: TTMColors.cellLineColor,
                        height: btnHeight - borderWidth - borderWidth,
                      ),
                      TextButton(
                          onPressed: () {
                            if (chosenCarID == "" || chosenCarID == null) {
                              FlushBarWidget.createDanger("请先选中承运车辆", context);
                              return;
                            }
                            if (chosenCarLoad != null) {
                              if (chosenCarLoad.contains("t")) {
                                var load = double.parse(
                                    chosenCarLoad.replaceAll("t", ""));
                                if (load is double) {
                                  if (load > widget.goodTotalWidget) {
                                    widget.okBtnTap(chosenCarID);
                                  } else {
                                    FlushBarWidget.createDanger(
                                        "选中车辆载重小于货源总重量，无法抢单", context);
                                    return;
                                  }
                                } else {
                                  FlushBarWidget.createDanger(
                                      "读取选中车辆载重失败", context);
                                  return;
                                }
                              }
                            }
                          },
                          child: Text(
                            widget.okBtnTitle ?? "",
                            style: TextStyle(
                                fontSize: 18, color: TTMColors.mainBlue),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class StartRatingDialog extends AlertDialog {
  StartRatingDialog({Key? key, required Widget contentWidget})
      : super(
          key: key,
          content: contentWidget,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
}

// ignore: must_be_immutable
class RatingDialog extends StatefulWidget {
  String? title;
  String? cancelBtnTitle;
  String? okBtnTitle;
  VoidCallback cancelBtnTap;
  Function(
    double goods,
    double demand,
    double loading,
    String remark,
  ) okBtnTap;
  RatingDialog({
    Key? key,
    @required this.title,
    this.cancelBtnTitle = "取消",
    this.okBtnTitle = "确定",
    required this.cancelBtnTap,
    required this.okBtnTap,
  }) : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double goodsRating = 5;
  double demandRating = 5;
  double loadingRating = 5;
  String remark = "";

  FocusNode remarkTextFiledFocusNode = FocusNode();

  void stowkeyBoard() {
    remarkTextFiledFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stowkeyBoard();
      },
      child: Container(
          height: 450,
          color: Colors.transparent,
          width: 10000,
          alignment: Alignment.bottomCenter,
          child: Stack(children: [
            Positioned(
              top: 10,
              right: 0,
              left: 0,
              height: 35,
              child: Container(
                  alignment: Alignment.center,
                  child: UnconstrainedBox(
                    child: Row(
                      children: [
                        Text(
                          widget.title ?? "",
                          style: const TextStyle(
                              color: TTMColors.titleColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 10,
                        ),
                        waybillEvaluate(size: 20)
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: 60,
              bottom: 60,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 7),
                              child: const Text(
                                "货源真实：",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: TTMColors.secondTitleColor),
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar.builder(
                                  itemSize: 28,
                                  initialRating: 5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  updateOnDrag: true,
                                  glow: false,
                                  unratedColor: TTMColors.cellLineColor,
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      demandRating = rating;
                                    });
                                  },
                                ),
                                Container(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text("${demandRating} 分",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: demandRating == 5
                                              ? TTMColors.gold
                                              : TTMColors.secondTitleColor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 7),
                              child: const Text(
                                "装卸准时：",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: TTMColors.secondTitleColor),
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar.builder(
                                  itemSize: 28,
                                  initialRating: 5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  updateOnDrag: true,
                                  glow: false,
                                  unratedColor: TTMColors.cellLineColor,
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      loadingRating = rating;
                                    });
                                  },
                                ),
                                Container(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text("${loadingRating} 分",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: loadingRating == 5
                                              ? TTMColors.gold
                                              : TTMColors.secondTitleColor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Wrap(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 7),
                            child: const Text(
                              "货物无异常：",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: TTMColors.secondTitleColor),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                itemSize: 28,
                                initialRating: 5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                updateOnDrag: true,
                                glow: false,
                                unratedColor: TTMColors.cellLineColor,
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    goodsRating = rating;
                                  });
                                },
                              ),
                              Container(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Text("${goodsRating} 分",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: goodsRating == 5
                                            ? TTMColors.gold
                                            : TTMColors.secondTitleColor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      // color: Colors.red,
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("综合评价：",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: TTMColors.secondTitleColor)),
                          Center(
                            child: TextField(
                              cursorColor: TTMColors.secondTitleColor,
                              focusNode: remarkTextFiledFocusNode,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: TTMColors.titleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "请输入...",
                                  hintStyle: TTMTextStyle.textFieldHint,
                                  contentPadding: EdgeInsets.only(right: 10),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: TTMColors.cellLineColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: TTMColors.mainBlue),
                                  )),
                              onSubmitted: (v) {
                                print(v);
                                remark = v;
                              },
                              onChanged: (v) {
                                print(v);
                                remark = v;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: btnHeight,
              child: Column(
                children: [
                  Container(
                    // 按钮上面的横线
                    width: double.infinity,
                    color: TTMColors.cellLineColor,
                    height: borderWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (TTMSize.screenWidth - 80) / 2 - borderWidth,
                        height: btnHeight - borderWidth - borderWidth,
                        child: TextButton(
                          onPressed: () {
                            widget.cancelBtnTap();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            widget.cancelBtnTitle ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                color: TTMColors.secondTitleColor),
                          ),
                        ),
                      ),
                      Container(
                        // 按钮中间的竖线
                        width: borderWidth,
                        color: TTMColors.cellLineColor,
                        height: btnHeight - borderWidth - borderWidth,
                      ),
                      Container(
                        width: (TTMSize.screenWidth - 80) / 2 - borderWidth,
                        height: btnHeight - borderWidth - borderWidth,
                        child: TextButton(
                            onPressed: () {
                              widget.okBtnTap(goodsRating, demandRating,
                                  loadingRating, remark);
                            },
                            child: Text(
                              widget.okBtnTitle ?? "",
                              style: const TextStyle(
                                  fontSize: 18, color: TTMColors.mainBlue),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
