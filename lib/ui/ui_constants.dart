import 'package:flutter/material.dart';

class AppImages {
  static const images = 'assets/images';
}

class AppColors {
  static const red = Colors.red;
  static const red50 = Colors.red;
  static const green = Colors.green;
  static const greenLight = Colors.greenAccent;
}

class AppSize {
  static const fontMicro = 8.0;
  static const fontSmallVery = 10.0;
  static const fontSmall = 12.0;
  static const fontRegular = 14.0;
  static const fontNormal = 16.0;
  static const fontNormalBig = 18.0;
  static const fontMedium = 20.0;
  static const fontBig = 24.0;
  static const fontBigExtra = 30.0;
  static const fontHuge = 36.0;

  static const paddingMinimum = 1.0;
  static const paddingMicro = 4.0;
  static const paddingSmall = 8.0;
  static const paddingMedium = 12.0;
  static const paddingNormal = 16.0;
  static const paddingBig = 24.0;
  static const paddingBigExtra = 30.0;
  static const paddingHuge = 36.0;

  static const buttonHeight = 48.0;
  static const buttonHeightSmall = 30.0;
  static const buttonWidth = 180.0;

  static const borderRadius = 6.0;
  static const borderRadiusBig = 12.0;
  static const borderRadiusSmall = 4.0;                         
}

class Vertical extends Padding {
  const Vertical.micro() : super(padding: AppPadding.topMicro);

  const Vertical.small() : super(padding: AppPadding.topSmall);

  const Vertical.medium() : super(padding: AppPadding.topMedium);

  const Vertical.normal() : super(padding: AppPadding.topNormal);

  const Vertical.big() : super(padding: AppPadding.topBig);

  const Vertical.bigExtra() : super(padding: AppPadding.topBigExtra);

  const Vertical.huge() : super(padding: AppPadding.topHuge);
}

class Horizontal extends Padding {
  const Horizontal.micro() : super(padding: AppPadding.rightMicro);

  const Horizontal.small() : super(padding: AppPadding.rightSmall);

  const Horizontal.medium() : super(padding: AppPadding.rightMedium);

  const Horizontal.normal() : super(padding: AppPadding.rightNormal);

  const Horizontal.big() : super(padding: AppPadding.rightBig);

  const Horizontal.huge() : super(padding: AppPadding.rightHuge);
}

class AppPadding extends EdgeInsets {
  ///
  static const _minimum = AppSize.paddingMinimum;
  static const _micro = AppSize.paddingMicro;
  static const _small = AppSize.paddingSmall;
  static const _normal = AppSize.paddingNormal;
  static const _medium = AppSize.paddingMedium;
  static const _big = AppSize.paddingBig;
  static const _bigExtra = AppSize.paddingBigExtra;
  static const _huge = AppSize.paddingHuge;

  // all
  static const allZero = const EdgeInsets.all(0.0);
  static const allMinimum = const EdgeInsets.only(top: _minimum);
  static const allMicro = const EdgeInsets.all(_micro);
  static const allSmall = const EdgeInsets.all(_small);
  static const allMedium = const EdgeInsets.all(_medium);
  static const allNormal = const EdgeInsets.all(_normal);
  static const allBig = const EdgeInsets.all(_big);
  static const allBigExtra = const EdgeInsets.all(_bigExtra);
  static const allHuge = const EdgeInsets.all(_huge);

  // bottom
  static const bottomMini = const EdgeInsets.only(top: _minimum);
  static const bottomMicro = const EdgeInsets.only(bottom: _micro);
  static const bottomSmall = const EdgeInsets.only(bottom: _small);
  static const bottomNormal = const EdgeInsets.only(bottom: _normal);
  static const bottomMedium = const EdgeInsets.only(bottom: _medium);
  static const bottomBig = const EdgeInsets.only(bottom: _big);
  static const bottomHuge = const EdgeInsets.only(bottom: _huge);

  // bottom left
  static const bottomLeftNormal =
      const EdgeInsets.only(bottom: _normal, left: _normal);

  // bottom right
  static const bottomRightBig =
      const EdgeInsets.only(bottom: _big, right: _big);
  static const bottomRightNormal = const EdgeInsets.only(
    bottom: _normal,
    right: _normal,
  );

  // left
  static const leftMicro = const EdgeInsets.only(left: _micro);
  static const leftSmall = const EdgeInsets.only(left: _small);
  static const leftNormal = const EdgeInsets.only(left: _normal);
  static const leftMedium = const EdgeInsets.only(left: _medium);
  static const leftBig = const EdgeInsets.only(left: _big);
  static const leftHuge = const EdgeInsets.only(left: _huge);

  // top
  static const topMinimum = const EdgeInsets.only(top: _minimum);
  static const topMicro = const EdgeInsets.only(top: _micro);
  static const topSmall = const EdgeInsets.only(top: _small);
  static const topMedium = const EdgeInsets.only(top: _medium);
  static const topNormal = const EdgeInsets.only(top: _normal);
  static const topBig = const EdgeInsets.only(top: _big);
  static const topBigExtra = const EdgeInsets.only(top: _bigExtra);
  static const topHuge = const EdgeInsets.only(top: _huge);

  // right
  static const rightMinimum = const EdgeInsets.only(top: _minimum);
  static const rightMicro = const EdgeInsets.only(right: _micro);
  static const rightSmall = const EdgeInsets.only(right: _small);
  static const rightMedium = const EdgeInsets.only(right: _medium);
  static const rightNormal = const EdgeInsets.only(right: _normal);
  static const rightBig = const EdgeInsets.only(right: _big);
  static const rightHuge = const EdgeInsets.only(right: _huge);

  // horizontal
  static const horizontalMinimum = const EdgeInsets.only(top: _minimum);
  static const horizontalMicro = const EdgeInsets.symmetric(horizontal: _micro);
  static const horizontalSmall = const EdgeInsets.symmetric(horizontal: _small);
  static const horizontalMedium =
      const EdgeInsets.symmetric(horizontal: _medium);
  static const horizontalNormal =
      const EdgeInsets.symmetric(horizontal: _normal);
  static const horizontalBig = const EdgeInsets.symmetric(horizontal: _big);
  static const horizontalBigExtra =
      const EdgeInsets.symmetric(horizontal: _bigExtra);

  static const horizontalHuge = const EdgeInsets.symmetric(horizontal: _huge);

  // vertical
  static const verticalMinimum = const EdgeInsets.only(top: _minimum);
  static const verticalMicro = const EdgeInsets.symmetric(vertical: _micro);
  static const verticalSmall = const EdgeInsets.symmetric(vertical: _small);
  static const verticalMedium = const EdgeInsets.symmetric(vertical: _medium);
  static const verticalNormal = const EdgeInsets.symmetric(vertical: _normal);
  static const verticalBig = const EdgeInsets.symmetric(vertical: _big);
  static const verticalHuge = const EdgeInsets.symmetric(vertical: _huge);

  // except
  static const exceptRightBig = const AppPadding.exceptRight(_big);
  static const exceptRightNormal = const AppPadding.exceptRight(_normal);
  static const exceptRightSmall = const AppPadding.exceptRight(_small);

  static const exceptBottomMicro = const AppPadding.exceptBottom(_micro);
  static const exceptBottomSmall = const AppPadding.exceptBottom(_small);
  static const exceptBottomNormal = const AppPadding.exceptBottom(_normal);
  static const exceptBottomMedium = const AppPadding.exceptBottom(_medium);
  static const exceptBottomBig = const AppPadding.exceptBottom(_big);
  static const exceptBottomHuge = const AppPadding.exceptBottom(_huge);

  static const exceptTopNormal = const AppPadding.exceptTop(_normal);
  static const exceptTopMedium = const AppPadding.exceptTop(_medium);
  static const exceptTopSmall = const AppPadding.exceptTop(_small);
  static const exceptTopMicro = const AppPadding.exceptTop(_micro);
  static const exceptTopBig = const AppPadding.exceptTop(_big);

  ///
  const AppPadding.bottom(double value) : super.only(bottom: value);

  const AppPadding.top(double value) : super.only(top: value);

  const AppPadding.right(double value) : super.only(right: value);

  const AppPadding.left(double value) : super.only(left: value);

  const AppPadding.all(double value) : super.all(value);

  const AppPadding.horizontal(double value)
      : super.symmetric(horizontal: value);

  const AppPadding.vertical(double value) : super.symmetric(vertical: value);

  const AppPadding.exceptRight(double value)
      : super.fromLTRB(value, value, 0.0, value);

  const AppPadding.exceptLeft(double value)
      : super.fromLTRB(0.0, value, value, value);

  const AppPadding.exceptTop(double value)
      : super.fromLTRB(value, 0.0, value, value);

  const AppPadding.exceptBottom(double value)
      : super.fromLTRB(value, value, value, 0.0);
}
