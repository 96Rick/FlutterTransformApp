import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_image.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/pages/login/register_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/flush_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  final _loginPageKey = GlobalKey<ScaffoldState>();
  final FocusNode _userNameTextfiledFocusNode = FocusNode();
  final FocusNode _passwordTextfiledFocusNode = FocusNode();

  late AnimationController _formPositionController;
  late AnimationController _titlePositionController;

  late MainStatusModel _model;
  late String _username = "";
  late String _password = "";
  late bool _isInputting = false;
  late bool _isRem;

  @override
  void initState() {
    _model = ScopedModel.of<MainStatusModel>(context);
    _formPositionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _titlePositionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _isInputting = false;
    _isRem = _model.isRememberMe;
    _username = _model.savedUserName;

    _userNameTextfiledFocusNode.addListener(() {
      if (_isInputting) {
        _formPositionController.forward();
        _titlePositionController.forward();
      } else {
        _formPositionController.reverse();
        _titlePositionController.reverse();
      }
    });
    _passwordTextfiledFocusNode.addListener(() {
      if (_isInputting) {
        _formPositionController.forward();
        _titlePositionController.forward();
      } else {
        _formPositionController.reverse();
        _titlePositionController.reverse();
      }
    });
    super.initState();
  }

  void _tapBlankSpace() {
    setState(() {
      _isInputting = false;
    });

    _userNameTextfiledFocusNode.unfocus();
    _passwordTextfiledFocusNode.unfocus();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ?????? ScopedModelDescendant ????????? statusModel ?????????, <MainStatusModel> ???????????? ??????model ????????? ???app ??????????????????????????????MainStatusModel
    return ScopedModelDescendant<MainStatusModel>(
        // model ???????????????????????? MainStatusModel?????? model ???????????? status ???????????? ??????Model?????????????????? builder ??? ????????????
        builder: (context, child, model) {
      return WillPopScope(
        // ???????????????????????????????????????
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: _tapBlankSpace,
          child: Scaffold(
            // key ?????????????????????????????????????????????????????????
            key: _loginPageKey,
            backgroundColor: TTMColors.backgroundColor,
            resizeToAvoidBottomInset: false,
            // AnnotatedRegion ???????????? ?????? ????????????????????????????????????????????????????????? AnnotatedRegion ??????????????????????????????????????????
            body: AnnotatedRegion(
              value: SystemUiOverlayStyle.light,
              child: SafeArea(
                top: false,
                bottom: false,
                child: Stack(
                  children: [
                    PositionedTransition(
                      rect: RelativeRectTween(
                              begin: RelativeRect.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  TTMSize.screenHeight -
                                      TTMSize.screenHeight / 3.5),
                              end: RelativeRect.fromLTRB(
                                  0,
                                  -100,
                                  0,
                                  TTMSize.screenHeight -
                                      TTMSize.screenHeight / 3.5 +
                                      100))
                          .chain(CurveTween(curve: Curves.easeOutCubic))
                          .animate(_titlePositionController),
                      child: SizedBox(
                        width: TTMSize.screenWidth,
                        height: TTMSize.screenHeight / 3.5,
                        child: Container(
                          child: TTMImage.name(TTMImage.homePageBG),
                          color: TTMColors.mainBlue,
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                              begin: RelativeRect.fromLTRB(
                                  40,
                                  0,
                                  40,
                                  TTMSize.screenHeight -
                                      TTMSize.screenHeight / 3.5),
                              end: RelativeRect.fromLTRB(
                                  40,
                                  -100,
                                  40,
                                  TTMSize.screenHeight -
                                      TTMSize.screenHeight / 3.5 +
                                      100))
                          .chain(CurveTween(curve: Curves.easeOutCubic))
                          .animate(_titlePositionController),
                      child: SizedBox(
                        width: TTMSize.screenWidth,
                        height: TTMSize.screenHeight / 3.5,
                        child: const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "??????",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                              begin: RelativeRect.fromLTRB(
                                  20, TTMSize.screenHeight / 3.5, 20, 0),
                              end: RelativeRect.fromLTRB(
                                  20, TTMSize.screenHeight / 3.5 - 100, 20, 0))
                          .chain(CurveTween(curve: Curves.easeOutCubic))
                          .animate(_formPositionController),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            //??????globalKey?????????????????????FormState
                            autovalidateMode: AutovalidateMode.disabled,
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  cursorWidth: 3.0,
                                  cursorColor: TTMColors.mainBlue,
                                  cursorRadius: const Radius.circular(100),
                                  focusNode: _userNameTextfiledFocusNode,
                                  initialValue: model.savedUserName,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: TTMColors.textFiledBackground,
                                    hintText: "?????????????????????",
                                    hintStyle:
                                        _userNameTextfiledFocusNode.hasFocus
                                            ? const TextStyle(
                                                color: TTMColors.mainBlue,
                                                fontSize: 16,
                                              )
                                            : const TextStyle(
                                                color: TTMColors
                                                    .textFiledHintEmptyColor,
                                                fontSize: 16,
                                              ),
                                    prefixIcon: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        width: 30,
                                        alignment: Alignment.centerLeft,
                                        child: loginEmail(
                                          color: _userNameTextfiledFocusNode
                                                  .hasFocus
                                              ? TTMColors.mainBlue
                                              : TTMColors
                                                  .textFiledHintValueColor,
                                          size: 20,
                                        )),
                                  ),
                                  style: _userNameTextfiledFocusNode.hasFocus
                                      ? const TextStyle(
                                          fontSize: 20.0,
                                          color: TTMColors.mainBlue)
                                      : const TextStyle(
                                          fontSize: 20.0,
                                          color: TTMColors
                                              .textFiledHintValueColor),
                                  onTap: () {
                                    _userNameTextfiledFocusNode.requestFocus();
                                    if (!_isInputting) {
                                      setState(() => _isInputting = true);
                                    }
                                  },
                                  onChanged: (value) {
                                    if (!_isInputting) {
                                      setState(() => _isInputting = true);
                                    }
                                    _username = value;
                                  },
                                  // ??????????????????
                                  onFieldSubmitted: (value) {
                                    _username = value;
                                    setState(() {
                                      _userNameTextfiledFocusNode.unfocus();
                                      _passwordTextfiledFocusNode
                                          .requestFocus();
                                    });
                                  },
                                ),
                                Container(
                                  height: 20,
                                ),
                                TextFormField(
                                  cursorWidth: 3.0,
                                  cursorColor: TTMColors.mainBlue,
                                  cursorRadius: const Radius.circular(100),
                                  focusNode: _passwordTextfiledFocusNode,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: TTMColors.textFiledBackground,
                                    hintText: ' ???????????????',
                                    hintStyle:
                                        _passwordTextfiledFocusNode.hasFocus
                                            ? const TextStyle(
                                                color: TTMColors.mainBlue,
                                                fontSize: 16,
                                              )
                                            : const TextStyle(
                                                color: TTMColors
                                                    .textFiledHintEmptyColor,
                                                fontSize: 16,
                                              ),
                                    prefixIcon: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        width: 30,
                                        alignment: Alignment.centerLeft,
                                        child: loginPassword(
                                          size: 28,
                                          color: _passwordTextfiledFocusNode
                                                  .hasFocus
                                              ? TTMColors.mainBlue
                                              : TTMColors
                                                  .textFiledHintValueColor,
                                        )),
                                  ),
                                  //???????????????
                                  obscureText: true,
                                  style: _passwordTextfiledFocusNode.hasFocus
                                      ? const TextStyle(
                                          fontSize: 20.0,
                                          color: TTMColors.mainBlue)
                                      : const TextStyle(
                                          fontSize: 20.0,
                                          color: TTMColors
                                              .textFiledHintValueColor),
                                  //????????????
                                  onTap: () {
                                    _passwordTextfiledFocusNode.requestFocus();
                                    setState(() => _isInputting = true);
                                  },
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      _password = value;
                                      _userNameTextfiledFocusNode.unfocus();
                                      _passwordTextfiledFocusNode.unfocus();
                                      _isInputting = false;
                                    });
                                  },
                                  onChanged: (password) {
                                    _password = password;
                                    setState(() => _isInputting = true);
                                  },
                                ),
                                Container(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "???????????????",
                                        style: TextStyle(
                                            color: TTMColors.secondTitleColor,
                                            fontFamily:
                                                null, //FontFamily.medium,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        width: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                            activeColor: TTMColors.mainBlue,
                                            value: _isRem,
                                            onChanged: (value) {
                                              if (!value!) {
                                                model.setIsRememberMe(false);
                                                model.setSavedUserName("");
                                              }
                                              setState(() {
                                                _isRem = value;
                                              });
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),

                                /// ????????????

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
                                    color: TTMColors.mainBlue,
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text(
                                            '??????',
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: TTMColors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          loginLogin(
                                              size: 25, color: TTMColors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_username == "" || _password == "") {
                                      FlushBarWidget.createDanger(
                                          "???????????????????????????", context);
                                    } else if (!_username.contains("@") ||
                                        !_username.contains(".")) {
                                      FlushBarWidget.createDanger(
                                          "???????????????????????????????????????????????????`@`???`.`", context);
                                    } else {
                                      // ???????????????????????????
                                      _isRem
                                          ? model.setIsRememberMe(true)
                                          : model.setIsRememberMe(false);
                                      _isRem && _username != ""
                                          ? model.setSavedUserName(_username)
                                          : null;
                                      // ??????????????????
                                      _tapBlankSpace();
                                      model.login(
                                          _username, _password, context);
                                    }
                                  },
                                ),

                                Container(
                                  height: 15,
                                ),

                                /// ????????????

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
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '??????',
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: TTMColors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          loginRegister(
                                              size: 25, color: TTMColors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // ??????
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 30,
                      child: Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonWarning(
                                  size: 12,
                                  color: TTMColors.warning,
                                ),
                                Container(
                                  width: 5,
                                ),
                                const Text(
                                  "?????????????????????:",
                                  style: TextStyle(
                                    color: TTMColors.warning,
                                    fontSize: 12,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    const url = TTMConstants.warningUrl;
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                        forceWebView: false,
                                        headers: <String, String>{
                                          'my_header_key': 'my_header_value'
                                        },
                                      );
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: const Text(
                                    "????????????????????????????????????",
                                    style: TextStyle(
                                      color: TTMColors.link,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
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
                                  'Copyright ??????????????????????????????',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: TTMColors.copyrightTitle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
