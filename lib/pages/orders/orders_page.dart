import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/orders/all_confirmation_receipt_page.dart';
import 'package:ttm/pages/orders/all_evaluate_page.dart';
import 'package:ttm/pages/orders/all_waiting_accept_page.dart';
import 'package:ttm/pages/orders/all_waiting_pickup_page.dart';
import 'package:ttm/pages/orders/all_waiting_service_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final orderPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late TabController orderTabController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    orderTabController = TabController(length: 5, vsync: this);
    orderTabController.addListener(() {
      if (orderTabController.index != currentIndex) {
        model.refreshWayBillList(context).then((value) {
          currentIndex = orderTabController.index;
        });
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  // 保持tab页面状态
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      topColor: TTMColors.mainBlue,
      bottomColor: TTMColors.backgroundColor,
      child: Scaffold(
        key: orderPageKey,
        backgroundColor: TTMColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "运单",
            style: TTMTextStyle.whiteAppBarTitle,
          ),
          titleSpacing: 30.0,
          centerTitle: false,
          toolbarHeight: 60,
          backgroundColor: TTMColors.mainBlue,
          elevation: 0,
          bottom: TabBar(
              indicatorColor: TTMColors.white,
              indicatorSize: TabBarIndicatorSize.label,
              controller: orderTabController,
              isScrollable: true,
              labelStyle: TTMTextStyle.appBottomTabBarSelectedTitle,
              unselectedLabelStyle: TTMTextStyle.appBottomTabBarUnselectedTitle,
              tabs: [
                Tab(
                  text: "待接单",
                ),
                Tab(
                  text: "待提货",
                ),
                Tab(
                  text: "待送达",
                ),
                Tab(
                  text: "回单确认",
                ),
                Tab(
                  text: "评价",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            AllWaitingAcceptPage(),
            AllWaitingPickUpPage(),
            AllWaitingServicePage(),
            AllConfirmationReceiptPage(),
            AllEvaluatePage(),
          ],
          controller: orderTabController,
        ),
      ),
    );
  }
}
