import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/pages/mine/all_cars/add_car_setup1_page.dart';
import 'package:ttm/pages/mine/all_cars/car_list_page.dart';
import 'package:ttm/pages/mine/change_pwd/change_pwd_page.dart';
import 'package:ttm/pages/mine/my_Infos/my_info_page.dart';
import 'package:ttm/pages/mine/setting_pages/setting_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/mine/my_car_card.dart';

enum SettingCellType {
  myInfo,
  carList,
  changePWD,
  setting,
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late MainStatusModel model;
  final profilePageKey = GlobalKey<ScaffoldState>();

  // user model:
  late String email = UserInfoModel().email ?? "未设置邮箱";

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    // model.getMyCarCardInfo(context);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Widget buildSettingCell(SettingCellType type) {
    switch (type) {
      case SettingCellType.myInfo:
        return SizedBox(
          height: 60,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: mineMyinfo(size: 25)),
                        Expanded(
                          flex: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "我的信息",
                                style: TextStyle(
                                  color: TTMColors.settingTextColor,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: commonEnter1(
                                      size: 20,
                                      color: TTMColors.textFiledHintValueColor))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: TTMColors.white,
                            height: 1,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            color: TTMColors.settingLineColor,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const MyInfoPage()));
            },
          ),
        );
      case SettingCellType.carList:
        return SizedBox(
          height: 60,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: mineCarlist(size: 27)),
                        Expanded(
                          flex: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "车辆列表",
                                style: TextStyle(
                                  color: TTMColors.settingTextColor,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: commonEnter1(
                                      size: 20,
                                      color: TTMColors.textFiledHintValueColor))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: TTMColors.white,
                            height: 1,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            color: TTMColors.settingLineColor,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const CarListPage()));
            },
          ),
        );
      case SettingCellType.changePWD:
        return SizedBox(
          height: 60,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: mineChangePWD(size: 27)),
                        Expanded(
                          flex: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "密码修改",
                                style: TextStyle(
                                  color: TTMColors.settingTextColor,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: commonEnter1(
                                      size: 20,
                                      color: TTMColors.textFiledHintValueColor))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: TTMColors.white,
                            height: 1,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            color: TTMColors.settingLineColor,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const ChangePasswordPage()));
            },
          ),
        );
      case SettingCellType.setting:
        return SizedBox(
          height: 60,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: mineSetting(size: 26)),
                        Expanded(
                          flex: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "设置",
                                style: TextStyle(
                                  color: TTMColors.settingTextColor,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: commonEnter1(
                                      size: 20,
                                      color: TTMColors.textFiledHintValueColor))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const SettingPage()));
            },
          ),
        );
    }
  }

  Widget buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30),
                child: Text(
                  model.userInfoModel.first_name ?? "新用户",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: TTMColors.titleColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30),
                child: Text(
                  model.userInfoModel.email ?? "未设置邮箱",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: TTMColors.titleColor),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 30.0),
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: TTMImage.avatarPlaceholder,
                image:
                    'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMyCars() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "我的车辆",
                style: TextStyle(
                  fontSize: 18,
                  color: TTMColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CarListPage()));
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '查看全部',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: TTMColors.settingNextIconColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: 5,
                        ),
                        mineMoreCar(
                            size: 10, color: TTMColors.settingNextIconColor)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // padding: EdgeInsets.only(top: 10, bottom: 10),
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: model.profileCarCardList.isEmpty
                    ? 1
                    : model.profileCarCardList.length + 1,
                itemBuilder: (context, index) {
                  if (model.profileCarCardList.isEmpty) {
                    return buildAddCarButton();
                  } else if (index == model.profileCarCardList.length) {
                    return buildAddCarButton();
                  } else {
                    return Container(
                        padding: const EdgeInsets.only(right: 30.0),
                        height: 180,
                        child: CarCardListCell(
                          currentIndex: index,
                          onEditCarTapd: (tapedIndex) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddCarSetupFirstPage(
                                        carInfoModel: model
                                            .profileCarCardList[tapedIndex])));
                          },
                        ));
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget buildAddCarButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => AddCarSetupFirstPage()));
      },
      child: UnconstrainedBox(
        child: SizedBox(
          width: 110,
          height: 110,
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(0, 2),
                    blurRadius: 30.0,
                    spreadRadius: -10,
                  ),
                ],
                borderRadius: BorderRadius.circular(300),
                color: TTMColors.carCardBGBlueColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonAdd(size: 25, color: TTMColors.white),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    "添加车辆",
                    style: TextStyle(
                        color: TTMColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildSettings() {
    return Expanded(
      child: ListView(
        // shrinkWrap: true,
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 5),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: TTMColors.white,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildSettingCell(SettingCellType.values[index]);
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    model.getAllCarInfoList(context);
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            key: profilePageKey,
            backgroundColor: TTMColors.backgroundColor,
            resizeToAvoidBottomInset: false,
            body: ColorfulSafeArea(
                topColor: TTMColors.backgroundColor,
                bottomColor: TTMColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildAppBar(),
                    buildMyCars(),
                    buildSettings(),
                    Container(
                      height: TTMSize.bottomNavHeight + 50,
                    )
                  ],
                )),
          ),
        ),
      );
    });
  }
}
