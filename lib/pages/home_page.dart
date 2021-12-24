import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/pages/goods/goods_page.dart';
import 'package:ttm/pages/mine/profile_page.dart';
import 'package:ttm/pages/orders/orders_page.dart';
import 'package:ttm/pages/settlement/settlement_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late Widget homePageBody;
  late Widget homePageBottomNavBar;

  var isLoading = true;

  @override
  void initState() {
    model = ScopedModel.of<MainStatusModel>(context);
    model.initUserData(context).whenComplete(() {
      model.getCarTypeList();
      model.initWayBillList();
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  void buildBodys() {
    homePageBody = IndexedStack(
      children: const <Widget>[
        GoodsPage(),
        OrdersPage(),
        SettlementPage(),
        ProfilePage(),
      ],
      index: model.homePageIndex,
    );
  }

  void buildBottomNavigatorBar() {
    // 底部TabBar
    homePageBottomNavBar = Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      // 切圆角
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -10),
              blurRadius: 10.0,
              spreadRadius: -10,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0.0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: TTMColors.mainBlue,
              unselectedItemColor: TTMColors.secondTitleColor,
              selectedLabelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: TTMColors.mainBlue),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: TTMColors.secondTitleColor),
              items: [
                BottomNavigationBarItem(
                  icon: homeGood1(),
                  activeIcon: homeGood1(size: 28, color: TTMColors.mainBlue),
                  label: "货源",
                ),
                BottomNavigationBarItem(
                  icon: homeWaybill1(),
                  activeIcon: homeWaybill1(size: 30, color: TTMColors.mainBlue),
                  label: "运单",
                ),
                BottomNavigationBarItem(
                  icon: homeSettlement1(),
                  activeIcon:
                      homeSettlement1(size: 30, color: TTMColors.mainBlue),
                  label: "结算",
                ),
                BottomNavigationBarItem(
                  icon: homeMine(),
                  activeIcon: homeMine(size: 28, color: TTMColors.mainBlue),
                  label: "我的",
                ),
              ],
              onTap: (index) {
                model.setHomePageIndex(index);
              },
              currentIndex: model.homePageIndex,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    _animationController.forward();
    buildBodys();
    buildBottomNavigatorBar();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: homePageKey,
          body: ColorfulSafeArea(
            bottomColor: TTMColors.white,
            top: false,
            child: Stack(
              children: <Widget>[
                homePageBody,
                homePageBottomNavBar,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
