import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/pages/mine/my_infos/join_fleet.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/utils/string_util.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final myInfoPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  final FocusNode idCardNameTextfiledFocusNode = FocusNode();
  final FocusNode idNumberTextfiledFocusNode = FocusNode();
  final FocusNode idPhoneNumberTextfiledFocusNode = FocusNode();
  final FocusNode idPoliceStationTextfiledFocusNode = FocusNode();
  final FocusNode qcTextfiledFocusNode = FocusNode();

  final String driverPassStatus = "2";
  final String driverFinishStatus = "4";

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    model.getMyDetaillInfo(context);
    print(
        "--------------------------- ${model.currentUserDetailNameInfo} ${model.myDetailInfoModel.name} ${UserInfoModel().first_name}");
    super.initState();
  }

  void stowkeyBoard() {
    idCardNameTextfiledFocusNode.unfocus();
    idNumberTextfiledFocusNode.unfocus();
    idPhoneNumberTextfiledFocusNode.unfocus();
    idPoliceStationTextfiledFocusNode.unfocus();
    qcTextfiledFocusNode.unfocus();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: "我的信息",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  bool textFieldReadOnly() {
    if (model.myDetailInfoModel.status == driverPassStatus ||
        model.myDetailInfoModel.status == driverFinishStatus) {
      return true;
    } else {
      return false;
    }
  }

  bool isUserStatusPassOrFinish() {
    if (model.myDetailInfoModel.status == driverPassStatus ||
        model.myDetailInfoModel.status == driverFinishStatus) {
      stowkeyBoard();
      FlushBarWidget.createWarning("您已通过审核，无法进行修改", context);
      return true;
    } else {
      return false;
    }
  }
  // UI

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
                buildFleetInfo(),
                Container(height: 20),
                buildDriverCardInfo(),
                Container(height: 20),
                buildIDCardInfo(),
                Container(height: 20),
                buildQualificationCertificateInfo(),
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
        )
      ]),
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () async {
            print("------------");
            model.myDetailInfoModel.name = model.currentUserDetailNameInfo;
            print(model.myDetailInfoModel.status);
            if (model.myDetailInfoModel.status == "2" ||
                model.myDetailInfoModel.status == "4") {
              FlushBarWidget.createDanger("您的信息已通过审核，无法进行更改", context);
              return;
            }
            if (model.myDetailInfoModel.attached.busLicensePic == null) {
              FlushBarWidget.createDanger("驾驶证图片不能为空", context);
              return;
            } else if (model.myDetailInfoModel.driver_start == null ||
                model.myDetailInfoModel.driver_start == "") {
              FlushBarWidget.createDanger("驾驶证有效期起时间不能为空", context);
              return;
            } else if (model.myDetailInfoModel.driver_end == null ||
                model.myDetailInfoModel.driver_end == "") {
              FlushBarWidget.createDanger("驾驶证有效期止时间不能为空", context);
              return;
            } else if (model.myDetailInfoModel.attached.idFront == null) {
              FlushBarWidget.createDanger("身份证正面图片不能为空", context);
              return;
            } else if (model.myDetailInfoModel.attached.idBack == null) {
              FlushBarWidget.createDanger("身份证反面图片不能为空", context);
              return;
            } else if (model.myDetailInfoModel.name == null ||
                model.myDetailInfoModel.name == "") {
              FlushBarWidget.createDanger("身份证姓名不能为空", context);
              return;
            } else if (model.myDetailInfoModel.id_card == null ||
                model.myDetailInfoModel.id_card == "") {
              FlushBarWidget.createDanger("身份证号不能为空", context);
              return;
            } else if (model.myDetailInfoModel.id_card_start == null ||
                model.myDetailInfoModel.id_card_start == "") {
              FlushBarWidget.createDanger("身份证有效期起时间不能为空", context);
              return;
            } else if (model.myDetailInfoModel.id_card_end == null ||
                model.myDetailInfoModel.id_card_end == "") {
              FlushBarWidget.createDanger("身份证有效期止时间不能为空", context);
              return;
            } else if (model.myDetailInfoModel.police_station == null ||
                model.myDetailInfoModel.police_station == "") {
              FlushBarWidget.createDanger("身份证派出所不能为空", context);
              return;
            } else if (model.currentUserDetailPhoneNumberInfo == "") {
              FlushBarWidget.createDanger("电话不能为空", context);
              return;
            } else if (!StringUtil.isChinaPhoneLegal(
                model.currentUserDetailPhoneNumberInfo)) {
              FlushBarWidget.createDanger("电话格式错误", context);
              return;
            } else if (!StringUtil.isIdCard(model.myDetailInfoModel.id_card!)) {
              FlushBarWidget.createDanger("身份证号格式错误", context);
              return;
            } else if (await model.checkUserIdCardIsExist(
                    model.myDetailInfoModel.id_card!, context) &&
                UserInfoModel().driver == null) {
              FlushBarWidget.createDanger("该身份证已注册", context);
            } else if (UserInfoModel().driver == null) {
              await model
                  .addMyInfo(model.myDetailInfoModel,
                      model.currentUserDetailPhoneNumberInfo, context)
                  .then((isSuccess) {
                if (isSuccess) {
                  Navigator.pop(context);
                  FlushBarWidget.createDone("保存成功", context);
                } else {
                  FlushBarWidget.createDone("保存失败", context);
                }
              });
            } else {
              await model
                  .modifyMyInfo(model.myDetailInfoModel,
                      model.currentUserDetailPhoneNumberInfo, context)
                  .then((isSuccess) {
                if (isSuccess) {
                  Navigator.pop(context);
                  FlushBarWidget.createDone("保存成功", context);
                } else {
                  FlushBarWidget.createDone("保存失败", context);
                }
              });
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
                "保存信息",
                style: TTMTextStyle.bottomBtnTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFleetInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "车队",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "我的车队",
                    style: TTMTextStyle.thirdTitle,
                  ),
                  TextButton(
                    onPressed: () {
                      if (model.isUserAlreadyJoinFleet) {
                        model.exitFleet().then((isSuccess) {
                          if (isSuccess) {
                            FlushBarWidget.createDone("退出车队成功", context);
                            model.getMyDetaillInfo(context);
                          } else {
                            FlushBarWidget.createDanger("退出车队失败", context);
                            model.getMyDetaillInfo(context);
                          }
                        });
                      } else if (model.isUserWaitingFleetParaExaminar) {
                        FlushBarWidget.createWarning("您已申请过车队", context);
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const JoinFleetPage()));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 5, right: 10, bottom: 5, left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: TTMColors.carCardEditBtnColor,
                      ),
                      child: Center(
                          child: Text(
                        model.isUserAlreadyJoinFleet
                            ? "退出车队"
                            : model.isUserWaitingFleetParaExaminar
                                ? "待审核"
                                : "申请车队",
                        style: TextStyle(
                            color: TTMColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
              Text(
                model.isUserAlreadyJoinFleet
                    ? model.myDetailInfoModel.company.first.companyId
                            .companyName ??
                        ""
                    : model.isUserWaitingFleetParaExaminar
                        ? model.userWaitingFleetParaExaminarCompanyName
                        : "暂无车队",
                style: TextStyle(
                  fontSize: 20,
                  color: TTMColors.myInfoTitleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDriverCardInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "驾驶证",
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
              // 标题
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "驾驶证图片",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),

              // 上传驾驶证
              TextButton(
                onPressed: () {
                  if (isUserStatusPassOrFinish()) {
                    return;
                  }
                  model.showImageChooser(context, (id) {
                    model.myDetailInfoModel.attached.busLicensePic = id;
                    model.notifyListeners();
                  }, () {
                    FlushBarWidget.createDanger("上传文件失败", context);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: TTMColors.myInfoUploadImgBGColor,
                  ),
                  height: 146,
                  width: TTMSize.screenWidth - 80,
                  child: model.myDetailInfoModel.attached.busLicensePic == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            commonUploadImg(
                                size: 40, color: TTMColors.myInfoTitleColor),
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
                                  model.myDetailInfoModel.attached
                                      .busLicensePic!,
                              fit: BoxFit.contain),
                        ),
                ),
              ),

              // 有效期起
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      if (isUserStatusPassOrFinish()) {
                        return;
                      }
                      model.choseDate(context, (date) {
                        if (date != "") {
                          model.myDetailInfoModel.driver_start = date;
                          model.notifyListeners();
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "有效期起",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Text(
                              "*",
                              style: TTMTextStyle.requeirdLabel,
                            ),
                          ],
                        ),
                        Text(
                          model.myDetailInfoModel.driver_start ?? "请选择",
                          style: TTMTextStyle.thirdTitle,
                        ),
                      ],
                    ),
                  ),

                  // 有效期止
                  TextButton(
                    onPressed: () {
                      if (isUserStatusPassOrFinish()) {
                        return;
                      }
                      model.choseDate(context, (date) {
                        if (date != "") {
                          model.myDetailInfoModel.driver_end = date;
                          model.notifyListeners();
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "有效期止",
                              style: TTMTextStyle.thirdTitle,
                            ),
                            Text(
                              "*",
                              style: TTMTextStyle.requeirdLabel,
                            ),
                          ],
                        ),
                        Text(
                          model.myDetailInfoModel.driver_end ?? "请选择",
                          style: TTMTextStyle.thirdTitle,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // 身份证
  Widget buildIDCardInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "法人身份证",
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
              // 身份证正反面
              Row(
                children: [
                  // 正面
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
                                "身份证正面",
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
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                              model.showImageChooser(context, (id) {
                                model.myDetailInfoModel.attached.idFront = id;
                                model.notifyListeners();
                              }, () {
                                FlushBarWidget.createDanger("上传文件失败", context);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: TTMColors.myInfoUploadImgBGColor,
                              ),
                              height: 110,
                              width: TTMSize.screenWidth / 2,
                              child: model.myDetailInfoModel.attached.idFront ==
                                      null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                              model.myDetailInfoModel.attached
                                                  .idFront!,
                                          fit: BoxFit.contain),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 反面
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
                                "身份证反面",
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
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                              model.showImageChooser(context, (id) {
                                model.myDetailInfoModel.attached.idBack = id;
                                model.notifyListeners();
                              }, () {
                                FlushBarWidget.createDanger("上传文件失败", context);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: TTMColors.myInfoUploadImgBGColor,
                              ),
                              height: 110,
                              width: TTMSize.screenWidth / 2,
                              child: model.myDetailInfoModel.attached.idBack ==
                                      null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                            model.myDetailInfoModel.attached
                                                .idBack!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 个人信息
              // 姓名
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "姓名",
                                style: TTMTextStyle.thirdTitle,
                              ),
                              Text(
                                "*",
                                style: TTMTextStyle.requeirdLabel,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: TextField(
                            readOnly: textFieldReadOnly(),
                            focusNode: idCardNameTextfiledFocusNode,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: model.currentUserDetailNameInfo)),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: TTMTextStyle.textField,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入姓名",
                              hintStyle: TTMTextStyle.textFieldHint,
                              contentPadding: EdgeInsets.only(right: 10),
                            ),
                            onSubmitted: (name) {
                              model.currentUserDetailNameInfo = name;
                            },
                            onChanged: (name) {
                              model.currentUserDetailNameInfo = name;
                            },
                            onTap: () {
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: TTMSize.screenWidth,
                      color: TTMColors.settingLineColor,
                      height: 1,
                    ),
                  ],
                ),
              ),

              //身份证号
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "身份证号",
                                style: TTMTextStyle.thirdTitle,
                              ),
                              Text(
                                "*",
                                style: TTMTextStyle.requeirdLabel,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: TextField(
                            readOnly: textFieldReadOnly(),
                            focusNode: idNumberTextfiledFocusNode,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text:
                                        model.myDetailInfoModel.id_card ?? "")),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: TTMTextStyle.textField,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入身份证号",
                              hintStyle: TTMTextStyle.textFieldHint,
                              contentPadding: EdgeInsets.only(right: 10),
                            ),
                            onSubmitted: (v) {
                              print(v);
                              model.myDetailInfoModel.id_card = v;
                            },
                            onChanged: (v) {
                              print(v);
                              model.myDetailInfoModel.id_card = v;
                            },
                            onTap: () {
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: TTMSize.screenWidth,
                      color: TTMColors.settingLineColor,
                      height: 1,
                    ),
                  ],
                ),
              ),

              // 起止日期
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                  onPressed: () {
                    if (isUserStatusPassOrFinish()) {
                      return;
                    }
                    model.choseDate(context, (date) {
                      if (date != "") {
                        model.myDetailInfoModel.id_card_start = date;
                        model.notifyListeners();
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "有效期起",
                            style: TTMTextStyle.thirdTitle,
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                              fontSize: 14,
                              color: TTMColors.dangerColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        model.myDetailInfoModel.id_card_start ?? "请选择",
                        style: TextStyle(
                          fontSize: 14,
                          color: TTMColors.myInfoTitleColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),

              // 有效期止
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                  onPressed: () {
                    if (isUserStatusPassOrFinish()) {
                      return;
                    }
                    model.choseDate(context, (date) {
                      if (date != "") {
                        model.myDetailInfoModel.id_card_end = date;
                        model.notifyListeners();
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "有效期止",
                            style: TextStyle(
                              fontSize: 14,
                              color: TTMColors.myInfoTitleColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                              fontSize: 14,
                              color: TTMColors.dangerColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        model.myDetailInfoModel.id_card_end ?? "请选择",
                        style: TextStyle(
                          fontSize: 14,
                          color: TTMColors.myInfoTitleColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),

              // 派出所
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "派出所",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: TTMColors.myInfoTitleColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: TTMColors.dangerColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: TextField(
                            readOnly: textFieldReadOnly(),
                            focusNode: idPoliceStationTextfiledFocusNode,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: model
                                            .myDetailInfoModel.police_station ??
                                        "")),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: TTMColors.textFiledHintValueColor,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入派出所",
                              hintStyle: TextStyle(
                                color: TTMColors.textFiledHintEmptyColor,
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 10),
                            ),
                            onSubmitted: (v) {
                              model.myDetailInfoModel.police_station = v;
                              print(v);
                            },
                            onChanged: (v) {
                              print(v);
                              model.myDetailInfoModel.police_station = v;
                            },
                            onTap: () {
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: TTMSize.screenWidth,
                      color: TTMColors.settingLineColor,
                      height: 1,
                    ),
                  ],
                ),
              ),

              // 电话
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "电话",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: TTMColors.myInfoTitleColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: TTMColors.dangerColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: TextField(
                            readOnly: textFieldReadOnly(),
                            focusNode: idPhoneNumberTextfiledFocusNode,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: model
                                        .currentUserDetailPhoneNumberInfo)),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: TTMColors.textFiledHintValueColor,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入电话",
                              hintStyle: TextStyle(
                                color: TTMColors.textFiledHintEmptyColor,
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 10),
                            ),
                            onSubmitted: (v) {
                              print(v);
                              model.currentUserDetailPhoneNumberInfo = v;
                            },
                            onChanged: (v) {
                              print(v);
                              model.currentUserDetailPhoneNumberInfo = v;
                            },
                            onTap: () {
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: TTMSize.screenWidth,
                      color: TTMColors.settingLineColor,
                      height: 1,
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

  Widget buildQualificationCertificateInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "从业资格证图片（可选）",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: TTMColors.myInfoTitleColor,
              ),
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
              // 标题
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(
                  "从业资格证图片",
                  style: TextStyle(
                    fontSize: 14,
                    color: TTMColors.myInfoTitleColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              // 上传从业资格证
              TextButton(
                onPressed: () {
                  if (isUserStatusPassOrFinish()) {
                    return;
                  }
                  model.showImageChooser(context, (id) {
                    model.myDetailInfoModel.attached.licensePic = id;
                    model.notifyListeners();
                  }, () {
                    FlushBarWidget.createDanger("上传文件失败", context);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: TTMColors.myInfoUploadImgBGColor,
                  ),
                  height: 146,
                  width: TTMSize.screenWidth - 80,
                  child: model.myDetailInfoModel.attached.licensePic == null
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
                                  model.myDetailInfoModel.attached.licensePic!,
                              fit: BoxFit.contain),
                        ),
                ),
              ),

              // 从业资格证编号
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "从业资格证编号",
                            style: TextStyle(
                              fontSize: 14,
                              color: TTMColors.myInfoTitleColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextField(
                            readOnly: textFieldReadOnly(),
                            focusNode: qcTextfiledFocusNode,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: model.myDetailInfoModel.certificate ??
                                        "")),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: TTMColors.textFiledHintValueColor,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入从业资格证编号",
                              hintStyle: TextStyle(
                                color: TTMColors.textFiledHintEmptyColor,
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 10),
                            ),
                            onSubmitted: (v) {
                              model.myDetailInfoModel.certificate = v;
                              print(v);
                            },
                            onChanged: (v) {
                              print(v);
                              model.myDetailInfoModel.certificate = v;
                            },
                            onTap: () {
                              if (isUserStatusPassOrFinish()) {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: TTMSize.screenWidth,
                      color: TTMColors.settingLineColor,
                      height: 1,
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          key: myInfoPageKey,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: true,
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
                  buildSaveBtn(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
