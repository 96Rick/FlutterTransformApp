import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/model/settlement_models/invoice_model.dart';
import 'package:ttm/model/settlement_models/receivable_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';
import 'package:ttm/pages/orders/gd_map_page.dart';
import 'package:ttm/widgets/flush_bar.dart';

enum SettlementDetailType { invoice, receivable }

class SettlementDetailPage extends StatefulWidget {
  SettlementDetailPage(
      {Key? key, required this.type, this.invoiceModel, this.receivableModel})
      : super(key: key);

  final SettlementDetailType type;
  final InvoiceModel? invoiceModel;
  final ReceivableModel? receivableModel;
  @override
  _SettlementDetailPageState createState() => _SettlementDetailPageState();
}

class _SettlementDetailPageState extends State<SettlementDetailPage> {
  final settlementDetailPageKey = GlobalKey<ScaffoldState>();
  late InvoiceModel invoiceModel;
  late ReceivableModel receivableModel;
  late MainStatusModel model;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == SettlementDetailType.invoice) {
      invoiceModel = widget.invoiceModel!;
    } else {
      receivableModel = widget.receivableModel!;
    }
    model = ScopedModel.of<MainStatusModel>(context);
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
                widget.type == SettlementDetailType.invoice
                    ? buildInvoicePage()
                    : buildReceivablePage()
              ],
            ),
          ),
        ],
      ),
    );
  }

// 发票详情

  Widget buildInvoicePage() {
    return Column(
      children: [
        buildInvoiceInfo(),
        Container(height: 20),
        buildWaybillInfo(),
      ],
    );
  }

  Widget buildInvoiceInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "发票信息",
              style: TTMTextStyle.secondTitle,
            ),
          ),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "系统发票号：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        invoiceModel.orderCarrier.isNotEmpty
                            ? invoiceModel
                                    .orderCarrier.first.orderCarrierId.code ??
                                ""
                            : "",
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
                      "实际发票号：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        invoiceModel.actualCode ?? "",
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
                      "付款人：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        invoiceModel.payer.companyName ?? "",
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
                      "收款人：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        invoiceModel.driver.name ?? "",
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
                      "金额（元）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${invoiceModel.amount} 元",
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
                      "税率（%）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${invoiceModel.rate}",
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
                      "税额（元）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${invoiceModel.tax}",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "实际发票：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Padding(
                      padding: invoiceModel.attached.actualInvoice != null
                          ? const EdgeInsets.all(10.0)
                          : const EdgeInsets.only(top: 10.0),
                      child: invoiceModel.attached.actualInvoice == null
                          ? const Text(
                              "暂无图片",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              style: TTMTextStyle.goodsDetailPageSecondTitle,
                            )
                          : Image.network(
                              TTMConstants.imageAssetsUrl +
                                  "${invoiceModel.attached.actualInvoice}",
                              fit: BoxFit.contain),
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

  List<Widget> buildGoods() {
    List<Widget> list = [];

    if (widget.type == SettlementDetailType.invoice) {
      if (invoiceModel.orderCarrier.isEmpty) {
        return [];
      }
      for (var item in invoiceModel.orderCarrier) {
        list.add(
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
                        "运单编号",
                        style: TTMTextStyle.goodsDetailPageLabel,
                      ),
                      Expanded(
                        child: Text(
                          item.orderCarrierId.code ?? "",
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
                        "价格：",
                        style: TTMTextStyle.thirdTitle,
                      ),
                      Expanded(
                        child: Text(
                          "${item.orderCarrierId.intention.demand.price.toString()} 元",
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
    } else {
      if (receivableModel.invoiceSell.isEmpty) {
        return [];
      }
      for (var item in receivableModel.invoiceSell.first.orderCarrier) {
        list.add(
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
                        "运单编号：",
                        style: TTMTextStyle.goodsDetailPageLabel,
                      ),
                      Expanded(
                        child: Text(
                          item.orderCarrierId.code ?? "",
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
                        "价格：",
                        style: TTMTextStyle.goodsDetailPageLabel,
                      ),
                      Expanded(
                        child: Text(
                          "${item.orderCarrierId.intention.demand.price}元",
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
    }
    return list;
  }

  Widget buildWaybillInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "运单信息",
              style: TTMTextStyle.secondTitle,
            ),
          ),
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
          child: Container(
              padding: const EdgeInsets.all(20),
              height: 240,
              decoration: const BoxDecoration(
                  color: TTMColors.cellLineColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                children: buildGoods(),
              )),
        ),
      ],
    );
  }

// 应收详情

  Widget buildReceivablePage() {
    return Column(
      children: [
        buildReceivableInfo(),
        Container(height: 20),
        buildReceivableInvoiceInfo(),
        Container(height: 20),
        buildWaybillInfo()
      ],
    );
  }

  Widget buildReceivableInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "结算信息",
              style: TTMTextStyle.secondTitle,
            ),
          ),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "收款人：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.driver.name ?? "",
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
                      "金额（元）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        "${receivableModel.amount} 元",
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
                      "资金流水号：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.serialNumber ?? "",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "流水清单：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    receivableModel.attached.capitalFlow != null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                                TTMConstants.imageAssetsUrl +
                                    receivableModel.attached.capitalFlow!,
                                fit: BoxFit.contain),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text("暂无图片",
                                style: TTMTextStyle.goodsDetailPageSecondTitle),
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

  Widget buildReceivableInvoiceInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "发票信息",
              style: TTMTextStyle.secondTitle,
            ),
          ),
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
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "实际发票号：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.invoiceSell.isEmpty
                            ? ""
                            : receivableModel.invoiceSell.first.actualCode ??
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
                padding: const EdgeInsets.only(left: 60.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "发票金额（元）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.invoiceSell.isEmpty
                            ? ""
                            : "${receivableModel.invoiceSell.first.amount} 元",
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
                      "税率（%）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.invoiceSell.isEmpty
                            ? ""
                            : "${receivableModel.invoiceSell.first.rate} %",
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
                      "税额（元）：",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        receivableModel.invoiceSell.isEmpty
                            ? ""
                            : "${receivableModel.invoiceSell.first.tax} 元",
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

  Widget builcBottomBtn() {
    if (widget.type == SettlementDetailType.invoice) {
      if (invoiceModel.status != "2") {
        return Container();
      }
    } else {
      if (receivableModel.status != "2") {
        return Container();
      }
    }
    return Container(
      decoration: BoxDecoration(color: TTMColors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -2),
          blurRadius: 20.0,
          spreadRadius: -5,
        )
      ]),
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                if (isLoading) {
                  return;
                }
                isLoading = true;
                switch (widget.type) {
                  case SettlementDetailType.invoice:
                    await model.refuseInvoice(invoiceModel).then((isSuccess) {
                      if (isSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                        FlushBarWidget.createDone("拒绝成功", context);
                        Future.delayed(Duration(microseconds: 500))
                            .then((value) {
                          model.refreshInvoiceList(context);
                          model.refreshReceivableList(context);
                        });
                      } else {
                        isLoading = false;
                        FlushBarWidget.createDanger("拒绝失败, 请再次提交", context);
                      }
                    });
                    break;
                  case SettlementDetailType.receivable:
                    model.refuseReceivable(receivableModel).then((isSuccess) {
                      if (isSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                        FlushBarWidget.createDone("拒绝成功", context);
                        Future.delayed(Duration(microseconds: 500))
                            .then((value) {
                          model.refreshInvoiceList(context);
                          model.refreshReceivableList(context);
                        });
                      } else {
                        isLoading = false;
                        FlushBarWidget.createDanger("拒绝失败, 请再次提交", context);
                      }
                    });
                    break;
                  default:
                    break;
                }
              },
              child: Container(
                height: 50,
                width: TTMSize.screenWidth < 260
                    ? TTMSize.screenWidth / 2 - 20
                    : 100,
                decoration: const BoxDecoration(
                  color: TTMColors.dangerColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                    child: Text(
                  "拒绝",
                  style: TTMTextStyle.bottomBtnTitle,
                )),
              ),
            ),
            TextButton(
              onPressed: () async {
                // search
                if (isLoading) {
                  return;
                }
                isLoading = true;
                switch (widget.type) {
                  case SettlementDetailType.invoice:
                    await model.agreedInvoice(invoiceModel).then((isSuccess) {
                      if (isSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                        FlushBarWidget.createDone("通过成功", context);
                        Future.delayed(Duration(microseconds: 500))
                            .then((value) {
                          model.refreshInvoiceList(context);
                          model.refreshReceivableList(context);
                        });
                      } else {
                        isLoading = false;
                        FlushBarWidget.createDanger("通过失败, 请再次提交", context);
                      }
                    });
                    break;
                  case SettlementDetailType.receivable:
                    model.agreedReceivable(receivableModel).then((isSuccess) {
                      if (isSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                        FlushBarWidget.createDone("通过成功", context);
                        Future.delayed(Duration(microseconds: 500))
                            .then((value) {
                          model.refreshInvoiceList(context);
                          model.refreshReceivableList(context);
                        });
                      } else {
                        isLoading = false;
                        FlushBarWidget.createDanger("通过失败, 请再次提交", context);
                      }
                    });
                    break;
                  default:
                    break;
                }
              },
              child: Container(
                height: 50,
                width: TTMSize.screenWidth < 260
                    ? TTMSize.screenWidth / 2 - 20
                    : 100,
                decoration: const BoxDecoration(
                  color: TTMColors.myInfoSaveBtnColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                    child: Text(
                  "通过",
                  style: TTMTextStyle.bottomBtnTitle,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        key: settlementDetailPageKey,
        backgroundColor: TTMColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 100,
          title: Text(
            widget.type == SettlementDetailType.invoice ? "发票详情" : "应收详情",
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
              builcBottomBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
