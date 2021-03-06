import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';
import 'package:ttm/pages/orders/gd_map_page.dart';

enum OrderDetailType {
  waitAccept,
  waitPickup,
  waitService,
  confirmationReceipt,
  evaluate,
}

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage(
      {Key? key, required this.wayBillModel, required this.type})
      : super(key: key);

  final OrderDetailType type;
  final WayBillModel wayBillModel;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final orderDetailPageKey = GlobalKey<ScaffoldState>();

  late final WayBillModel wayModel;

  @override
  void initState() {
    super.initState();
    wayModel = widget.wayBillModel;
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildBasicInfo(),
                Container(height: 20),
                buildShipperInfo(),
                Container(height: 20),
                buildGoodsInfo(),
                Container(height: 20),
                buildCarrierInfo(),
                Container(height: 20),
                // ?????????
                widget.type == OrderDetailType.waitService ||
                        widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? buildStowageListInfo()
                    : Container(),
                widget.type == OrderDetailType.waitService ||
                        widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? Container(height: 20)
                    : Container(),
                // ??????
                widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? buildReceiptInfo()
                    : Container(),
                widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? Container(height: 20)
                    : Container(),
                // ????????????
                buildCarLocationInfo(),

                // ????????????
                widget.type == OrderDetailType.evaluate
                    ? Container(height: 20)
                    : Container(),
                widget.type == OrderDetailType.evaluate
                    ? wayModel.orderCarrier.status == "10"
                        ? buildEvaluateInfo()
                        : Container()
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        wayModel.orderCarrier.intention.demand.goodsType.name ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageImportTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
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
                        wayModel.orderCarrier.code ?? "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${wayModel.orderCarrier.intention.demand.pickupProvince.name}-${wayModel.orderCarrier.intention.demand.pickupCity.name}-${wayModel.orderCarrier.intention.demand.pickupArea.name}-${wayModel.orderCarrier.intention.demand.pickupAddress}",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${wayModel.orderCarrier.intention.demand.pickupStart} - ${wayModel.orderCarrier.intention.demand.pickupEnd}",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${wayModel.orderCarrier.intention.demand.receivingProvince.name}-${wayModel.orderCarrier.intention.demand.receivingCity.name}-${wayModel.orderCarrier.intention.demand.receivingArea.name}-${wayModel.orderCarrier.intention.demand.receiving_address}",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${wayModel.orderCarrier.intention.demand.receivingStart} - ${wayModel.orderCarrier.intention.demand.receivingEnd}",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
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
                        wayModel.orderCarrier.intention.demand.receivingName ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "???????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        wayModel.orderCarrier.intention.demand.receivingTel ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    const Text(
                      "?????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      wayModel.orderCarrier.intention.demand.remark ?? "",
                      style: TTMTextStyle.goodsDetailPageSecondTitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildShipperInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "???????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "?????????????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        wayModel.orderCarrier.intention.demand.shipper
                                .companyName ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
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
                        wayModel.orderCarrier.intention.demand.shipper
                                .companyCode ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
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
                        wayModel.orderCarrier.intention.demand.shipper
                                .contactName ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
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
                        wayModel.orderCarrier.intention.demand.shipper
                                .contactTel ??
                            "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(
                  "???????????????",
                  style: TTMTextStyle.thirdTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: TTMColors.myInfoUploadImgBGColor,
                  ),
                  height: 186,
                  width: TTMSize.screenWidth - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                        TTMConstants.imageAssetsUrl +
                            wayModel.orderCarrier.intention.demand.shipper
                                .attached.busLicensePic!,
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGoodsInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "???????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
          child: Container(
              padding: EdgeInsets.all(20),
              height: 320,
              decoration: BoxDecoration(
                  color: TTMColors.cellLineColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                children: buildGoods(),
              )),
        ),
      ],
    );
  }

  List<Widget> buildGoods() {
    if (wayModel.orderCarrier.intention.demand.goods.isEmpty) {
      return [
        Container(
          child: Text("??????????????????"),
        )
      ];
    } else {
      List<Widget> goodList = [];
      for (var item in wayModel.orderCarrier.intention.demand.goods) {
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
                          item!.name ?? "",
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
  }

  Widget buildCarrierInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "???????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "????????????",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        wayModel.orderCarrier.intention.demand.totalWeight
                            .toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
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
                        wayModel.driver.name ?? "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
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
                        wayModel.transportation.licensePlateNumber ?? "",
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
      ],
    );
  }

  Widget buildStowageListInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "?????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Column(
              children: buildStowageListInfoImages(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildStowageListInfoImages() {
    List<Widget> images = [];
    if (wayModel.attached.loading.isNotEmpty) {
      for (var item in wayModel.attached.loading) {
        images.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TTMColors.myInfoUploadImgBGColor,
              ),
              height: 186,
              width: TTMSize.screenWidth - 80,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(TTMConstants.imageAssetsUrl + item!,
                    fit: BoxFit.contain),
              ),
            ),
          ),
        );
      }
    } else {
      images.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TTMColors.myInfoUploadImgBGColor,
          ),
          height: 186,
          child: Center(
            child: Text("?????????????????????", style: TTMTextStyle.thirdTitle),
          )));
    }
    return images;
  }

  Widget buildReceiptInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "??????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
            children: buildReceiptInfoImages(),
          ),
        ),
      ],
    );
  }

  List<Widget> buildReceiptInfoImages() {
    List<Widget> images = [];
    if (wayModel.attached.receipt.isNotEmpty) {
      for (var item in wayModel.attached.receipt) {
        images.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TTMColors.myInfoUploadImgBGColor,
              ),
              height: 186,
              width: TTMSize.screenWidth - 80,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(TTMConstants.imageAssetsUrl + item!,
                    fit: BoxFit.contain),
              ),
            ),
          ),
        );
      }
    } else {
      images.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TTMColors.myInfoUploadImgBGColor,
          ),
          height: 186,
          child: Center(
            child: Text("??????????????????", style: TTMTextStyle.thirdTitle),
          )));
    }
    return images;
  }

  Widget buildCarLocationInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "???????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => GDMapPage(
                          fakePosition: TTMConstants.fakePosition,
                        )));
          },
          child: Container(
              padding: EdgeInsets.all(15),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      waybillLujing2(),
                      Container(
                        width: 20,
                      ),
                      const Text(
                        "????????????????????????",
                        style: TextStyle(
                          color: TTMColors.titleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  commonEnter1(size: 20)
                ],
              )),
        ),
      ],
    );
  }

  Widget buildEvaluateInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "????????????",
              style: TTMTextStyle.secondTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
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
          child: Container(
            // height: 300,
            color: Colors.transparent,
            width: 10000,
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: const Text(
                          "???????????????",
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
                          RatingBarIndicator(
                            itemSize: 28,
                            rating: double.parse(
                                    wayModel.orderCarrier.evaluation.demand ??
                                        "0.0") is double
                                ? double.parse(
                                    wayModel.orderCarrier.evaluation.demand ??
                                        "0.0")
                                : 0.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                                "${wayModel.orderCarrier.evaluation.demand} ???",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: wayModel.orderCarrier.evaluation
                                                .demand ==
                                            "5.0"
                                        ? TTMColors.gold
                                        : TTMColors.secondTitleColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: const Text(
                          "???????????????",
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
                          RatingBarIndicator(
                            itemSize: 28,
                            rating: double.parse(
                                    wayModel.orderCarrier.evaluation.loading ??
                                        "0.0") is double
                                ? double.parse(
                                    wayModel.orderCarrier.evaluation.loading ??
                                        "0.0")
                                : 0.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                                "${wayModel.orderCarrier.evaluation.loading} ???",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: wayModel.orderCarrier.evaluation
                                                .loading ==
                                            "5.0"
                                        ? TTMColors.gold
                                        : TTMColors.secondTitleColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: const Text(
                          "??????????????????",
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
                          RatingBarIndicator(
                            itemSize: 28,
                            rating: double.parse(
                                    wayModel.orderCarrier.evaluation.goods ??
                                        "0.0") is double
                                ? double.parse(
                                    wayModel.orderCarrier.evaluation.goods ??
                                        "0.0")
                                : 0.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                                "${wayModel.orderCarrier.evaluation.goods} ???",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: wayModel.orderCarrier.evaluation
                                                .goods ==
                                            "5.0"
                                        ? TTMColors.gold
                                        : TTMColors.secondTitleColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.red,
                  width: 1000,
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "???????????????",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: TTMColors.secondTitleColor,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        wayModel.orderCarrier.evaluation.remark ?? "????????????",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: TTMColors.secondTitleColor,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        key: orderDetailPageKey,
        backgroundColor: TTMColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 100,
          title: const Text(
            "????????????",
            // style: TTMTextStyle.whiteAppBarTitle,
          ),
          centerTitle: true,
          backgroundColor: TTMColors.mainBlue,
          elevation: 0,
        ),
        body: ColorfulSafeArea(
          topColor: TTMColors.mainBlue,
          bottomColor: TTMColors.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}
