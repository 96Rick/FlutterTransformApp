import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/orders/upload_images_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/pages/orders/order_detail_page.dart';
import 'package:flutter/cupertino.dart';

class AllWaitingPickUpPage extends StatefulWidget {
  AllWaitingPickUpPage({Key? key}) : super(key: key);

  @override
  _AllWaitingPickUpPageState createState() => _AllWaitingPickUpPageState();
}

class _AllWaitingPickUpPageState extends State<AllWaitingPickUpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final allWaitingPickupPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late EasyRefreshController easyRefreshController;

  // 定位相关

  // late LocationData locationData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // LocationUtil().initLocationService();
    model = ScopedModel.of<MainStatusModel>(context);
    easyRefreshController = EasyRefreshController();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return Scaffold(
        key: allWaitingPickupPageKey,
        backgroundColor: TTMColors.backgroundColor,
        body: ColorfulSafeArea(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 75.0),
          child: EasyRefresh(
            controller: easyRefreshController,
            enableControlFinishRefresh: false,
            header: ClassicalHeader(
                refreshText: "继续下拉以刷新",
                refreshFailedText: "刷新失败",
                refreshReadyText: "释放刷新",
                refreshedText: "刷新成功",
                refreshingText: "刷新中...",
                bgColor: TTMColors.backgroundColor),
            onRefresh: () async {
              // await Future.delayed(const Duration(seconds: 1));
              // await model.refreshAllGoods(context);
              await model.refreshWayBillList(context);
            },
            emptyWidget: model.wayBillWaitingPickedUplist.isEmpty
                ? SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Expanded(
                          child: SizedBox(),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 245,
                          child: TTMImage.name(TTMImage.noDataPlaceholder),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          "暂无待提货信息",
                          textAlign: TextAlign.center,
                          style: TTMTextStyle.joinFleetBodyPlaceholderTitle,
                        ),
                        const Expanded(
                          child: SizedBox(),
                          flex: 3,
                        ),
                      ],
                    ),
                  )
                : null,
            child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: TTMColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 20.0,
                        spreadRadius: -5,
                      ),
                    ]),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.wayBillWaitingPickedUplist.length,
                    itemBuilder: (context, index) {
                      return buildAcceptOrderCell(index);
                    })),
          ),
        )),
      );
    });
  }

  Widget buildAcceptOrderCell(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => OrderDetailPage(
                        type: OrderDetailType.waitPickup,
                        wayBillModel: model.wayBillWaitingPickedUplist[index],
                      )));
        },
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 90,
                  margin: EdgeInsets.all(10),
                  width: TTMSize.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // shangmian row
                      //xiamianrow
                      Wrap(
                        children: [
                          Text(
                            "运单号： ",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model.wayBillWaitingPickedUplist[index].orderCarrier
                                    .code ??
                                "",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          UnconstrainedBox(
                            child: Row(
                              children: [
                                goodMoney2(size: 20),
                                Container(
                                  width: 5,
                                ),
                                Text(
                                  "费用： ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: TTMColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.price.toString()} 元",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "装货地址: ${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.pickupProvince.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.pickupCity.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.pickupArea.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.pickupAddress}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "卸货地址: ${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receivingProvince.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receivingCity.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receivingArea.name}-${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receiving_address}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "收货人:     ${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receivingName}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "联系方式: ${model.wayBillWaitingPickedUplist[index].orderCarrier.intention.demand.receivingTel}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  // locationData = await LocationUtil()
                                  //     .location
                                  //     .getLocation();
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              UploadMultipleImagePage(
                                                // locationData: Location(),
                                                wayBillModel: model
                                                        .wayBillWaitingPickedUplist[
                                                    index],
                                                orderType:
                                                    OrderDetailType.waitPickup,
                                                uploadType: UploadMutipleType
                                                    .loadingPage,
                                              )));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        color: TTMColors.mainBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      "上传配载单",
                                      style: TextStyle(
                                          color: TTMColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ))),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                index != (model.wayBillWaitingPickedUplist.length - 1)
                    ? Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: 1,
                        color: TTMColors.cellLineColor,
                      )
                    : Container(
                        height: 10,
                      )
              ],
            )));
  }
}
