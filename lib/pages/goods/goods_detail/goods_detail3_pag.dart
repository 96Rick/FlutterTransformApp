import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/status/main_status_model.dart';

class GoodDetailGoodInfoPage extends StatefulWidget {
  const GoodDetailGoodInfoPage({Key? key, required this.goodModel})
      : super(key: key);
  final GoodModel goodModel;
  @override
  _GoodDetailGoodInfoPageState createState() => _GoodDetailGoodInfoPageState();
}

class _GoodDetailGoodInfoPageState extends State<GoodDetailGoodInfoPage> {
  final goodDetail1PageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late final GoodModel good = widget.goodModel;

  // late double totalVolume = 0;
  // late double totalWeight = 0;
  // late double totalCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    // calculateTotalNumber();
  }

  // void calculateTotalNumber() {
  //   totalVolume = 0;
  //   totalWeight = 0;
  //   totalCount = 0;
  //   for (var item in good.goods) {
  //     if (item.count != null) {
  //       totalCount += item.count!;
  //     }
  //     if (item.weight != null) {
  //       totalWeight += item.weight!;
  //     }
  //     if (item.volume != null) {
  //       totalVolume += item.volume!;
  //     }
  //   }
  // }

  List<Widget> buildGoods() {
    List<Widget> goodList = [];
    for (var item in good.goods) {
      goodList.add(
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                        item.name ?? "",
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
                child: Container(height: 1, color: TTMColors.cellLineColor),
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
                        item.count.toString(),
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
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "?????????????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.weight.toString(),
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
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.volume.toString(),
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
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.classification.name.toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return goodList;
  }

  Widget buildTotalNumbers() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(top: 20, right: 40, left: 40, bottom: 10),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: Text("?????????")),
          Container(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: TTMColors.mainBlue, width: 3),
                borderRadius: BorderRadius.circular(50)),
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "??????????????????",
                    style: TTMTextStyle.goodsDetailPageLabel,
                  ),
                  Text(
                    widget.goodModel.totalWeight.toString(),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.end,
                    style: TTMTextStyle.goodsDetailPageImportTitle,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: TTMColors.mainBlue, width: 3),
                borderRadius: BorderRadius.circular(50)),
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "????????????????????????",
                    style: TTMTextStyle.goodsDetailPageLabel,
                  ),
                  Expanded(
                    child: Text(
                      widget.goodModel.totalVolume.toString(),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.end,
                      style: TTMTextStyle.goodsDetailPageImportTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: TTMColors.mainBlue, width: 3),
                borderRadius: BorderRadius.circular(50)),
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "?????????",
                    style: TTMTextStyle.thirdTitle,
                  ),
                  Expanded(
                    child: Text(
                      widget.goodModel.totalCount.toString(),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.end,
                      style: TTMTextStyle.goodsDetailPageImportTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          Container(child: Text("?????????????????????")),
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
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: buildGoods()),
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
            buildTotalNumbers(),
            buildBody(),
          ],
        ),
      );
    });
  }
}
