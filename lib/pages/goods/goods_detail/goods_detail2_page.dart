import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class GoodDetailShipperInfoPage extends StatefulWidget {
  const GoodDetailShipperInfoPage({Key? key, required this.goodModel})
      : super(key: key);
  final GoodModel goodModel;
  @override
  _GoodDetailShipperInfoPageState createState() =>
      _GoodDetailShipperInfoPageState();
}

class _GoodDetailShipperInfoPageState extends State<GoodDetailShipperInfoPage> {
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
                const EdgeInsets.only(right: 20, left: 20, top: 0, bottom: 20),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Center(
                      child: Text(
                    "提示：如企业名称与营业证明文件不一致或与统一社会信用代码不匹配，将无法申请开具发票",
                    style: TextStyle(
                        fontSize: 12,
                        color: TTMColors.dangerColor,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  )),
                ),
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
                              "托运企业名称",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: good.shipper.companyName ?? "",
                                      style: TTMTextStyle
                                          .goodsDetailPageSecondTitle,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.fade,
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
                              "统一社会信用代码",
                              style: TTMTextStyle.goodsDetailPageLabel,
                            ),
                            Expanded(
                              child: Text(
                                good.shipper.companyCode ?? "",
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
                              "联系人",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.shipper.contactName ?? "",
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
                              "联系人手机号码",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.shipper.contactTel ?? "",
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
                              "联系人电话",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Expanded(
                              child: Text(
                                good.shipper.contactPhone ?? "",
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
                              "评分",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Row(
                              children: [
                                Text(good.shipper.score ?? "暂无评分",
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.amber)),
                                good.shipper.score != null
                                    ? const Icon(
                                        Icons.star,
                                        size: 22,
                                        color: Colors.amber,
                                      )
                                    : Container(),
                              ],
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
          )
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
