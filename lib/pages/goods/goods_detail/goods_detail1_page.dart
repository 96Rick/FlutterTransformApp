import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/status/main_status_model.dart';

class GoodDetailBaseInfoPage extends StatefulWidget {
  const GoodDetailBaseInfoPage({Key? key, required this.goodModel})
      : super(key: key);

  final GoodModel goodModel;

  @override
  _GoodDetailBaseInfoPageState createState() => _GoodDetailBaseInfoPageState();
}

class _GoodDetailBaseInfoPageState extends State<GoodDetailBaseInfoPage> {
  final goodDetail1PageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  late final GoodModel good = widget.goodModel;

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
                              "????????????",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text(
                                good.goodsType.name ?? "",
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
                              "????????????",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text(
                                good.transportMode.name ?? "",
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
                              "??????????????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${good.pickupProvince.name}-${good.pickupCity.name}-${good.pickupArea.name}-${good.pickupAddress}",
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
                              "??????????????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${good.receivingProvince.name}-${good.receivingCity.name}-${good.receivingArea.name}-${good.receiving_address}",
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
                              "??????????????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${good.pickupStart} ??? ${good.pickupEnd}",
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
                              "??????????????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "${good.receivingStart} ??? ${good.receivingEnd}",
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
                              "?????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.receivingName ?? "",
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
                              "??????????????????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.receivingTel ?? "",
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
                              "??????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                "?? ${good.price} ???",
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
                              "??????",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.remark ?? "????????????",
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
