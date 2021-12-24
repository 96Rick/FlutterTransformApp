import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/services.dart';
import 'package:ttm/utils/string_util.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final changePasswordPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  final FocusNode newPasswordTextfieldFocusNode = FocusNode();
  final FocusNode confirmTextfieldFocusNode = FocusNode();

  var pwd = "";
  var confirmPwd = "";

  void stowkeyBoard() {
    newPasswordTextfieldFocusNode.unfocus();
    confirmTextfieldFocusNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of<MainStatusModel>(context);
    super.initState();
  }

  Widget buildAppBar() {
    return TTMAppBar(
        title: "更改密码",
        bgColor: TTMColors.white,
        titleColor: TTMColors.titleColor);
  }

  Widget buildTextFields() {
    return Container(
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
          Container(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "请输入新密码",
                      style: TTMTextStyle.textField,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
                TextField(
                  focusNode: newPasswordTextfieldFocusNode,
                  textInputAction: TextInputAction.done,
                  style: TTMTextStyle.textField,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入...",
                    hintStyle: TTMTextStyle.textFieldHint,
                    contentPadding: EdgeInsets.only(right: 10),
                  ),
                  onSubmitted: (v) {
                    print(v);
                    pwd = v;
                  },
                  onChanged: (v) {
                    print(v);
                    pwd = v;
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
          Container(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "请确认新密码",
                      style: TTMTextStyle.textField,
                    ),
                    Text(
                      "*",
                      style: TTMTextStyle.requeirdLabel,
                    ),
                  ],
                ),
                TextField(
                  focusNode: confirmTextfieldFocusNode,
                  textInputAction: TextInputAction.done,
                  style: TTMTextStyle.textField,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入...",
                    hintStyle: TTMTextStyle.textFieldHint,
                    contentPadding: EdgeInsets.only(right: 10),
                  ),
                  onSubmitted: (v) {
                    print(v);
                    confirmPwd = v;
                  },
                  onChanged: (v) {
                    confirmPwd = v;
                    print(v);
                  },
                ),
                Container(
                  width: TTMSize.screenWidth,
                  color: TTMColors.settingLineColor,
                  height: 1,
                ),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildTextFields()
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
          onPressed: () {
            // save
            var isPasswordValidate = StringUtil.isPassword(pwd);
            if (pwd == "") {
              FlushBarWidget.createDanger("新密码不能为空", context);
              return;
            } else if (confirmPwd == "") {
              FlushBarWidget.createDanger("确认密码不能为空", context);
              return;
            } else if (pwd.length < 6) {
              FlushBarWidget.createDanger("新密码长度不能小于6位", context);
              return;
            } else if (pwd != confirmPwd) {
              FlushBarWidget.createDanger("新密码与确认密码不匹配", context);
              return;
            } else if (!isPasswordValidate) {
              FlushBarWidget.createDanger("密码不能少于8位且必须包含大小写字母和数字", context);
              return;
            }
            model.changePwd(pwd, confirmPwd).then((isSuccess) {
              if (isSuccess) {
                Navigator.pop(context);
                FlushBarWidget.createDone("更新密码成功", context);
                model.logout();
              } else {
                FlushBarWidget.createDanger("更新密码失败", context);
              }
            });
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
              "确认修改",
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
          key: changePasswordPageKey,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: false,
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
