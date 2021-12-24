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
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

enum PageType { goods, intention }

class AllGoodsPage extends StatefulWidget {
  AllGoodsPage({
    Key? key,
  }) : super(key: key);

  @override
  _AllGoodsPageState createState() => _AllGoodsPageState();
}

class _AllGoodsPageState extends State<AllGoodsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late MainStatusModel model;
  int currentExpandedIndex = 0;

  final allGoodsPageKey = GlobalKey<ScaffoldState>();

  late ScrollController pageScrollController;
  late EasyRefreshController easyRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    model.refreshAllGoods(context).whenComplete(() {
      model.isCurrentGoodsExpanded =
          model.currentGoodsList.map((e) => false).toList();
    });
    model.getMyDetaillInfo(context);
    pageScrollController = ScrollController();
    easyRefreshController = EasyRefreshController();
  }

  Widget buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Wrap(
        spacing: 10,
        children: [
          model.goodsFilterDateEnd != "" && model.goodsFilterDateStart != ""
              ? InputChip(
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      goodFilterDate2(size: 12, color: TTMColors.white),
                      Container(
                        width: 7,
                      ),
                      const Text(
                        "发布起止时间: ",
                        style: TTMTextStyle.goodsFilterSelectedTips,
                      ),
                      Text(model.goodsFilterDateStart,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      const Text(" 至 ",
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      Text(model.goodsFilterDateEnd,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                    ],
                  ),
                  // disabledColor: Colors.white,
                  backgroundColor: TTMColors.mainBlue,

                  shape: const StadiumBorder(
                      side: BorderSide(width: 2, color: TTMColors.mainBlue)),
                  deleteIconColor: TTMColors.white,
                  onPressed: () {
                    model.choseGoodsFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshAllGoods(context);
                      }
                    });
                  },
                  onDeleted: () {
                    model.clearGoodsFilterDate();
                    model.refreshAllGoods(context);
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
                    model.choseGoodsFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshAllGoods(context);
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
                model.goodsListFilterTypes.length == 4
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
              await model.choseGoodsFilterType(context);
              model.refreshAllGoods(context);
            },
          ),
        ],
      ),
    );
  }

  List<ExpansionPanel> buildExpansionPanelListCell() {
    List<ExpansionPanel> list = [];
    for (var i = 0; i < model.currentGoodsList.length; i++) {
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
                      const Text("需求编号: ",
                          style: TTMTextStyle.goodsCellTitleLabel),
                      Text(model.currentGoodsList[i].code ?? "",
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
                      Text("${model.currentGoodsList[i].price}元",
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
                      builder: (context) => GoodDetailPage(
                            good: model.currentGoodsList[i],
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
                              "${model.currentGoodsList[i].shipper.companyName}",
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
                              "${model.currentGoodsList[i].pickupProvince.name}-${model.currentGoodsList[i].pickupCity.name}-${model.currentGoodsList[i].pickupArea.name}",
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
                              "${model.currentGoodsList[i].receivingProvince.name}-${model.currentGoodsList[i].receivingCity.name}-${model.currentGoodsList[i].receivingArea.name}",
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
                              model.currentGoodsList[i].transportMode.name ??
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
                              model.currentGoodsList[i].status == "1"
                                  ? "发布"
                                  : model.currentGoodsList[i].status == "2"
                                      ? "承运人待确认"
                                      : model.currentGoodsList[i].status == "3"
                                          ? "承运人已确认"
                                          : model.currentGoodsList[i].status ==
                                                  "4"
                                              ? "承运人拒绝"
                                              : model.currentGoodsList[i]
                                                          .status ==
                                                      "5"
                                                  ? "审核通过"
                                                  : model.currentGoodsList[i]
                                                              .status ==
                                                          "6"
                                                      ? "审核未通过"
                                                      : model
                                                                  .currentGoodsList[
                                                                      i]
                                                                  .status ==
                                                              "7"
                                                          ? "托运人待确认"
                                                          : model
                                                                      .currentGoodsList[
                                                                          i]
                                                                      .status ==
                                                                  "8"
                                                              ? "托运人拒绝"
                                                              : model.currentGoodsList[i]
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
          isExpanded: model.isCurrentGoodsExpanded[i],
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
        key: allGoodsPageKey,
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
                      await model.refreshAllGoods(context);
                    },
                    emptyWidget: model.currentGoodsList.isEmpty
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
                                  "暂无货源信息",
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
                              i < model.isCurrentGoodsExpanded.length;
                              i++) {
                            if (index == i) {
                              model.isCurrentGoodsExpanded[i] = !isOpen;
                            } else {
                              model.isCurrentGoodsExpanded[i] = false;
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
