import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/status/main_status_model.dart';

class IntentionDetailBaseInfoPage extends StatefulWidget {
  IntentionDetailBaseInfoPage({Key? key, required this.intentionModel})
      : super(key: key);

  final IntentionModel intentionModel;

  @override
  _IntentionDetailBaseInfoPageState createState() =>
      _IntentionDetailBaseInfoPageState();
}

class _IntentionDetailBaseInfoPageState
    extends State<IntentionDetailBaseInfoPage> {
  final goodDetail1PageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  late final IntentionModel intention = widget.intentionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 30),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: TTMSize.screenWidth - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: TTMColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 20.0,
                        spreadRadius: -5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "货物种类",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text(
                                intention.demand.goodsType.name ?? "",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageImportTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "运输方式",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text(
                                intention.demand.transportMode.name ?? "",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "提货详细地址",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${intention.demand.pickupProvince.name}-${intention.demand.pickupCity.name}-${intention.demand.pickupArea.name}-${intention.demand.pickupAddress}",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "送货详细地址",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${intention.demand.receivingProvince.name}-${intention.demand.receivingCity.name}-${intention.demand.receivingArea.name}-${intention.demand.receivingAddress}",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "提货起止日期",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${intention.demand.pickupStart} 至 ${intention.demand.pickupEnd}",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "送货起止日期",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${intention.demand.receivingStart} 至 ${intention.demand.receivingEnd}",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "收货人",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                intention.demand.receivingName ?? "",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "收货人手机号",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                intention.demand.receivingTel ?? "",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "费用",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "¥ ${intention.demand.price} 元",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageMoney,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "备注",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                intention.demand.remark ?? "暂无信息",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TTMTextStyle.goodsDetailPageSecondTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                            height: 1, color: TTMColors.cellLineColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return Scaffold(
        backgroundColor: TTMColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildBody(),
          ],
        ),
      );
    });
  }
}
