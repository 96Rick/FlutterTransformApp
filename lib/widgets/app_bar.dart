import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';

class TTMAppBar extends StatelessWidget {
  TTMAppBar({
    Key? key,
    required String title,
    required Color bgColor,
    required Color titleColor,
    Color? iconColor,
  })  : _title = title,
        _bgColor = bgColor,
        _titleColor = titleColor,
        _iconColor = iconColor,
        super(key: key);

  final String _title;
  final Color _bgColor;
  final Color _titleColor;
  Color? _iconColor = TTMColors.titleColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      width: TTMSize.screenWidth,
      height: 122,
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 30,
            child: Text(
              _title,
              style: TextStyle(
                  color: _titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 14,
            left: 30,
            width: 35,
            height: 35,
            child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                alignment: Alignment.centerLeft,
                icon: commonBack2(
                    size: 20, color: _iconColor ?? TTMColors.titleColor)),
          )
        ],
      ),
    );
  }
}
