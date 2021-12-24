import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/car_type_model.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/model/profile_models/attached_model.dart';
import 'package:ttm/pages/mine/all_cars/add_car_setup2_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

enum CarPageType { editCar, browseCar, addCar }

class AddCarSetupFirstPage extends StatefulWidget {
  const AddCarSetupFirstPage({Key? key, this.carInfoModel}) : super(key: key);
  final AllCarInfoModel? carInfoModel;

  @override
  _AddCarSetupFirstPageState createState() => _AddCarSetupFirstPageState();
}

class _AddCarSetupFirstPageState extends State<AddCarSetupFirstPage> {
  final addCarPage1Key = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  final FocusNode carNumberTextfieldFocusNode = FocusNode();
  final FocusNode residentCityTextfieldFocusNode = FocusNode();

  String? title;
  CarPageType pageStatus = CarPageType.addCar;
  AllCarInfoModel? carInfoModel;

  late List<CarTypeModel> carAxlesTypeList = [];
  late List<CarTypeModel?>? carTypeList = [];
  late List<CarTypeModel?>? carLoadList = [];

  late int? selectedLicenseType;
  late String? selectedCarPowerType;
  late String? selectedCarAxlesType;
  late String? selectedCarType;
  late String? selectedLoadMassType;

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    initData();
    super.initState();
  }

  void showCanOnlyBrowseMsg() {
    FlushBarWidget.createWarning("已通过审核的车辆只可查看", context);
  }

  void initData() {
    if (widget.carInfoModel != null) {
      carInfoModel = widget.carInfoModel;
      if (carInfoModel?.status == "1") {
        if (carInfoModel?.owner_company != null) {
          title = "查看车辆（1/4）";
          pageStatus = CarPageType.browseCar;
        } else {
          title = "编辑车辆（1/4）";
          pageStatus = CarPageType.editCar;
        }
      } else {
        title = "查看车辆（1/4）";
        pageStatus = CarPageType.browseCar;
      }
    } else {
      carInfoModel = AllCarInfoModel(attached: AttachedModel(), driver: []);
      title = "添加车辆（1/4）";
      pageStatus = CarPageType.addCar;
    }

    selectedLicenseType = carInfoModel?.license_color ?? 0;
    selectedCarPowerType = carInfoModel?.energy_types ?? "";
    selectedCarAxlesType = carInfoModel?.van_type ?? "";
    selectedCarType = carInfoModel?.van_species ?? "";
    selectedLoadMassType = carInfoModel?.load ?? "";

    //   if (selectedLoadMassType != "") {

    //   }
    // carInfoModel?.loadDouble =
    //                   double.parse(carInfoModel!.load!.replaceAll("t", ""));

    carAxlesTypeList = model.carTypeModelList;
    for (var item in carAxlesTypeList) {
      if (item.id == selectedCarAxlesType) {
        carTypeList = item.mds;
        break;
      }
    }
    if (carTypeList!.isNotEmpty) {
      for (var item in carTypeList!) {
        if (item!.id == selectedCarType) {
          carLoadList = item.mds;
          break;
        }
      }
    } else {
      carLoadList = [];
    }
    setLoadDouble();
  }

  void setLoadDouble() {
    List<CarTypeModel> list = [];
    if (carLoadList != null && carLoadList!.isNotEmpty) {
      list = carLoadList!.cast<CarTypeModel>();
      for (var item in list) {
        if (item.id == selectedLoadMassType) {
          carInfoModel?.loadDouble =
              double.parse(item.name!.replaceAll("t", ""));
        }
      }
    }
  }

  void stowkeyBoard() {
    carNumberTextfieldFocusNode.unfocus();
    residentCityTextfieldFocusNode.unfocus();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: title ?? "",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildCarInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 44,
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "车辆基础信息",
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
              // 车牌号
              Row(
                children: [
                  const Text(
                    "车牌号",
                    style: TextStyle(color: TTMColors.titleColor, fontSize: 18),
                  ),
                  const Text(
                    "*",
                    style: TTMTextStyle.requeirdLabel,
                  ),
                ],
              ),
              Container(
                height: 5,
              ),
              TextField(
                focusNode: carNumberTextfieldFocusNode,
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: carInfoModel?.license_plate_number ?? "")),
                textInputAction: TextInputAction.done,
                readOnly: pageStatus == CarPageType.browseCar,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入车牌号",
                  hintStyle: TextStyle(
                      color: TTMColors.textFiledHintEmptyColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.only(right: 10),
                ),
                onSubmitted: (v) {
                  print(v);
                  carInfoModel?.license_plate_number = v;
                },
                onChanged: (v) {
                  print(v);
                  carInfoModel?.license_plate_number = v;
                },
                onTap: () {
                  if (pageStatus == CarPageType.browseCar) {
                    showCanOnlyBrowseMsg();
                  }
                },
              ),
              Container(
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),

              // 车牌种类
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "车牌种类",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              buildCarLicenseTypeChip(),

              // 能源类型
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "能源类型",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              buildCarPowerTypeChip(),

              // 车辆轴数
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "车辆轴数",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              buildCarAxlesTypeChip(),

              // 货车种类
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "货车种类",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              buildCarTypeChip(),

              // 核定载质量
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "核定载质量",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
              ),
              buildCarLoadMassChip(),

              Container(
                height: 20,
              ),
              // 常驻城市
              Row(
                children: [
                  const Text(
                    "常驻城市",
                    style: TTMTextStyle.thirdTitle,
                  ),
                  const Text(
                    "*",
                    style: TTMTextStyle.requeirdLabel,
                  ),
                ],
              ),
              Container(
                height: 5,
              ),
              TextField(
                focusNode: residentCityTextfieldFocusNode,
                controller: TextEditingController(
                    text: carInfoModel?.resident_city ?? ""),
                textInputAction: TextInputAction.done,
                readOnly: pageStatus == CarPageType.browseCar,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入常驻城市",
                  hintStyle: TTMTextStyle.joinFleetBodyInputTextFildTitle,
                  contentPadding: EdgeInsets.only(right: 10),
                ),
                onSubmitted: (v) {
                  carInfoModel?.resident_city = v;
                },
                onChanged: (v) {
                  carInfoModel?.resident_city = v;
                },
                onTap: () {
                  if (pageStatus == CarPageType.browseCar) {
                    showCanOnlyBrowseMsg();
                  }
                },
              ),
              Container(
                width: TTMSize.screenWidth,
                color: TTMColors.settingLineColor,
                height: 1,
              ),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCarLicenseTypeChip() {
    List<Widget> carLicenseChips = [];
    var licenseList = [1, 2];
    for (var item in licenseList) {
      carLicenseChips.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ChoiceChip(
            selectedColor: item == 1
                ? TTMColors.carCardLicenseBlueColor
                : item == 2
                    ? TTMColors.carCardLicenseYellowColor
                    : Colors.grey,
            label: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 8, right: 8),
              child: Text(
                item == 1 ? "蓝牌" : "黄牌",
                style: TTMTextStyle.allCarLiceseTypeTitle,
              ),
            ),
            backgroundColor: TTMColors.joinFleetListUnChosenIconColor,
            selected: selectedLicenseType == item,
            onSelected: (bool value) {
              if (pageStatus == CarPageType.browseCar) {
                showCanOnlyBrowseMsg();
              } else {
                setState(() {
                  selectedLicenseType = item;
                  carInfoModel?.license_color = item;
                });
              }
            },
          ),
        ),
      );
    }
    return Wrap(
      children: carLicenseChips,
    );
  }

  Widget buildCarPowerTypeChip() {
    List<Widget> carPowerTypeChips = [];
    var powertypeList = ["1", "2", "3", "4", "5"];
    for (var item in powertypeList) {
      carPowerTypeChips.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ChoiceChip(
            label: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 8, right: 8),
              child: Text(
                item == "1"
                    ? "汽油"
                    : item == "2"
                        ? "电动"
                        : item == "3"
                            ? "混动"
                            : item == "4"
                                ? "人力"
                                : item == "5"
                                    ? "柴油"
                                    : "",
                style: TTMTextStyle.allCarLiceseTypeTitle,
              ),
            ),
            selectedColor: TTMColors.mainBlue,
            backgroundColor: TTMColors.joinFleetListUnChosenIconColor,
            selected: selectedCarPowerType == item,
            onSelected: (bool value) {
              if (pageStatus == CarPageType.browseCar) {
                showCanOnlyBrowseMsg();
              } else {
                setState(() {
                  selectedCarPowerType = item;
                  carInfoModel?.energy_types = item;
                });
              }
            },
          ),
        ),
      );
    }
    return Wrap(
      children: carPowerTypeChips,
    );
  }

  Widget buildCarAxlesTypeChip() {
    List<Widget> carAxlesChips = [];
    for (var item in carAxlesTypeList) {
      carAxlesChips.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ChoiceChip(
            label: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 8, right: 8),
              child: Text(
                item.name ?? "",
                style: TTMTextStyle.allCarLiceseTypeTitle,
              ),
            ),
            selectedColor: TTMColors.mainBlue,
            backgroundColor: TTMColors.joinFleetListUnChosenIconColor,
            selected: selectedCarAxlesType == item.id,
            onSelected: (bool value) {
              if (pageStatus == CarPageType.browseCar) {
                showCanOnlyBrowseMsg();
              } else {
                setState(() {
                  selectedCarAxlesType = item.id;
                  carInfoModel?.van_type = item.id;
                  carInfoModel?.van_species = null;
                  carInfoModel?.load = null;
                  carTypeList = item.mds ?? [];
                  carLoadList = [];
                  selectedCarType = '';
                  selectedLoadMassType = '';
                });
              }
            },
          ),
        ),
      );
    }
    return Wrap(
      children: carAxlesChips,
    );
  }

  Widget buildCarTypeChip() {
    List<Widget> carAxlesChips = [];
    List<CarTypeModel> list = [];
    if (carTypeList != null && carTypeList!.isNotEmpty) {
      list = carTypeList!.cast<CarTypeModel>();
      for (var item in list) {
        carAxlesChips.add(
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, left: 8, right: 8),
                child: Text(
                  item.name ?? "",
                  style: TTMTextStyle.allCarLiceseTypeTitle,
                ),
              ),
              backgroundColor: TTMColors.joinFleetListUnChosenIconColor,
              selectedColor: TTMColors.mainBlue,
              selected: selectedCarType == item.id,
              onSelected: (bool value) {
                if (pageStatus == CarPageType.browseCar) {
                  showCanOnlyBrowseMsg();
                } else {
                  setState(() {
                    selectedCarType = item.id;
                    carInfoModel?.van_species = item.id;
                    carInfoModel?.load = null;
                    carLoadList = item.mds;
                    selectedLoadMassType = '';
                  });
                }
              },
            ),
          ),
        );
      }
    } else {
      carAxlesChips.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: const ChoiceChip(
            label: Padding(
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8, right: 8),
              child: Text(
                "请先选择车辆轴数",
                style: TTMTextStyle.allCarLiceseTypeTitle,
              ),
            ),
            disabledColor: TTMColors.joinFleetListUnChosenIconColor,
            selected: false,
          ),
        ),
      );
    }
    return Wrap(
      children: carAxlesChips,
    );
  }

  Widget buildCarLoadMassChip() {
    List<Widget> carLoadMassChips = [];
    List<CarTypeModel> list = [];
    if (carLoadList != null && carLoadList!.isNotEmpty) {
      list = carLoadList!.cast<CarTypeModel>();
      for (var item in list) {
        carLoadMassChips.add(
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, left: 8, right: 8),
                child: Text(
                  item.name ?? "",
                  style: TTMTextStyle.allCarLiceseTypeTitle,
                ),
              ),
              selectedColor: TTMColors.mainBlue,
              backgroundColor: TTMColors.joinFleetListUnChosenIconColor,
              selected: selectedLoadMassType == item.id,
              onSelected: (bool value) {
                if (pageStatus == CarPageType.browseCar) {
                  showCanOnlyBrowseMsg();
                } else {
                  setState(() {
                    selectedLoadMassType = item.id;
                    carInfoModel?.load = item.id;
                  });
                  carInfoModel?.loadDouble =
                      double.parse(item.name!.replaceAll("t", ""));
                }
              },
            ),
          ),
        );
      }
    } else {
      carLoadMassChips.add(
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: const ChoiceChip(
            label: Padding(
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8, right: 8),
              child: Text(
                "请先选择货车种类",
                style: TTMTextStyle.allCarLiceseTypeTitle,
              ),
            ),
            disabledColor: TTMColors.joinFleetListUnChosenIconColor,
            selected: false,
          ),
        ),
      );
    }
    return Wrap(
      children: carLoadMassChips,
    );
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
                buildCarInfo(),
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
          onPressed: () async {
            // next
            stowkeyBoard();
            if (carInfoModel?.license_plate_number == null ||
                carInfoModel?.license_plate_number == "") {
              FlushBarWidget.createWarning("车牌号不能为空", context);
              return;
            } else if (carInfoModel?.license_color == null ||
                carInfoModel?.license_color == 0) {
              FlushBarWidget.createWarning("请选择车牌种类", context);
              return;
            } else if (carInfoModel?.energy_types == null ||
                carInfoModel?.energy_types == "") {
              FlushBarWidget.createWarning("请选择能源类型", context);
              return;
            } else if (carInfoModel?.van_type == null ||
                carInfoModel?.van_type == "") {
              FlushBarWidget.createWarning("请选择车辆轴数", context);
              return;
            } else if (carInfoModel?.van_species == null ||
                carInfoModel?.van_species == "") {
              FlushBarWidget.createWarning("请选择货车种类", context);
              return;
            } else if (carInfoModel?.load == null || carInfoModel?.load == "") {
              FlushBarWidget.createWarning("请选择核定载质量", context);
              return;
            } else if (carInfoModel?.resident_city == null ||
                carInfoModel?.resident_city == "") {
              FlushBarWidget.createWarning("请输入常驻城市", context);
              return;
            } else if (carInfoModel?.loadDouble != null &&
                carInfoModel!.loadDouble! >= 4.5) {
              if (model.myDetailInfoModel.certificate == "" ||
                  model.myDetailInfoModel.certificate == null ||
                  model.myDetailInfoModel.attached.licensePic == "" ||
                  model.myDetailInfoModel.attached.licensePic == null) {
                FlushBarWidget.createWarning(
                    "车辆载重超过4.5吨，请在我的信息页面上传从业资格证！", context);
                return;
              }
            }
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddCarSetupSecondPage(
                          carInfoModel: carInfoModel!,
                          carPageType: pageStatus,
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
          key: addCarPage1Key,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: true,
          body: ColorfulSafeArea(
            topColor: TTMColors.white,
            bottomColor: TTMColors.white,
            child: GestureDetector(
              onTap: stowkeyBoard,
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
