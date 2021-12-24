import 'package:flutter/material.dart';

class TTMImage {
  static const String homePageBG = "assets/images/HomeBG.jpg";
  static const String avatarPlaceholder = "assets/images/AvatarPlaceholder.png";
  static const String noDataPlaceholder = "assets/images/NoData.png";

  static Widget name(String name) {
    return Image.asset(
      name,
      fit: BoxFit.fill,
      alignment: Alignment.bottomCenter,
    );
  }
}
