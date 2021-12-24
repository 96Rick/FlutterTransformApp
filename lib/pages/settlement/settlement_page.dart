import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/orders/all_confirmation_receipt_page.dart';
import 'package:ttm/pages/orders/all_evaluate_page.dart';
import 'package:ttm/pages/orders/all_waiting_accept_page.dart';
import 'package:ttm/pages/orders/all_waiting_pickup_page.dart';
import 'package:ttm/pages/orders/all_waiting_service_page.dart';
import 'package:ttm/pages/settlement/all_invoice_page.dart';
import 'package:ttm/pages/settlement/all_receivable_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class SettlementPage extends StatefulWidget {
  const SettlementPage({Key? key}) : super(key: key);

  @override
  _SettlementPageState createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final settlementPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;
  late TabController settlementTabController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    settlementTabController = TabController(length: 2, vsync: this);
    model.initInvoiceList();
    settlementTabController.addListener(() {
      if (settlementTabController.index == 0) {
        model.refreshInvoiceList(context);
      } else if (settlementTabController.index == 1) {
        model.refreshReceivableList(context);
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
        resizeToAvoidBottomInset: false,
        backgroundColor: TTMColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "结算",
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
              controller: settlementTabController,
              labelStyle: TTMTextStyle.appBottomTabBarSelectedTitle,
              unselectedLabelStyle: TTMTextStyle.appBottomTabBarUnselectedTitle,
              tabs: [
                Tab(
                  text: "   发票   ",
                ),
                Tab(
                  text: "   应收   ",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            AllInvoicePage(),
            AllReceivablePage(),
          ],
          controller: settlementTabController,
        ),
      ),
    );
  }
}
