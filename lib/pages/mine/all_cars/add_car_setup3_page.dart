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
import 'package:ttm/pages/mine/all_cars/add_car_setup4_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class AddCarSetupThirdPage extends StatefulWidget {
  const AddCarSetupThirdPage(
      {Key? key, required this.carInfoModel, required this.carPageType})
      : super(key: key);
  final AllCarInfoModel carInfoModel;
  final CarPageType carPageType;

  @override
  _AddCarSetupThirdPageState createState() => _AddCarSetupThirdPageState();
}

class _AddCarSetupThirdPageState extends State<AddCarSetupThirdPage> {
  final addCarPage3Key = GlobalKey<ScaffoldState>();
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
            ? "编辑车辆（3/4）"
            : widget.carPageType == CarPageType.addCar
                ? "添加车辆（3/4）"
                : "查看车辆（3/4）",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildVehicleRoadTransportCertificateInfo() {
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
              "车辆道路运输证",
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
                padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: TextButton(
                  onPressed: () {
                    if (readOnly) {
                      showCanOnlyBrowseMsg();
                    } else {
                      // date
                      model.choseDate(context, (date) {
                        carInfoModel.audit_validity = date;
                        model.notifyListeners();
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "审验有效期至",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Text(
                              "*",
                              style: TTMTextStyle.requeirdLabel,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            carInfoModel.audit_validity ?? "请选择",
                            style: TTMTextStyle.thirdTitle,
                          ),
                        ),
                      ),
                      Container(
                        width: TTMSize.screenWidth,
                        color: TTMColors.settingLineColor,
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              buildImages()
            ],
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
                      "道路运输证",
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
                  carInfoModel.attached.permit = id;
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
              child: carInfoModel.attached.permit == null ||
                      carInfoModel.attached.permit == ""
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
                              carInfoModel.attached.permit!,
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
                      "审验记录盖章页",
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
                  carInfoModel.attached.examRecord = id;
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
              child: carInfoModel.attached.examRecord == null ||
                      carInfoModel.attached.examRecord == ""
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
                              carInfoModel.attached.examRecord!,
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
                buildVehicleRoadTransportCertificateInfo()
                // buildQualificationCertificateInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextBtn() {
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
          onPressed: () {
            // next
            if (carInfoModel.audit_validity == null ||
                carInfoModel.audit_validity == "") {
              FlushBarWidget.createWarning("请选择审核有效期", context);
              return;
            } else if (carInfoModel.loadDouble != null &&
                carInfoModel.loadDouble! >= 4.5) {
              if (carInfoModel.attached.permit == null ||
                  carInfoModel.attached.permit == "") {
                FlushBarWidget.createWarning("请上传行驶道路运输证", context);
                return;
              }
            } else if (carInfoModel.attached.examRecord == null ||
                carInfoModel.attached.examRecord == "") {
              FlushBarWidget.createWarning("请上传审核记录盖章页", context);
              return;
            }
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddCarSetupFouthPage(
                          carPageType: widget.carPageType,
                          carInfoModel: carInfoModel,
                        )));
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
                "下一步",
                style: TTMTextStyle.bottomBtnTitle,
              ),
            ),
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
          key: addCarPage3Key,
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
                buildNextBtn(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
