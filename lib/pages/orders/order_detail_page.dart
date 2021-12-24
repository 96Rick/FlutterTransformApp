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
                // 配载单
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
                // 运单
                widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? buildReceiptInfo()
                    : Container(),
                widget.type == OrderDetailType.confirmationReceipt ||
                        widget.type == OrderDetailType.evaluate
                    ? Container(height: 20)
                    : Container(),
                // 行车轨迹
                buildCarLocationInfo(),

                // 评价信息
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
              "基本信息",
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
                      "货物种类：",
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
                      "运单号：",
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
                      "提货地址：",
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
                      "提货时间：",
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
                      "送货地址：",
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
                      "送货时间：",
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
                      "收货人：",
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
                      "联系方式：",
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
                      "备注：",
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
              "托运人信息",
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
                      "托运企业名称：",
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
                      "统一社会信用代码：",
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
                      "联系人：",
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
                      "联系人手机号：",
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
                  "营业执照：",
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
              "货品信息：",
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
          child: Text("暂无货品信息"),
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
                        "货品名称",
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
                        "货品数量",
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
                        "单位重量（吨）",
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
                        "单位体积（立方米）",
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
                        "产品类别",
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
              "运力信息：",
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
                      "总重量：",
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
                      "司机：",
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
                      "车牌：",
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
              "配载单",
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
            child: Text("暂无配载单数据", style: TTMTextStyle.thirdTitle),
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
              "回单",
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
            child: Text("暂无回单数据", style: TTMTextStyle.thirdTitle),
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
              "行车定位：",
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
                        "点击查看地图详情",
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
              "评价详情",
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
                                "${wayModel.orderCarrier.evaluation.demand} 分",
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
                                "${wayModel.orderCarrier.evaluation.loading} 分",
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
                                "${wayModel.orderCarrier.evaluation.goods} 分",
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
                        "综合评价：",
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
                        wayModel.orderCarrier.evaluation.remark ?? "暂无评价",
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
            "运单详情",
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
