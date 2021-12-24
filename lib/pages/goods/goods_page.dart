import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/pages/goods/all_goods_page.dart';
import 'package:ttm/pages/goods/all_intention_page.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late MainStatusModel model;
  late TabController goodsTabController;

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    goodsTabController = TabController(length: 2, vsync: this);
    // model.refreshAllIntention(context);
    // model.refreshAllGoods(context);
    goodsTabController.addListener(() {
      if (goodsTabController.index == 0) {
        model.refreshAllGoods(context);
      } else if (goodsTabController.index == 1) {
        model.refreshAllIntention(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    goodsTabController.dispose();
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
        backgroundColor: TTMColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "货源",
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
              controller: goodsTabController,
              labelStyle: TTMTextStyle.appBottomTabBarSelectedTitle,
              unselectedLabelStyle: TTMTextStyle.appBottomTabBarUnselectedTitle,
              tabs: [
                Tab(
                  text: "货源大厅",
                ),
                Tab(
                  text: "意向确认",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            AllGoodsPage(),
            AllIntentionPage(),
          ],
          controller: goodsTabController,
        ),
      ),
    );
  }
}
