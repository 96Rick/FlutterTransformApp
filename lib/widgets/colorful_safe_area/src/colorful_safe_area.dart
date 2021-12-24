library colorful_safe_area;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ttm/widgets/colorful_safe_area/src/overflow_rules.dart';

class ColorfulSafeArea extends StatelessWidget {
  const ColorfulSafeArea({
    Key? key,
    this.topColor = Colors.transparent,
    this.bottomColor = Colors.transparent,
    this.leftColor = Colors.transparent,
    this.rightColor = Colors.transparent,
    this.overflowRules = const OverflowRules.all(false),
    this.overflowTappable = false,
    this.bottom = true,
    this.left = true,
    this.top = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    this.filter,
    required this.child,
  }) : super(key: key);

  final Color topColor;
  final Color bottomColor;
  final Color leftColor;
  final Color rightColor;
  final OverflowRules overflowRules;
  final bool overflowTappable;

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;
  final Widget child;
  final ImageFilter? filter;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = _createAdjustedPadding(data);
    EdgeInsets adjustedMinimum = _createAdjustedMinimum();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            SafeArea(
              left: !overflowRules.left && left,
              top: !overflowRules.top && top,
              right: !overflowRules.right && right,
              bottom: !overflowRules.bottom && bottom,
              minimum: adjustedMinimum,
              maintainBottomViewPadding: maintainBottomViewPadding,
              child: child,
            ),
            _TopAndBottom(
              topColor: topColor,
              bottomColor: bottomColor,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
              filter: filter,
            ),
            _LeftAndRight(
              leftColor: leftColor,
              rightColor: rightColor,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
              filter: filter,
            ),
          ],
        );
      },
    );
  }

  // calculates the padding required
  EdgeInsets _createAdjustedPadding(MediaQueryData data) {
    return EdgeInsets.only(
      left: (left) ? max(data.padding.left, minimum.left) : minimum.left,
      top: (top) ? max(data.padding.top, minimum.top) : minimum.top,
      right: (right) ? max(data.padding.right, minimum.right) : minimum.right,
      bottom:
          (bottom) ? max(data.padding.bottom, minimum.bottom) : minimum.bottom,
    );
  }

  // ignores the minimum for a side if it is allowed to overflow
  EdgeInsets _createAdjustedMinimum() {
    return minimum.copyWith(
      left: overflowRules.left ? 0 : minimum.left,
      top: overflowRules.top ? 0 : minimum.top,
      right: overflowRules.right ? 0 : minimum.right,
      bottom: overflowRules.bottom ? 0 : minimum.bottom,
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  const _TopAndBottom({
    Key? key,
    required this.topColor,
    required this.bottomColor,
    required this.padding,
    required this.overflowTappable,
    required this.constraints,
    this.filter,
  }) : super(key: key);

  final Color topColor;
  final Color bottomColor;
  final EdgeInsets padding;
  final bool overflowTappable;
  final BoxConstraints constraints;
  final ImageFilter? filter;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
      child: Column(
        children: <Widget>[
          (filter != null)
              ? ClipRect(
                  child: BackdropFilter(
                    filter: filter!,
                    child: Container(
                      height: padding.top,
                      width: constraints.maxWidth,
                      color: topColor,
                    ),
                  ),
                )
              : Container(
                  height: padding.top,
                  width: constraints.maxWidth,
                  color: topColor,
                ),
          Spacer(),
          (filter != null)
              ? ClipRect(
                  child: BackdropFilter(
                    filter: filter!,
                    child: Container(
                      height: padding.bottom,
                      width: constraints.maxWidth,
                      color: bottomColor,
                    ),
                  ),
                )
              : Container(
                  height: padding.bottom,
                  width: constraints.maxWidth,
                  color: bottomColor,
                ),
        ],
      ),
    );
  }
}

class _LeftAndRight extends StatelessWidget {
  const _LeftAndRight({
    Key? key,
    required this.leftColor,
    required this.rightColor,
    required this.padding,
    required this.overflowTappable,
    required this.constraints,
    this.filter,
  }) : super(key: key);

  final Color leftColor;
  final Color rightColor;
  final EdgeInsets padding;
  final bool overflowTappable;
  final BoxConstraints constraints;
  final ImageFilter? filter;

  double get _sideHeight =>
      constraints.maxHeight - padding.top - padding.bottom;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              (filter != null)
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: filter!,
                        child: Container(
                          width: padding.left,
                          height: _sideHeight,
                          color: leftColor,
                        ),
                      ),
                    )
                  : Container(
                      width: padding.left,
                      height: _sideHeight,
                      color: leftColor,
                    ),
            ],
          ),
          Spacer(),
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              (filter != null)
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: filter!,
                        child: Container(
                          width: padding.right,
                          height: _sideHeight,
                          color: rightColor,
                        ),
                      ),
                    )
                  : Container(
                      width: padding.right,
                      height: _sideHeight,
                      color: rightColor,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
