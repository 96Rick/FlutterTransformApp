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

class AllInvoicePage extends StatefulWidget {
  const AllInvoicePage({Key? key}) : super(key: key);

  @override
  _AllInvoicePageState createState() => _AllInvoicePageState();
}

class _AllInvoicePageState extends State<AllInvoicePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final allInvoicePageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late EasyRefreshController easyRefreshController;
  FocusNode invoiceInputFocusNode = FocusNode();
  late TextEditingController invoiceTextEditingController;

  void stowkeyBoard() {
    invoiceInputFocusNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    easyRefreshController = EasyRefreshController();
    invoiceTextEditingController =
        TextEditingController(text: model.invoiceActualCode);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        key: allInvoicePageKey,
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
                          refreshText: "?????????????????????",
                          refreshFailedText: "????????????",
                          refreshReadyText: "????????????",
                          refreshedText: "????????????",
                          refreshingText: "?????????...",
                          bgColor: TTMColors.backgroundColor),
                      onRefresh: () async {
                        await model.refreshInvoiceList(context);
                      },
                      emptyWidget: model.settlementInvoiceList.isEmpty
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
                                    "??????????????????",
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
                              left: 20.0, right: 20.0, bottom: 20.0),
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
                              itemCount: model.settlementInvoiceList.length,
                              itemBuilder: (context, index) {
                                return buildInvoiceCell(index);
                                // return Container();
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

  Widget buildInvoiceCell(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => SettlementDetailPage(
                        type: SettlementDetailType.invoice,
                        invoiceModel: model.settlementInvoiceList[index],
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
                          UnconstrainedBox(
                            child: Row(
                              children: [
                                settlementInvoice(
                                    size: 20, color: TTMColors.textColor),
                                Container(
                                  width: 10,
                                ),
                                Text(
                                  "??????????????????",
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
                            model.settlementInvoiceList[index].actualCode ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Wrap(
                        children: [
                          UnconstrainedBox(
                            child: Row(
                              children: [
                                goodMoney2(
                                    size: 20, color: TTMColors.textColor),
                                Container(
                                  width: 10,
                                ),
                                Text(
                                  "???????????????",
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
                            "${model.settlementInvoiceList[index].amount} ???",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "?????????",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${model.settlementInvoiceList[index].rate} %",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "?????????",
                            style: TextStyle(
                              fontSize: 18,
                              color: TTMColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${model.settlementInvoiceList[index].tax} ???",
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
                                  "????????????${model.settlementInvoiceList[index].payer.companyName}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "????????????${model.settlementInvoiceList[index].driver.name}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "????????????:     ${DateUtil.parseStringToFormateString(model.settlementInvoiceList[index].dateCreated ?? "")}",
                                  style: TTMTextStyle.wayBillCellDetailLabel,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  height: 5,
                                ),
                                // 1?????????2????????????3????????????4????????????5????????????6??????
                                Text(
                                  model.settlementInvoiceList[index].status ==
                                          "1"
                                      ? "???????????????"
                                      : model.settlementInvoiceList[index]
                                                  .status ==
                                              "2"
                                          ? "??????????????????"
                                          : model.settlementInvoiceList[index]
                                                      .status ==
                                                  "3"
                                              ? "??????????????????"
                                              : model
                                                          .settlementInvoiceList[
                                                              index]
                                                          .status ==
                                                      "4"
                                                  ? "??????????????????"
                                                  : model
                                                              .settlementInvoiceList[
                                                                  index]
                                                              .status ==
                                                          "5"
                                                      ? "??????????????????"
                                                      : model
                                                                  .settlementInvoiceList[
                                                                      index]
                                                                  .status ==
                                                              "6"
                                                          ? "???????????????"
                                                          : "???????????????",
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
                          model.settlementInvoiceList[index].status == "2"
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
                                                        .invoice,
                                                    invoiceModel: model
                                                            .settlementInvoiceList[
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
                                          "?????????",
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
                index != (model.settlementInvoiceList.length - 1)
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
                    focusNode: invoiceInputFocusNode,
                    controller: invoiceTextEditingController,
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
                          invoiceInputFocusNode.unfocus();
                          if (invoiceTextEditingController.text == "") {
                            return;
                          }
                          invoiceTextEditingController.clear();
                          model.clearInvoiceSearchCode();
                          model.refreshInvoiceList(context);
                        },
                      ),
                      hintText: "????????????????????????",
                      hintStyle: const TextStyle(
                        color: TTMColors.joinFleetBodyTitle,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                    ),
                    onSubmitted: (v) {
                      model.invoiceActualCode = v;
                      model.refreshInvoiceList(context);
                      invoiceInputFocusNode.unfocus();
                    },
                    onChanged: (v) {
                      model.invoiceActualCode = v;
                      model.refreshInvoiceList(context);
                    },
                    onEditingComplete: () {
                      model.refreshInvoiceList(context);
                    }),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                invoiceInputFocusNode.unfocus();
                model.refreshInvoiceList(context);
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
          model.invoiceFilterDateEnd != "" && model.invoiceFilterDateStart != ""
              ? InputChip(
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      goodFilterDate2(size: 12, color: TTMColors.white),
                      Container(
                        width: 5,
                      ),
                      const Text(
                        "????????????????????????: ",
                        style: TTMTextStyle.goodsFilterSelectedTips,
                      ),
                      Text(model.invoiceFilterDateStart,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      const Text(" ??? ",
                          style: TTMTextStyle.goodsFilterSelectedTips),
                      Text(model.invoiceFilterDateEnd,
                          style: TTMTextStyle.goodsFilterSelectedTips),
                    ],
                  ),
                  // disabledColor: Colors.white,
                  backgroundColor: TTMColors.mainBlue,

                  shape: const StadiumBorder(
                      side: BorderSide(width: 2, color: TTMColors.mainBlue)),
                  deleteIconColor: TTMColors.white,
                  onPressed: () {
                    model.choseInvoiceFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshInvoiceList(context);
                      }
                    });
                  },
                  onDeleted: () {
                    model.clearInvoiceFilterDate();
                    model.refreshInvoiceList(context);
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
                        "????????????????????????: ",
                        style: TTMTextStyle.goodsFilterTitle,
                      ),
                      Text(
                        "?????????",
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
                    model.choseInvoiceFilterDate(context, (isSuccess) {
                      if (isSuccess) {
                        model.refreshInvoiceList(context);
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
                  "?????????",
                  style: TTMTextStyle.goodsFilterSelectedTips,
                ),
                model.invoiceListFilterTypes.length == 6
                    ? const Text("??????",
                        style: TTMTextStyle.goodsFilterSelectedTips)
                    : const Text("??????",
                        style: TTMTextStyle.goodsFilterSelectedTips)
              ],
            ),
            // disabledColor: Colors.white,
            backgroundColor: TTMColors.mainBlue,

            shape: const StadiumBorder(
                side: BorderSide(width: 2, color: TTMColors.mainBlue)),
            onPressed: () async {
              await model.choseInvoiceFilterType(context);
              model.refreshInvoiceList(context);
            },
          ),
        ],
      ),
    );
  }
}
