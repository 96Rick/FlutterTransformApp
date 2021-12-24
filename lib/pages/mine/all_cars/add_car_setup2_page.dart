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
import 'package:ttm/pages/mine/all_cars/add_car_setup3_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/utils/string_util.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class AddCarSetupSecondPage extends StatefulWidget {
  const AddCarSetupSecondPage(
      {Key? key, required this.carInfoModel, required this.carPageType})
      : super(key: key);
  final AllCarInfoModel carInfoModel;
  final CarPageType carPageType;

  @override
  _AddCarSetupSecondPageState createState() => _AddCarSetupSecondPageState();
}

class _AddCarSetupSecondPageState extends State<AddCarSetupSecondPage> {
  final addCarPage2Key = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  final FocusNode carOwnerIDCarNumberTextfieldFocusNode = FocusNode();
  final FocusNode carVINNumberTextfieldFocusNode = FocusNode();

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

  void stowkeyBoard() {
    carOwnerIDCarNumberTextfieldFocusNode.unfocus();
    carVINNumberTextfieldFocusNode.unfocus();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: widget.carPageType == CarPageType.editCar
            ? "编辑车辆（2/4）"
            : widget.carPageType == CarPageType.addCar
                ? "添加车辆（2/4）"
                : "查看车辆（2/4）",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildCarLicenseInfo() {
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
              "行驶证基本信息",
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
              buildTextInputs(),
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

  Widget buildTextInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 车辆所有人身份证
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "车辆所有人身份证",
                    style: TTMTextStyle.textField,
                  ),
                  Text(
                    "*",
                    style: TTMTextStyle.requeirdLabel,
                  ),
                ],
              ),
              TextField(
                focusNode: carOwnerIDCarNumberTextfieldFocusNode,
                controller: TextEditingController(text: carInfoModel.owner),
                textInputAction: TextInputAction.done,
                readOnly: readOnly,
                style: TTMTextStyle.textField,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入身份证号",
                  hintStyle: TTMTextStyle.textFieldHint,
                  contentPadding: EdgeInsets.only(right: 10),
                ),
                onSubmitted: (v) {
                  carInfoModel.owner = v;
                },
                onChanged: (v) {
                  carInfoModel.owner = v;
                },
                onTap: () {
                  if (readOnly) {
                    showCanOnlyBrowseMsg();
                  }
                },
              ),
              Container(
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),
            ],
          ),
        ),

        // 车辆识别代号VIN
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "车辆识别代号VIN",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              TextField(
                focusNode: carVINNumberTextfieldFocusNode,
                controller: TextEditingController(
                    text: carInfoModel.vehicle_identification_code),
                textInputAction: TextInputAction.done,
                readOnly: readOnly,
                style: TTMTextStyle.textField,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入VIN码",
                  hintStyle: TTMTextStyle.textFieldHint,
                  contentPadding: EdgeInsets.only(right: 10),
                ),
                onSubmitted: (v) {
                  carInfoModel.vehicle_identification_code = v;
                },
                onChanged: (v) {
                  carInfoModel.vehicle_identification_code = v;
                },
                onTap: () {
                  if (readOnly) {
                    showCanOnlyBrowseMsg();
                  }
                },
              ),
              Container(
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),
            ],
          ),
        ),

        // 末次检验有效期至
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: TextButton(
            onPressed: () {
              if (readOnly) {
                showCanOnlyBrowseMsg();
              } else {
                // date
                setState(() {
                  model.choseDate(context, (date) {
                    carInfoModel.last_survey_validity = date;
                    model.notifyListeners();
                  });
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
                        "末次检验有效期至",
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
                      carInfoModel.last_survey_validity ?? "请选择",
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
      ],
    );
  }

  // 身份证
  Widget buildImages() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 行驶证正副页
      Row(
        children: [
          // 行驶证正
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "行驶证正页",
                        style: TTMTextStyle.thirdTitle,
                      ),
                      Text(
                        "*",
                        style: TTMTextStyle.requeirdLabel,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (readOnly) {
                        showCanOnlyBrowseMsg();
                      } else {
                        // upload
                        model.showImageChooser(context, (id) {
                          carInfoModel.attached.licenseHomePic = id;
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
                      height: 110,
                      width: TTMSize.screenWidth / 2,
                      child: carInfoModel.attached.licenseHomePic == null ||
                              carInfoModel.attached.licenseHomePic == ""
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                commonUploadImg(
                                    size: 40,
                                    color: TTMColors.myInfoTitleColor),
                                const Text(
                                  "点击上传",
                                  style: TTMTextStyle.thirdTitle,
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                  TTMConstants.imageAssetsUrl +
                                      carInfoModel.attached.licenseHomePic!,
                                  fit: BoxFit.contain),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 行驶证副
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "行驶证副页",
                        style: TTMTextStyle.thirdTitle,
                      ),
                      Text(
                        "*",
                        style: TTMTextStyle.requeirdLabel,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (readOnly) {
                        showCanOnlyBrowseMsg();
                      } else {
                        // upload
                        model.showImageChooser(context, (id) {
                          carInfoModel.attached.licenseSubPic = id;
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
                      height: 110,
                      width: TTMSize.screenWidth / 2,
                      child: carInfoModel.attached.licenseSubPic == null ||
                              carInfoModel.attached.licenseSubPic == ""
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                commonUploadImg(
                                    size: 40,
                                    color: TTMColors.myInfoTitleColor),
                                const Text(
                                  "点击上传",
                                  style: TTMTextStyle.thirdTitle,
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                  TTMConstants.imageAssetsUrl +
                                      carInfoModel.attached.licenseSubPic!,
                                  fit: BoxFit.contain),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 行驶证车辆页
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
                      "行驶证车辆页",
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
                //update
                model.showImageChooser(context, (id) {
                  carInfoModel.attached.licenseCarPic = id;
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
              child: carInfoModel.attached.licenseCarPic == null ||
                      carInfoModel.attached.licenseCarPic == ""
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
                              carInfoModel.attached.licenseCarPic!,
                          fit: BoxFit.contain),
                    ),
            ),
          ),
        ],
      ),

      // 末次检验记录页
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
                      "末次检验记录页",
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
                  carInfoModel.attached.licenseEndCheckPic = id;
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
              child: carInfoModel.attached.licenseEndCheckPic == null ||
                      carInfoModel.attached.licenseEndCheckPic == ""
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
                              carInfoModel.attached.licenseEndCheckPic!,
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
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildCarLicenseInfo()
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
            stowkeyBoard();
            if (carInfoModel.owner == null || carInfoModel.owner == "") {
              FlushBarWidget.createWarning("车辆所有人身份证不能为空", context);
            } else if (carInfoModel.vehicle_identification_code == null ||
                carInfoModel.vehicle_identification_code == "") {
              FlushBarWidget.createWarning("请输入车辆识别代号VIN", context);
            } else if (carInfoModel.last_survey_validity == null ||
                carInfoModel.last_survey_validity == "") {
              FlushBarWidget.createWarning("请选择末次检验有效期", context);
            } else if (carInfoModel.attached.licenseHomePic == null ||
                carInfoModel.attached.licenseHomePic == "") {
              FlushBarWidget.createWarning("请上传行驶证正页", context);
            } else if (carInfoModel.attached.licenseSubPic == null ||
                carInfoModel.attached.licenseSubPic == "") {
              FlushBarWidget.createWarning("请上传行驶证副页", context);
            } else if (carInfoModel.attached.licenseCarPic == null ||
                carInfoModel.attached.licenseCarPic == "") {
              FlushBarWidget.createWarning("请上传行驶车辆页", context);
            } else if (carInfoModel.attached.licenseEndCheckPic == null ||
                carInfoModel.attached.licenseEndCheckPic == "") {
              FlushBarWidget.createWarning("请上传末次检验记录页", context);
            } else if (!StringUtil.isIdCard(carInfoModel.owner!)) {
              FlushBarWidget.createDanger("身份证号格式错误", context);
              return;
            } else {
              // next
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddCarSetupThirdPage(
                            carInfoModel: carInfoModel,
                            carPageType: widget.carPageType,
                          )));
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
              "下一步",
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
          key: addCarPage2Key,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: stowkeyBoard,
            child: ColorfulSafeArea(
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
        ),
      );
    });
  }
}
