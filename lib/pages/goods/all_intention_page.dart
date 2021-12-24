import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/goods/goods_detail/goods_detail_page.dart';
import 'package:ttm/pages/goods/intention_detail/intention_detail_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class AllIntentionPage extends StatefulWidget {
  AllIntentionPage({Key? key}) : super(key: key);

  @override
  _AllIntentionPageState createState() => _AllIntentionPageState();
}

class _AllIntentionPageState extends State<AllIntentionPage>
    with AutomaticKeepAliveClientMixin {
  late MainStatusModel model;
  int currentExpandedIndex = 0;

  final allIntentionPageKey = GlobalKey<ScaffoldState>();

  late EasyRefreshController easyRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    model.refreshAllIntention(context).whenComplete(() {
      model.isCurrentIntentionExpanded =
          model.currentIntentionsList.map((e) => false).toList();
    });
    easyRefreshController = EasyRefreshController();
  }

  Widget buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Wrap(
        spacing: 10,
        children: [
          model.intentionFilterDateEnd != "" &&
                  model.intentionFilterDateStart != ""
              ? InputChip(
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      goodFilterDate2(size: 12, color: TTMColors.white),
                      Container(
                        width: 5,
                      ),
                      const Text(
                        "发布起止时间: ",
                        style: TTMTextStyle.goodsFilterSelectedTips,
                      ),
                      Text(model.intentionFilterDateStart,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      const Text(" 至 ",
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      Text(model.intentionFilterDateEnd,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                    ],
                  ),
                  // disabledColor: Colors.white,
                  backgroundColor: TTMColors.mainBlue,

                  shape: const StadiumBorder(
                      side: BorderSide(width: 2, color: TTMColors.mainBlue)),
                  deleteIconColor: TTMColors.white,
                  onPressed: () {
                    model.choseIntentionFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshAllIntention(context);
                      }
                    });
                  },
                  onDeleted: () {
                    model.clearIntentionFilterDate();
                    model.refreshAllIntention(context);
                    model.notifyListeners();
                  },
                  selected: false,
                )
              : ActionChip(
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      goodFilterDate2(
                          size: 12, color: TTMColors.goodsFilterLabelColor),
                      Container(
                        width: 5,
                      ),
                      const Text(
                        "发布起止时间: ",
                        style: TTMTextStyle.goodsFilterTitle,
                      ),
                      const Text(
                        "请选择",
                        style: TTMTextStyle.goodsFilterUnselectedTips,
                      ),
                    ],
                  ),
                  // disabledColor: Colors.white,
                  backgroundColor: Colors.white,

                  shape: const StadiumBorder(
                      side: BorderSide(width: 2, color: TTMColors.mainBlue)),
                  onPressed: () {
                    print("pressed");
                    model.choseIntentionFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshAllIntention(context);
                      }
                    });
                  },
                ),
          ActionChip(
            label: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                goodFilterType(size: 12, color: TTMColors.white),
                Container(
                  width: 5,
                ),
                const Text(
                  "状态：",
                  style: TTMTextStyle.goodsFilterSelectedTips,
                ),
                model.intentionListFilterTypes.length == 8
                    ? const Text("全部",
                        style: TTMTextStyle.goodsFilterSelectedTips)
                    : const Text("多种",
                        style: TTMTextStyle.goodsFilterSelectedTips)
              ],
            ),
            // disabledColor: Colors.white,
            backgroundColor: TTMColors.mainBlue,

            shape: const StadiumBorder(
                side: BorderSide(width: 2, color: TTMColors.mainBlue)),
            onPressed: () async {
              await model.choseIntentionFilterType(context);
              model.refreshAllIntention(context);
            },
          ),
        ],
      ),
    );
  }

  List<ExpansionPanel> buildExpansionPanelListCell() {
    List<ExpansionPanel> list = [];
    for (var i = 0; i < model.currentIntentionsList.length; i++) {
      list.add(
        ExpansionPanel(
          headerBuilder: (context, isOpen) {
            return Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      const Text("意向编号: ",
                          style: TTMTextStyle.goodsCellTitleLabel),
                      Text(model.currentIntentionsList[i].code ?? "",
                          style: TTMTextStyle.goodsCellTitleText),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      const Text("价格: ",
                          style: TTMTextStyle.goodsCellTitleLabel),
                      Text("${model.currentIntentionsList[i].demand.price}元",
                          style: TTMTextStyle.goodsCellTitleMoneyText),
                    ],
                  ),
                ),
              ],
            );
          },
          body: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => IntentionDetailPage(
                            intentionModel: model.currentIntentionsList[i],
                          )));
            },
            child: Container(
                decoration: BoxDecoration(
                  color: TTMColors.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "企业名称（托运人）：",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          ),
                          Expanded(
                            child: Text(
                              "${model.currentIntentionsList[i].demand.shipper.companyName}",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsCellDetailText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "装货地址：",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          ),
                          Expanded(
                            child: Text(
                              "${model.currentIntentionsList[i].demand.pickupProvince.name}-${model.currentIntentionsList[i].demand.pickupCity.name}-${model.currentIntentionsList[i].demand.pickupArea.name}",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsCellDetailText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "卸货地址：",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          ),
                          Expanded(
                            child: Text(
                              "${model.currentIntentionsList[i].demand.receivingProvince.name}-${model.currentIntentionsList[i].demand.receivingCity.name}-${model.currentIntentionsList[i].demand.receivingArea.name}",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsCellDetailText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "运输方式: ",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          ),
                          Expanded(
                            child: Text(
                              model.currentIntentionsList[i].demand
                                      .transportMode.name ??
                                  "",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsCellDetailText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "状态: ",
                            style: TTMTextStyle.goodsCellDetailLabel,
                          ),
                          Expanded(
                            child: Text(
                              model.currentIntentionsList[i].status == "1"
                                  ? "发布"
                                  : model.currentIntentionsList[i].status == "2"
                                      ? "承运人待确认"
                                      : model.currentIntentionsList[i].status ==
                                              "3"
                                          ? "承运人已确认"
                                          : model.currentIntentionsList[i]
                                                      .status ==
                                                  "4"
                                              ? "承运人拒绝"
                                              : model.currentIntentionsList[i]
                                                          .status ==
                                                      "5"
                                                  ? "审核通过"
                                                  : model
                                                              .currentIntentionsList[
                                                                  i]
                                                              .status ==
                                                          "6"
                                                      ? "审核未通过"
                                                      : model
                                                                  .currentIntentionsList[
                                                                      i]
                                                                  .status ==
                                                              "7"
                                                          ? "托运人待确认"
                                                          : model
                                                                      .currentIntentionsList[
                                                                          i]
                                                                      .status ==
                                                                  "8"
                                                              ? "托运人拒绝"
                                                              : model.currentIntentionsList[i]
                                                                          .status ==
                                                                      "9"
                                                                  ? "托运人已确认"
                                                                  : "",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsCellDetailText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Center(
                          child:
                              goodDetail(size: 32, color: TTMColors.mainBlue)),
                      Container(
                        height: 5,
                      ),
                      const Center(
                          child: Text("点击查看详情",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: TTMColors.titleColor)))
                    ],
                  ),
                )),
          ),
          canTapOnHeader: true,
          isExpanded: model.isCurrentIntentionExpanded[i],
        ),
      );
    }
    return list;
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return Scaffold(
        key: allIntentionPageKey,
        backgroundColor: TTMColors.backgroundColor,
        body: ColorfulSafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 75.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFilters(),
                Expanded(
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
                      await model.refreshAllIntention(context);
                    },
                    emptyWidget: model.currentIntentionsList.isEmpty
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
                                  child:
                                      TTMImage.name(TTMImage.noDataPlaceholder),
                                ),
                                Container(
                                  height: 20,
                                ),
                                const Text(
                                  "暂无意向信息",
                                  textAlign: TextAlign.center,
                                  style: TTMTextStyle
                                      .joinFleetBodyPlaceholderTitle,
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
                      margin: const EdgeInsets.only(
                          top: 10, left: 20.0, right: 20.0, bottom: 20.0),
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
                      child: ExpansionPanelList(
                        animationDuration: const Duration(milliseconds: 300),
                        dividerColor: TTMColors.cellLineColor,
                        elevation: 0,
                        // expandedHeaderPadding: const EdgeInsets.only(left: 10),
                        children: buildExpansionPanelListCell(),
                        expansionCallback: (index, isOpen) => setState(() {
                          for (var i = 0;
                              i < model.isCurrentIntentionExpanded.length;
                              i++) {
                            if (index == i) {
                              model.isCurrentIntentionExpanded[i] = !isOpen;
                            } else {
                              model.isCurrentIntentionExpanded[i] = false;
                            }
                          }
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
