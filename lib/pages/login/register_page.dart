import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/pages/login/platform_protocol_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/utils/string_util.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/src/colorful_safe_area.dart';
import 'package:ttm/widgets/flush_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _registerPageKey = GlobalKey<ScaffoldState>();
  final FocusNode _emailTextfiledFocusNode = FocusNode();
  final FocusNode _nameTextfiledFocusNode = FocusNode();
  final FocusNode _passwordTextfiledFocusNode = FocusNode();
  final FocusNode _confirmPasswordTextfiledFocusNode = FocusNode();

  late String _email = "";
  late String _name = "";
  late String _password = "";
  late String _confirmPassword = "";

  bool isAgree = false;

  late bool _isInputting;

  void _tapBlankSpace() {
    setState(() {
      _isInputting = false;
    });
    _emailTextfiledFocusNode.unfocus();
    _nameTextfiledFocusNode.unfocus();
    _passwordTextfiledFocusNode.unfocus();
    _confirmPasswordTextfiledFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return GestureDetector(
        onTap: _tapBlankSpace,
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            key: _registerPageKey,
            backgroundColor: TTMColors.backgroundColor,
            resizeToAvoidBottomInset: false,
            // 改了别人的轮子，支持设置上下左右 safearea的不同北京颜色
            body: ColorfulSafeArea(
              topColor: TTMColors.mainBlue,
              bottom: false,
              child: Column(
                children: [
                  TTMAppBar(
                    title: "司机注册",
                    bgColor: TTMColors.mainBlue,
                    titleColor: TTMColors.white,
                    iconColor: TTMColors.white,
                  ),
                  Expanded(
                    child: ListView(shrinkWrap: true, children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: TTMColors.white,
                        ),
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _registerFormKey,
                          child: Column(
                            children: [
                              // Email Text Filed
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: TTMColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                                focusNode: _emailTextfiledFocusNode,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: TTMColors.secondTitleColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                  hintStyle: TextStyle(
                                      color: TTMColors.cellLineColor,
                                      fontSize: 20),
                                  // border: InputBorder.none,

                                  labelText: "注册邮箱 *",
                                  hintText: "请输入邮箱",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.cellLineColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.mainBlue,
                                    ),
                                  ),
                                ),
                                //   //检验密码
                                onTap: () {
                                  setState(() => _isInputting = true);
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _email = value;
                                    _emailTextfiledFocusNode.unfocus();
                                    _nameTextfiledFocusNode.requestFocus();
                                    _isInputting = true;
                                  });
                                },
                                onChanged: (email) {
                                  _email = email;
                                  if (!_isInputting) {
                                    setState(() => _isInputting = true);
                                  }
                                },
                              ),

                              // Name Text Filed
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: TTMColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                                focusNode: _nameTextfiledFocusNode,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: TTMColors.secondTitleColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                  hintStyle: TextStyle(
                                      color: TTMColors.cellLineColor,
                                      fontSize: 20),
                                  // border: InputBorder.none,

                                  labelText: "姓名 *",
                                  hintText: "请输入您的姓名",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.cellLineColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.mainBlue,
                                    ),
                                  ),
                                ),
                                //   //检验密码
                                onTap: () {
                                  setState(() => _isInputting = true);
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _name = value;
                                    _nameTextfiledFocusNode.unfocus();
                                    _passwordTextfiledFocusNode.requestFocus();
                                    _isInputting = true;
                                  });
                                },
                                onChanged: (name) {
                                  _name = name;
                                  if (!_isInputting) {
                                    setState(() => _isInputting = true);
                                  }
                                },
                              ),

                              // Password Text Filed
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: TTMColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                                focusNode: _passwordTextfiledFocusNode,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: TTMColors.secondTitleColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                  hintStyle: TextStyle(
                                      color: TTMColors.cellLineColor,
                                      fontSize: 20),
                                  // border: InputBorder.none,

                                  labelText: "密码 *",
                                  hintText: "请输入密码",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.cellLineColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.mainBlue,
                                    ),
                                  ),
                                ),
                                //   //检验密码
                                onTap: () {
                                  setState(() => _isInputting = true);
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _password = value;
                                    _passwordTextfiledFocusNode.unfocus();
                                    _confirmPasswordTextfiledFocusNode
                                        .requestFocus();
                                    _isInputting = false;
                                  });
                                },
                                onChanged: (password) {
                                  _password = password;
                                  if (!_isInputting) {
                                    setState(() => _isInputting = true);
                                  }
                                },
                              ),

                              // ConfirmPassword Text Filed
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: TTMColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                                focusNode: _confirmPasswordTextfiledFocusNode,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: TTMColors.secondTitleColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                  hintStyle: TextStyle(
                                      color: TTMColors.cellLineColor,
                                      fontSize: 20),
                                  // border: InputBorder.none,

                                  labelText: "确认密码 *",
                                  hintText: "请确认密码",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.cellLineColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: TTMColors.mainBlue,
                                    ),
                                  ),
                                ),
                                //   //检验密码
                                onTap: () {
                                  setState(() => _isInputting = true);
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _confirmPassword = value;
                                    _confirmPasswordTextfiledFocusNode
                                        .unfocus();
                                    _isInputting = false;
                                  });
                                },
                                onChanged: (confirmPassword) {
                                  _confirmPassword = confirmPassword;
                                  if (!_isInputting) {
                                    setState(() => _isInputting = true);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),

                  /// 注册按钮

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const PlatformProtocolPage()));
                        },
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 25,
                                height: 25,
                                child: Checkbox(
                                    activeColor: TTMColors.mainBlue,
                                    value: isAgree,
                                    onChanged: (value) {
                                      setState(() {
                                        isAgree = value!;
                                      });
                                    }),
                              ),
                              Container(
                                width: 5,
                              ),
                              const Text(
                                "我已同意平台协议",
                                style: TextStyle(
                                    color: TTMColors.secondTitleColor,
                                    fontFamily: null, //FontFamily.medium,
                                    fontSize: 12),
                              ),
                              const Text(
                                "点我查看具体内容",
                                style: TextStyle(
                                    color: TTMColors.mainBlue,
                                    fontFamily: null, //FontFamily.medium,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.all(
                            TTMColors.mainBlue,
                          ),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0.0),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          width: TTMSize.screenWidth - 140,
                          height: 54,
                          color: TTMColors.secondBlue,
                          padding: const EdgeInsets.all(5.0),
                          child: const Center(
                            child: Text(
                              '立即注册',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: TTMColors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var isValidate = StringUtil.isEmail(_email);
                          var isPasswordValidate =
                              StringUtil.isPassword(_password);
                          if (_email == "") {
                            FlushBarWidget.createDanger("请输入邮箱", context);
                          } else if (_name == "") {
                            FlushBarWidget.createDanger("请输入姓名", context);
                          } else if (_password == "") {
                            FlushBarWidget.createDanger("请输入密码", context);
                          } else if (_password.length < 6) {
                            FlushBarWidget.createDanger("密码长度不能小于6位", context);
                          } else if (_confirmPassword == "") {
                            FlushBarWidget.createDanger("请输入确认密码", context);
                          } else if (_password != _confirmPassword) {
                            FlushBarWidget.createDanger("密码不一致请确认", context);
                          } else if (!isValidate) {
                            FlushBarWidget.createDanger(
                                "邮箱格式出错，请重新输入", context);
                          } else if (!isPasswordValidate) {
                            FlushBarWidget.createDanger(
                                "密码不能少于8位且必须包含大小写字母和数字", context);
                          } else if (!isAgree) {
                            FlushBarWidget.createDanger("请同意平台协议", context);
                          } else {
                            model.register(_email, _name, _password,
                                _confirmPassword, context);
                          } // 注册
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.copyright_outlined,
                          size: 15,
                          color: TTMColors.copyrightTitle,
                        ),
                        Container(
                          width: 5,
                        ),
                        const Text(
                          'Copyright 畅图慧通网络货运平台',
                          style: TextStyle(
                              fontSize: 12, color: TTMColors.copyrightTitle),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
