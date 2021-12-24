import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/pages/mine/all_cars/add_car_setup1_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class AddCarSetupFouthPage extends StatefulWidget {
  const AddCarSetupFouthPage(
      {Key? key, required this.carInfoModel, required this.carPageType})
      : super(key: key);
  final AllCarInfoModel carInfoModel;
  final CarPageType carPageType;
  @override
  _AddCarSetupFouthPageState createState() => _AddCarSetupFouthPageState();
}

class _AddCarSetupFouthPageState extends State<AddCarSetupFouthPage> {
  final addCarPage4Key = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  late AllCarInfoModel carInfoModel;
  late bool readOnly;
  void showCanOnlyBrowseMsg() {
    FlushBarWidget.createWarning("已通过审核的车辆只可查看", context);
  }

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    carInfoModel = widget.carInfoModel;
    readOnly = widget.carPageType == CarPageType.browseCar;
    super.initState();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: widget.carPageType == CarPageType.editCar
            ? "编辑车辆（4/4）"
            : widget.carPageType == CarPageType.addCar
                ? "添加车辆（4/4）"
                : "查看车辆（4/4）",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildCarPhotoInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Container(
          margin: const EdgeInsets.all(10),
          height: 44,
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "车辆照片",
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
            children: [buildImages()],
          ),
        ),
      ],
    );
  }

  Widget buildImages() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 道路运输证
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 20.0, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "车辆正面照片",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (readOnly) {
                showCanOnlyBrowseMsg();
              } else {
                // update
                model.showImageChooser(context, (id) {
                  carInfoModel.attached.carFontPic = id;
                  model.notifyListeners();
                }, () {
                  FlushBarWidget.createDanger("上传文件失败", context);
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TTMColors.myInfoUploadImgBGColor,
              ),
              height: 146,
              width: TTMSize.screenWidth - 80,
              child: carInfoModel.attached.carFontPic == null ||
                      carInfoModel.attached.carFontPic == ""
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commonUploadImg(
                            size: 60, color: TTMColors.myInfoTitleColor),
                        const Text(
                          "点击上传",
                          style: TextStyle(
                            fontSize: 14,
                            color: TTMColors.myInfoTitleColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                          TTMConstants.imageAssetsUrl +
                              carInfoModel.attached.carFontPic!,
                          fit: BoxFit.contain),
                    ),
            ),
          ),
        ],
      ),

      // 审验记录盖章页
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20.0, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "车辆45度照片",
                        style: TTMTextStyle.thirdTitle,
                      ),
                      Text(
                        "*",
                        style: TTMTextStyle.requeirdLabel,
                      ),
                    ],
                  ),
                ],
              )),
          TextButton(
            onPressed: () {
              if (readOnly) {
                showCanOnlyBrowseMsg();
              } else {
                // update
                model.showImageChooser(context, (id) {
                  carInfoModel.attached.car45Pic = id;
                  model.notifyListeners();
                }, () {
                  FlushBarWidget.createDanger("上传文件失败", context);
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TTMColors.myInfoUploadImgBGColor,
              ),
              height: 146,
              width: TTMSize.screenWidth - 80,
              child: carInfoModel.attached.car45Pic == null ||
                      carInfoModel.attached.car45Pic == ""
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commonUploadImg(
                            size: 60, color: TTMColors.myInfoTitleColor),
                        const Text(
                          "点击上传",
                          style: TextStyle(
                            fontSize: 14,
                            color: TTMColors.myInfoTitleColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                          TTMConstants.imageAssetsUrl +
                              carInfoModel.attached.car45Pic!,
                          fit: BoxFit.contain),
                    ),
            ),
          ),
        ],
      ),
    ]);
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
                buildCarPhotoInfo()
                // buildQualificationCertificateInfo(),
              ],
            ),
          ),
        ],
      ),
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
        ),
      ]),
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () async {
            // save
            if (readOnly) {
              showCanOnlyBrowseMsg();
            } else if (carInfoModel.attached.carFontPic == null ||
                carInfoModel.attached.carFontPic == "") {
              FlushBarWidget.createWarning("车辆正面照片不能为空", context);
            } else if (carInfoModel.attached.car45Pic == null ||
                carInfoModel.attached.car45Pic == "") {
              FlushBarWidget.createWarning("车辆45度照片不能为空", context);
            } else if (await model.checkCarNumberIsExist(
                    carInfoModel.license_plate_number!, context) &&
                widget.carPageType == CarPageType.addCar) {
              FlushBarWidget.createWarning("该车牌号已存在，请勿重复添加", context);
            } else {
              switch (widget.carPageType) {
                case CarPageType.addCar:
                  await model.addMyCar(carInfoModel, context).then((isSuccess) {
                    if (isSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      FlushBarWidget.createDone("添加车辆成功", context);
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      FlushBarWidget.createDanger("添加车辆失败", context);
                    }
                  });
                  await model.getAllCarInfoList(context);
                  break;
                case CarPageType.editCar:
                  await model
                      .modifyMyCar(carInfoModel, context)
                      .then((isSuccess) {
                    if (isSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      FlushBarWidget.createDone("修改车辆成功", context);
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      FlushBarWidget.createDanger("修改车辆失败", context);
                    }
                  });
                  await model.getAllCarInfoList(context);
                  break;
                default:
                  showCanOnlyBrowseMsg();
              }
            }
          },
          child: Container(
            height: 50,
            width: TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
            decoration: const BoxDecoration(
              color: TTMColors.myInfoSaveBtnColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Center(
                child: Text(
              "保存",
              style: TTMTextStyle.bottomBtnTitle,
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          key: addCarPage4Key,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: false,
          body: ColorfulSafeArea(
            topColor: TTMColors.white,
            bottomColor: TTMColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAppBar(),
                buildBody(),
                readOnly ? Container() : buildSaveBtn(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
