import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

enum FleetSearchBodyType { plsSearch, noResult, showList }

class JoinFleetPage extends StatefulWidget {
  const JoinFleetPage({Key? key}) : super(key: key);

  @override
  _JoinFleetPageState createState() => _JoinFleetPageState();
}

class _JoinFleetPageState extends State<JoinFleetPage> {
  final joinFleetPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  late FleetSearchBodyType searchBodyType = FleetSearchBodyType.plsSearch;
  late String chosenFleetName = "";
  late String chosenFleetId = "";
  late String inpuStr = "";
  late bool isChosenFleet = false;

  final FocusNode searchTextfiledFocusNode = FocusNode();

  @override
  void initState() {
    model = ScopedModel.of<MainStatusModel>(context);
    model.searchCarFleetList = [];
    super.initState();
  }

  void stowkeyBoard() {
    searchTextfiledFocusNode.unfocus();
  }

  void searchCarFleet(String inputStr) async {
    await model.searchCarFleet(inputStr, context).then((isSuccess) {
      if (isSuccess) {
        setState(() {
          searchBodyType = model.searchCarFleetList.isEmpty
              ? FleetSearchBodyType.noResult
              : FleetSearchBodyType.showList;
        });
      } else {
        FlushBarWidget.createDanger("搜索失败", context);
      }
    });
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: "申请加入车队",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 20),
      height: 70,
      width: TTMSize.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              focusNode: searchTextfiledFocusNode,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                color: TTMColors.textFiledHintValueColor,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: "请输入车队名称，联系人名称，或联系人手机号",
                hintStyle: TextStyle(
                  color: TTMColors.textFiledHintEmptyColor,
                  fontSize: 14,
                ),
              ),
              onSubmitted: (name) {
                searchCarFleet(name);
                setState(() {});
                stowkeyBoard();
              },
              onChanged: (name) {
                inpuStr = name;
              },
            ),
          ),
          Container(width: 20),
          IconButton(
              onPressed: () {
                // search
                searchCarFleet(inpuStr);
                stowkeyBoard();
              },
              icon: settlementSearch3())
        ],
      ),
    );
  }

  Widget buildSearchBody() {
    switch (searchBodyType) {
      case FleetSearchBodyType.plsSearch:
        return Expanded(
          child: ListView(
            // shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    right: 60, left: 60, top: 5, bottom: 5),
                margin: const EdgeInsets.all(40),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    Center(
                      child: Text(
                        "请搜索",
                        style: TTMTextStyle.joinFleetBodyPlaceholderTitle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case FleetSearchBodyType.noResult:
        return Expanded(
          child: ListView(
            // shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    right: 60, left: 60, top: 5, bottom: 5),
                margin: const EdgeInsets.all(40),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      width: 245,
                      child: TTMImage.name(TTMImage.noDataPlaceholder),
                    ),
                    Container(
                      height: 20,
                    ),
                    const Text(
                      "没有找到指定车队",
                      textAlign: TextAlign.center,
                      style: TTMTextStyle.joinFleetBodyPlaceholderTitle,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case FleetSearchBodyType.showList:
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
                    itemCount: model.searchCarFleetList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (model.searchCarFleetList.isEmpty) {
                        return Container();
                      } else {
                        return buildSerachResultListCell(
                            model.searchCarFleetList[index].company_name ?? "",
                            model.searchCarFleetList[index].id ?? "",
                            index == model.searchCarFleetList.length);
                      }
                    }),
              )
            ],
          ),
        );
    }
  }

  Widget buildSerachResultListCell(String title, String id, bool isTheLastOne) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () {
          setState(() {
            chosenFleetName = title;
            chosenFleetId = id;
            isChosenFleet = true;
          });
          stowkeyBoard();
        },
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TTMTextStyle.joinFleetBodySearchResultTitle),
                    chosenFleetName == title
                        ? mineSelect(size: 20, color: TTMColors.mainBlue)
                        : mineUnselect(
                            size: 20, color: TTMColors.textFiledHintEmptyColor)
                  ],
                ),
              ),
              !isTheLastOne
                  ? Positioned(
                      left: 20,
                      right: 20,
                      bottom: 0,
                      child: Container(
                        height: 1,
                        color: TTMColors.settingLineColor,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
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
          onPressed: () {
            // search
            stowkeyBoard();
            isChosenFleet
                ? model.joinFleet(chosenFleetId).then((isSuccess) async {
                    if (isSuccess) {
                      Navigator.pop(context);
                      FlushBarWidget.createDone("加入车队成功，请等待审核", context);
                      await model.getMyDetaillInfo(context);
                    } else {
                      if (UserInfoModel().driver == null) {
                        EasyLoading.showError(
                            "当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
                      } else {
                        FlushBarWidget.createDanger("加入车队失败", context);
                      }
                    }
                  })
                : setState(() {
                    searchBodyType = FleetSearchBodyType.showList;
                  });
          },
          child: Container(
            height: 50,
            width: TTMSize.screenWidth < 260 ? TTMSize.screenWidth - 40 : 260,
            decoration: const BoxDecoration(
              color: TTMColors.myInfoSaveBtnColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: !isChosenFleet
                  ? const Text(
                      "搜索",
                      style: TTMTextStyle.bottomBtnTitle,
                    )
                  : const Text(
                      "加入",
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
          key: joinFleetPageKey,
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
                  buildSearchBar(),
                  buildSearchBody(),
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
