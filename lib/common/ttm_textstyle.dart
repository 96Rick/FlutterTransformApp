import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttm/common/ttm_colors.dart';

class TTMTextStyle {
  static const TextStyle whiteAppBarTitle = TextStyle(
      color: TTMColors.white, fontSize: 35, fontWeight: FontWeight.bold);
  static const TextStyle whiteAppBarSecondTitle = TextStyle(
      color: TTMColors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle appBottomTabBarSelectedTitle = TextStyle(
      color: TTMColors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle appBottomTabBarSecondSelectedTitle = TextStyle(
      color: TTMColors.white, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle appBottomTabBarUnselectedTitle = TextStyle(
      color: TTMColors.white.withOpacity(0.7),
      fontSize: 20,
      fontWeight: FontWeight.normal);
  static TextStyle appBottomTabBarSecondUnselectedTitle = TextStyle(
      color: TTMColors.white.withOpacity(0.7),
      fontSize: 14,
      fontWeight: FontWeight.normal);
// waybill
  static const TextStyle wayBillCellDetailLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: TTMColors.secondTitleColor,
  );

  // Bottom Btn Text
  static const TextStyle bottomBtnTitle = TextStyle(
      color: TTMColors.white, fontSize: 18, fontWeight: FontWeight.bold);

  // goods

  static const TextStyle goodsFilterTitle = TextStyle(
      color: TTMColors.goodsFilterLabelColor,
      fontSize: 12,
      fontWeight: FontWeight.bold);
  static const TextStyle goodsFilterUnselectedTips = TextStyle(
      color: TTMColors.goodsFilterLabelUnselectedColor,
      fontSize: 12,
      fontWeight: FontWeight.normal);
  static const TextStyle goodsFilterSelectedTips = TextStyle(
      color: TTMColors.white, fontSize: 12, fontWeight: FontWeight.bold);

  static const TextStyle goodsCellDetailLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: TTMColors.secondTitleColor,
  );
  static const TextStyle goodsCellDetailText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: TTMColors.titleColor,
  );
  static const TextStyle goodsCellTitleLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: TTMColors.secondTitleColor,
  );
  static const TextStyle goodsCellTitleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: TTMColors.titleColor,
  );
  static const TextStyle goodsCellTitleMoneyText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: TTMColors.gold,
  );

  static const TextStyle goodsDetailPageLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: TTMColors.secondTitleColor,
  );
  static const TextStyle goodsDetailPageImportTitle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: TTMColors.titleColor);
  static const TextStyle goodsDetailPageSecondTitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: TTMColors.titleColor);
  static const TextStyle goodsDetailPageMoney = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: TTMColors.gold,
  );

// my info
  static const TextStyle secondTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: TTMColors.myInfoTitleColor,
  );

  static const TextStyle thirdTitle = TextStyle(
    fontSize: 14,
    color: TTMColors.myInfoTitleColor,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle requeirdLabel = TextStyle(
    fontSize: 14,
    color: TTMColors.dangerColor,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle textField = TextStyle(
    color: TTMColors.textFiledHintValueColor,
    fontSize: 14,
  );
  static const TextStyle textFieldHint = TextStyle(
    color: TTMColors.textFiledHintEmptyColor,
    fontSize: 14,
  );

// join fleet
  static const TextStyle joinFleetBodyPlaceholderTitle = TextStyle(
      color: TTMColors.joinFleetBodyTitle,
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static const TextStyle joinFleetBodyInputTextFildTitle = TextStyle(
      color: TTMColors.joinFleetBodyTitle,
      fontSize: 18,
      fontWeight: FontWeight.normal);
  static const TextStyle joinFleetBodySearchResultTitle = TextStyle(
      color: TTMColors.titleColor, fontSize: 14, fontWeight: FontWeight.normal);

  // all Car list
  static const TextStyle allCarListCarNumberTitle = TextStyle(
      color: TTMColors.titleColor, fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle allCarListCarStatusTitle = TextStyle(
      color: TTMColors.titleColor, fontSize: 12, fontWeight: FontWeight.normal);
  static const TextStyle allCarLiceseTypeTitle = TextStyle(
      color: TTMColors.white, fontSize: 12, fontWeight: FontWeight.normal);
  static const TextStyle allCarBelongToTitle = TextStyle(
      color: TTMColors.white, fontSize: 8, fontWeight: FontWeight.w400);
  static const TextStyle allCarBelongToValue = TextStyle(
      color: TTMColors.white, fontSize: 14, fontWeight: FontWeight.normal);

  // Contract
  static const TextStyle contractRuntimeValueTitle = TextStyle(
      color: TTMColors.titleColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
  static const TextStyle contractConstTitle = TextStyle(
      color: TTMColors.titleColor, fontSize: 14, fontWeight: FontWeight.normal);

  static const TextStyle invoiceListSecondLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: TTMColors.titleColor,
  );
}
