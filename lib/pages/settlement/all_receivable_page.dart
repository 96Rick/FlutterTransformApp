import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/settlement/settlement_detail_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/utils/date_util.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class AllReceivablePage extends StatefulWidget {
  const AllReceivablePage({Key? key}) : super(key: key);

  @override
  _AllReceivablePageState createState() => _AllReceivablePageState();
}

class _AllReceivablePageState extends State<AllReceivablePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final allReceivablePageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late EasyRefreshController easyRefreshController;
  FocusNode receivableInputFocusNode = FocusNode();
  late TextEditingController receivableTextEditingController;

  void stowkeyBoard() {
    receivableInputFocusNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    easyRefreshController = EasyRefreshController();
    receivableTextEditingController =
        TextEditingController(text: model.receivableActualCode);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        key: allReceivablePageKey,
        backgroundColor: TTMColors.backgroundColor,
        body: ColorfulSafeArea(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 75.0),
          child: GestureDetector(
            onTap: stowkeyBoard,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchBar(),
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
                        // await model.refreshAllGoods(context);
                        // await model.refreshWayBillList(context);
                        await model.refreshReceivableList(context);
                      },
                      emptyWidget: model.settlementReceivableList.isEmpty
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
                                    child: TTMImage.name(
                                        TTMImage.noDataPlaceholder),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  const Text(
                                    "暂无发票信息",
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
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                          ),
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
                              itemCount: model.settlementReceivableList.length,
                              itemBuilder: (context, index) {
                                return buildReceivableCell(index);
                              })),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }

  Widget buildReceivableCell(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => SettlementDetailPage(
                        type: SettlementDetailType.receivable,
                        receivableModel: model.settlementReceivableList[index],
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
                            "资金流水号：",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model.settlementReceivableList[index]
                                    .serialNumber ??
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
                                  "收款方：${model.settlementReceivableList[index].driver.name}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "金额: ${model.settlementReceivableList[index].amount} 元",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "创建时间: ${DateUtil.parseStringToFormateString(model.settlementReceivableList[index].dateCreated ?? "")}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                // 1,新增，2 待确认，3已确认，4拒绝
                                Text(
                                  model.settlementReceivableList[index]
                                              .status ==
                                          "1"
                                      ? "状态：新增"
                                      : model.settlementReceivableList[index]
                                                  .status ==
                                              "2"
                                          ? "状态：待确认"
                                          : model
                                                      .settlementReceivableList[
                                                          index]
                                                      .status ==
                                                  "3"
                                              ? "状态：已确认"
                                              : model
                                                          .settlementReceivableList[
                                                              index]
                                                          .status ==
                                                      "4"
                                                  ? "状态：拒绝"
                                                  : "状态：未知",
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
                          model.settlementReceivableList[index].status == "2"
                              ? Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  SettlementDetailPage(
                                                    type: SettlementDetailType
                                                        .receivable,
                                                    receivableModel: model
                                                            .settlementReceivableList[
                                                        index],
                                                  )));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: TTMColors.mainBlue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text(
                                          "去审核",
                                          style: TextStyle(
                                              color: TTMColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                  ))
                              : Container()
                        ],
                      )
                    ],
                  ),
                ),
                index != (model.settlementReceivableList.length - 1)
                    ? Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: 1,
                        color: TTMColors.cellLineColor,
                      )
                    : Container()
              ],
            )));
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: receivableInputFocusNode,
                  controller: receivableTextEditingController,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorWidth: 3.0,
                  cursorColor: TTMColors.mainBlue,
                  cursorRadius: const Radius.circular(10),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        receivableInputFocusNode.unfocus();
                        if (receivableTextEditingController.text == "") {
                          return;
                        }
                        receivableTextEditingController.clear();
                        model.clearReceivableSearchCode();
                        model.refreshReceivableList(context);
                      },
                    ),
                    hintText: "请输入资金流水号",
                    hintStyle: const TextStyle(
                      color: TTMColors.joinFleetBodyTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                  ),
                  onSubmitted: (v) {
                    model.receivableActualCode = v;
                    model.refreshReceivableList(context);
                    receivableInputFocusNode.unfocus();
                  },
                  onChanged: (v) {
                    model.receivableActualCode = v;
                    model.refreshReceivableList(context);
                  },
                  onEditingComplete: () {
                    model.refreshReceivableList(context);
                  },
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                receivableInputFocusNode.unfocus();
                model.refreshReceivableList(context);
              },
              icon: settlementSearch1(
                  size: 28, color: TTMColors.secondTitleColor))
        ],
      ),
    );
  }

  Widget buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Wrap(
        spacing: 10,
        children: [
          model.receivableFilterDateEnd != "" &&
                  model.receivableFilterDateStart != ""
              ? InputChip(
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      goodFilterDate2(size: 12, color: TTMColors.white),
                      Container(
                        width: 5,
                      ),
                      const Text(
                        "发票创建起止日期: ",
                        style: TTMTextStyle.goodsFilterSelectedTips,
                      ),
                      Text(model.receivableFilterDateStart,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      const Text(" 至 ",
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      Text(model.receivableFilterDateEnd,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                    ],
                  ),
                  // disabledColor: Colors.white,
                  backgroundColor: TTMColors.mainBlue,

                  shape: const StadiumBorder(
                      side: BorderSide(width: 2, color: TTMColors.mainBlue)),
                  deleteIconColor: TTMColors.white,
                  onPressed: () {
                    model.choseReceivableFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshReceivableList(context);
                      }
                    });
                  },
                  onDeleted: () {
                    model.clearReceivableFilterDate();
                    model.refreshReceivableList(context);
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
                      Text(
                        "发票创建起止日期: ",
                        style: TTMTextStyle.goodsFilterTitle,
                      ),
                      Text(
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
                    model.choseReceivableFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshReceivableList(context);
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
                model.receivableListFilterTypes.length == 4
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
              await model.choseReceivableFilterType(context);
              model.refreshReceivableList(context);
            },
          ),
        ],
      ),
    );
  }
}
