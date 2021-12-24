import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:ttm/pages/orders/order_detail_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';
import 'package:ttm/widgets/flush_bar.dart';

enum UploadMutipleType { loadingPage, receiptPage }

class UploadMultipleImagePage extends StatefulWidget {
  const UploadMultipleImagePage({
    Key? key,
    // required this.locationData,
    required this.wayBillModel,
    required this.orderType,
    required this.uploadType,
  }) : super(key: key);

  // final LocationData locationData;
  final OrderDetailType orderType;
  final UploadMutipleType uploadType;
  final WayBillModel wayBillModel;

  @override
  _UploadMultipleImagePageState createState() =>
      _UploadMultipleImagePageState();
}

class _UploadMultipleImagePageState extends State<UploadMultipleImagePage> {
  final uploadPageKey = GlobalKey<ScaffoldState>();
  bool isAgreeContract = false;

  late final WayBillModel wayModel;
  late MainStatusModel model;

  List<String> totalImages = [];

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    wayModel = widget.wayBillModel;
    initImageDataList();
  }

  void initImageDataList() {
    switch (widget.uploadType) {
      case UploadMutipleType.loadingPage:
        if (wayModel.attached.loading.isNotEmpty) {
          for (var item in wayModel.attached.loading) {
            totalImages.add(item!);
          }
        }
        break;
      case UploadMutipleType.receiptPage:
        if (wayModel.attached.receipt.isNotEmpty) {
          for (var item in wayModel.attached.receipt) {
            totalImages.add(item!);
          }
        }
        break;
    }
  }

  Widget buildImageItem(int index) {
    return index != totalImages.length
        ? Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                        TTMConstants.imageAssetsUrl + totalImages[index],
                        fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    height: 35,
                    width: 35,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          color: TTMColors.titleColor,
                          onPressed: () {
                            setState(() {
                              totalImages.removeAt(index);
                            });
                          },
                          icon: commonError1(
                              size: 17, color: TTMColors.secondTitleColor)),
                    ))
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              model.showImageChooser(context, (id) {
                setState(() {
                  totalImages.add(id);
                });
              }, () {
                FlushBarWidget.createDanger("上传文件失败", context);
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonAdd(size: 50, color: TTMColors.myInfoTitleColor),
                    Container(
                      height: 10,
                    ),
                    const Text(
                      "点击上传",
                      style: TextStyle(
                        fontSize: 18,
                        color: TTMColors.myInfoTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalImages.length + 1,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 20.0,
              //横轴间距
              crossAxisSpacing: 20.0,
              //子组件宽高长度比例
              childAspectRatio: 1),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return buildImageItem(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
      builder: (context, child, model) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            key: uploadPageKey,
            backgroundColor: TTMColors.backgroundColor,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leadingWidth: 100,
              title: widget.uploadType == UploadMutipleType.loadingPage
                  ? const Text(
                      "上传配载单",
                      // style: TTMTextStyle.whiteAppBarTitle,
                    )
                  : const Text(
                      "上传回单",
                      // style: TTMTextStyle.whiteAppBarTitle,
                    ),
              centerTitle: true,
              backgroundColor: TTMColors.mainBlue,
              elevation: 0,
            ),
            body: ColorfulSafeArea(
              topColor: TTMColors.white,
              bottomColor: TTMColors.white,
              child: Stack(children: [
                ListView(children: [buildBody()]),
                Positioned(bottom: 0, left: 0, right: 0, child: buildSaveBtn())
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget buildSaveBtn() {
    return Container(
      decoration: BoxDecoration(color: TTMColors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -2),
          blurRadius: 20.0,
          spreadRadius: -5,
        )
      ]),
      // height: 75,
      width: TTMSize.screenWidth,
      child: Column(
        children: [
          widget.uploadType == UploadMutipleType.receiptPage
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => isAgreeContract = !isAgreeContract);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                side: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: TTMColors.mainBlue,
                                    width: 2),
                                value: isAgreeContract,
                                checkColor: TTMColors.white,
                                activeColor: TTMColors.mainBlue,
                                onChanged: (isAgree) {
                                  setState(
                                      () => isAgreeContract = !isAgreeContract);
                                }),
                            const Text(
                              "同意平台代开发票",
                              style: TTMTextStyle.goodsCellDetailLabel,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 20,
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () async {
                if (totalImages.isEmpty) {
                  EasyLoading.showError("请先上传至少一张图片");
                  return;
                }

                if (!isAgreeContract &&
                    widget.uploadType == UploadMutipleType.receiptPage) {
                  EasyLoading.showError("请先同意'平台代开发票'选项");
                  return;
                }

                switch (widget.uploadType) {
                  case UploadMutipleType.loadingPage:
                    await Future.delayed(const Duration(microseconds: 100))
                        .then((value) {
                      model
                          .saveWayBillLoadingImages(
                        wayModel,
                        totalImages,
                      )
                          .then((isSuccess) async {
                        if (isSuccess) {
                          Navigator.pop(context);
                          FlushBarWidget.createDone("保存成功", context);
                          await Future.delayed(
                                  const Duration(microseconds: 8000))
                              .then((value) {
                            model.refreshWayBillList(context);
                          });
                        } else {
                          FlushBarWidget.createDanger("保存失败", context);
                        }
                      });
                    });
                    break;
                  case UploadMutipleType.receiptPage:
                    await Future.delayed(const Duration(microseconds: 100))
                        .then((value) {
                      model
                          .saveWayBillReceiptImages(
                        wayModel,
                        totalImages,
                      )
                          .then((isSuccess) async {
                        if (isSuccess) {
                          Navigator.pop(context);
                          FlushBarWidget.createDone("保存成功", context);
                          await Future.delayed(
                                  const Duration(microseconds: 800))
                              .then((value) {
                            model.refreshWayBillList(context);
                          });
                        } else {
                          FlushBarWidget.createDanger("保存失败", context);
                        }
                      });
                    });
                    break;
                }
              },
              child: Container(
                height: 50,
                width:
                    TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
                decoration: const BoxDecoration(
                  color: TTMColors.myInfoSaveBtnColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    "保存",
                    style: TTMTextStyle.bottomBtnTitle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
