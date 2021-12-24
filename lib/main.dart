// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/pages/home_page.dart';
import 'package:ttm/pages/login/login_page.dart';
import 'package:ttm/pages/splash_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/utils/sp_util.dart';

void main() {
  realRunApp();
}

void realRunApp() async {
  // 如果需要在runApp前进行其他操作需要加上
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  if (Platform.isAndroid) {
    // 如果不隐藏需要单独设置
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // 底部导航栏颜色
        // systemNavigationBarColor: TTMColors.backgroundColor,
        // 状态栏颜色
        // statusBarColor: TTMColors.mainBlue,
        // 状态栏图标 白/黑
        // statusBarIconBrightness: Brightness.light,
        ));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  runApp(const TTMApp());
}

class TTMApp extends StatefulWidget {
  const TTMApp({Key? key}) : super(key: key);

  @override
  _TTMAppState createState() => _TTMAppState();
}

class _TTMAppState extends State<TTMApp> {
  final MainStatusModel model = MainStatusModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStatusModel>(
      model: model,
      child: ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CH'),
            ],
            locale: const Locale('zh'),
            debugShowCheckedModeBanner: false,
            title: "畅途慧通",
            home: model.isLoadingApp
                ? const SplashPage()
                : model.isNeedReLogin
                    ? const LoginPage()
                    // 需要改变状态的HomePage不能使用const,否则刷新状态无法实现
                    // ignore: prefer_const_constructors
                    : HomePage(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
