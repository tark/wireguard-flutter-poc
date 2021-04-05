import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ui/ui_constants.dart';

import 'texts.dart';

const _defaultTextColor = Colors.white;
const _defaultTextDisabledColor = Colors.white54;
const _defaultTextSize = AppSize.fontNormal;
const _defaultButtonHeight = AppSize.buttonHeight;
const _defaultFontWeight = FontWeight.w600;
const _defaultFontWeightDisabled = FontWeight.normal;
const _defaultIconColor = Colors.white;
const _defaultIconColorRed = Colors.red;
const _defaultProgressWidth = 1.5;
const _defaultWaitDuration = Duration(seconds: 1);
const _defaultBorderWidth = 0.5;

class Buttons extends StatelessWidget {
  //
  final GlobalKey? key;
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? textDisabledColor;
  final double? margin;
  final bool wrapContent;
  final double? width;
  final double? textSize;
  final double? height;
  final bool progress;
  final bool outlined;
  final bool outlinedGrey;
  final bool transparent;
  final bool flat;
  final String? iconPath;
  final IconData? iconData;
  final FontWeight? fontWeight;
  final FontWeight? fontWeightDisabled;
  final Color? buttonColor;
  final Color? buttonDisabledColor;
  final bool iconTrailing;
  final bool isRed;
  final bool caps;
  final Color? borderColor;
  final Color? iconColor;
  final Color? progressColor;
  final double? progressWidth;
  final double? horizontalPadding;
  final double? borderRadius;
  final double? borderWidth;
  final bool showShadow;

  const Buttons({
    this.key,
    this.text,
    this.child,
    this.onPressed,
    this.textColor,
    this.textDisabledColor,
    this.margin = 0.0,
    this.wrapContent = false,
    this.width,
    this.textSize,
    this.height,
    this.progress = false,
    this.progressWidth,
    this.progressColor,
    this.outlined = false,
    this.outlinedGrey = false,
    this.transparent = false,
    this.flat = false,
    this.iconPath,
    this.iconData,
    this.fontWeight,
    this.fontWeightDisabled,
    this.buttonColor,
    this.buttonDisabledColor,
    this.iconTrailing = false,
    this.isRed = false,
    this.caps = false,
    this.borderColor,
    this.iconColor,
    this.horizontalPadding,
    this.borderRadius,
    this.borderWidth,
    this.showShadow = false,
  });

  Buttons.blue({
    key,
    text,
    onPressed,
    progress = false,
    iconData,
    double? textSize,
    bool wrapContent = false,
    double? horizontalPadding,
    double? borderRadius,
    FontWeight? fontWeight,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: Colors.blue,
          progress: progress,
          iconData: iconData,
          textSize: textSize,
          wrapContent: wrapContent,
          horizontalPadding: horizontalPadding,
          borderRadius: borderRadius,
          fontWeight: fontWeight,
        );

  const Buttons.red({
    key,
    text,
    onPressed,
    progress = false,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: AppColors.red,
          progress: progress,
          isRed: true,
        );

  const Buttons.green({
    key,
    text,
    onPressed,
    progress = false,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: AppColors.green,
          progress: progress,
        );

  const Buttons.flat({
    key,
    text,
    iconData,
    onPressed,
    progress = false,
    wrapContent = false,
    buttonColor,
    textColor,
    double? textSize,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          key: key,
          text: text,
          flat: true,
          iconData: iconData,
          onPressed: onPressed,
          buttonColor: buttonColor ?? Colors.white10,
          buttonDisabledColor: Colors.white10,
          progress: progress,
          wrapContent: wrapContent,
          textColor: textColor,
          textSize: textSize,
          fontWeight: fontWeight,
          height: height,
        );

  const Buttons.flatSmall({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
    buttonColor,
    textColor,
    fontWeight,
    iconTrailing = false,
    double? textSize,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: buttonColor ?? Colors.white10,
          height: AppSize.buttonHeightSmall,
          textColor: textColor ?? Colors.white54,
          textSize: textSize ?? AppSize.fontSmall,
          fontWeight: fontWeight ?? FontWeight.w600,
          iconTrailing: iconTrailing,
        );

  const Buttons.flatSmallRed({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: Colors.white10,
          height: AppSize.buttonHeightSmall,
          textColor: Colors.red,
          textSize: AppSize.fontSmall,
          fontWeight: FontWeight.w600,
          iconTrailing: true,
          isRed: true,
        );

  const Buttons.flatRed({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
    double? textSize,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: Colors.white10,
          height: AppSize.buttonHeightSmall,
          textColor: Colors.red,
          textSize: textSize,
          fontWeight: FontWeight.w600,
          iconTrailing: true,
          isRed: true,
        );

  Buttons.outlined({
    String? text,
    VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    bool progress = false,
    double? textSize,
    Color? buttonDisabledColor,
    Color? textDisabledColor,
    String? iconPath,
    IconData? iconData,
    bool wrapContent = false,
    double? width,
    Color? iconColor,
    double? progressWidth,
    double? height,
    FontWeight? fontWeight,
    double? borderWidth,
  }) : this(
          text: text,
          outlined: true,
          onPressed: onPressed,
          borderColor: borderColor,
          textColor: textColor,
          progress: progress,
          textSize: textSize,
          buttonDisabledColor: buttonDisabledColor,
          textDisabledColor: textDisabledColor,
          iconData: iconData,
          wrapContent: wrapContent,
          width: width,
          iconColor: iconColor,
          progressWidth: progressWidth,
          height: height,
          fontWeight: fontWeight,
          borderWidth: borderWidth,
        );

  Buttons.outlinedGrey({
    String? text,
    VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    bool progress = false,
    double? textSize,
    Color? buttonDisabledColor,
    Color? textDisabledColor,
    String? iconPath,
    IconData? iconData,
    bool wrapContent = false,
    double? width,
    Color? iconColor,
    double? progressWidth,
    double? height,
  }) : this(
          text: text,
          outlinedGrey: true,
          onPressed: onPressed,
          borderColor: borderColor,
          textColor: textColor,
          progress: progress,
          textSize: textSize,
          buttonDisabledColor: buttonDisabledColor,
          textDisabledColor: textDisabledColor,
          iconData: iconData,
          wrapContent: wrapContent,
          width: width,
          iconColor: iconColor,
          progressWidth: progressWidth,
          borderRadius: AppSize.borderRadiusSmall,
          height: height,
        );

  Buttons.transparent({
    String? text,
    VoidCallback? onPressed,
    bool caps = false,
    double? textSize,
    FontWeight? fontWeight,
    Color? textColor,
  }) : this(
          text: text,
          transparent: true,
          caps: caps,
          onPressed: onPressed,
          textSize: textSize,
          fontWeight: fontWeight,
          textColor: textColor,
        );

  Buttons.form({
    String? text,
    double textSize = 16,
    IconData? iconData,
    bool enabled = true,
    bool progress = false,
    VoidCallback? onPressed,
  }) : this(
          text: text,
          textSize: AppSize.fontNormal,
          iconData: iconData,
          iconTrailing: true,
          iconColor: enabled ? Colors.white54 : Color(0xFF303747),
          buttonColor: Colors.blue,
          buttonDisabledColor: progress ? Colors.blue : Color(0xFF4A5469),
          textDisabledColor: progress ? Colors.white54 : Color(0xFF303747),
          caps: false,
          progress: progress,
          onPressed: enabled ? onPressed : null,
        );

  @override
  Widget build(BuildContext context) {
    if (wrapContent == true && width != null) {
      throw new Exception("if width != null, then wrapContent should be false");
    }

    double minWidth;
    if (wrapContent) {
      minWidth = 0.0;
    } else if (width != null) {
      minWidth = width ?? 0;
    } else {
      minWidth = AppSize.buttonWidth;
    }

    var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSize.borderRadius),
    );
    var child = this.child ?? _content();

    var button;

    if (outlined) {
      button = StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled = false;
          // TODO: change to new [OutlinedButton]
          return OutlineButton(
            padding: horizontalPadding != null
                ? AppPadding.horizontal(horizontalPadding ?? 0)
                : AppPadding.allZero,
            key: key,
            borderSide: BorderSide(
              width: borderWidth ?? _defaultBorderWidth,
              color: borderColor ?? Colors.blue,
              style: BorderStyle.solid,
            ),
            disabledBorderColor: buttonDisabledColor ?? Colors.blue,
            color: buttonColor ?? Theme.of(context).accentColor,
            shape: shape,
            onPressed: onPressed == null
                ? null
                : () async {
                    if (!isEnabled) {
                      isEnabled = true;
                      onPressed?.call();
                      await Future.delayed(_defaultWaitDuration);
                      isEnabled = false;
                    }
                  },
            child: child,
          );
        },
      );
    } else if (outlinedGrey) {
      button = StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled = false;
          // Set height throw the ButtonTheme doesn't work for new [OutlinedButton]
          // for some reason. TODO: research why
          return SizedBox(
            height: height ?? _defaultButtonHeight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: shape,
                side: BorderSide(
                  width: 0.4,
                  color: onPressed == null
                      ? (buttonDisabledColor ?? Colors.white24)
                      : (borderColor ?? Colors.white54),
                  style: BorderStyle.solid,
                ),
                padding: horizontalPadding != null
                    ? AppPadding.horizontal(horizontalPadding ?? 0)
                    : AppPadding.allZero,
                backgroundColor: buttonColor ?? Colors.white10,
              ),
              key: key,
              onPressed: onPressed == null
                  ? null
                  : () async {
                      if (!isEnabled) {
                        isEnabled = true;
                        onPressed?.call();
                        await Future.delayed(_defaultWaitDuration);
                        isEnabled = false;
                      }
                    },
              child: child,
            ),
          );
        },
      );
    } else if (flat) {
      button = StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled = false;
          return FlatButton(
            padding: horizontalPadding != null
                ? AppPadding.horizontal(horizontalPadding ?? 0)
                : AppPadding.allZero,
            key: key,
            disabledColor: buttonDisabledColor ?? Colors.blue,
            color: buttonColor ?? Theme.of(context).accentColor,
            shape: shape,
            onPressed: onPressed == null
                ? null
                : () async {
                    if (!isEnabled) {
                      isEnabled = true;
                      onPressed?.call();
                      await Future.delayed(_defaultWaitDuration);
                      isEnabled = false;
                    }
                  },
            child: child,
          );
        },
      );
    } else if (transparent) {
      button = StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled = false;
          return FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: horizontalPadding != null
                ? AppPadding.horizontal(horizontalPadding ?? 0)
                : AppPadding.allZero,
            key: key,
            disabledColor: buttonDisabledColor ?? Colors.blue,
            color: Colors.transparent,
            shape: shape,
            onPressed: onPressed == null
                ? null
                : () async {
                    if (!isEnabled) {
                      isEnabled = true;
                      onPressed?.call();
                      await Future.delayed(_defaultWaitDuration);
                      isEnabled = false;
                    }
                  },
            child: child,
          );
        },
      );
    } else {
      button = StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled = false;
          return RaisedButton(
            padding: horizontalPadding != null
                ? AppPadding.horizontal(horizontalPadding ?? 0)
                : AppPadding.allZero,
            key: key,
            disabledColor: buttonDisabledColor ?? Colors.blue,
            color: buttonColor ?? Theme.of(context).accentColor,
            shape: shape,
            onPressed: onPressed == null
                ? null
                : () async {
                    if (!isEnabled) {
                      isEnabled = true;
                      onPressed?.call();
                      await Future.delayed(_defaultWaitDuration);
                      isEnabled = false;
                    }
                  },
            child: child,
          );
        },
      );
    }

    return ButtonTheme(
      minWidth: minWidth,
      height: height ?? _defaultButtonHeight,
      child: button,
    );
  }

  //
  Widget _content() {
    List<Widget> widgets;
    var color = onPressed == null
        ? textDisabledColor ?? _defaultTextDisabledColor
        : textColor ?? _defaultTextColor;

    if (progress) {
      widgets = [
        SizedBox(
          width: 16.0,
          height: 16.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: progressWidth ?? _defaultProgressWidth,
          ),
        )
      ];
    } else {
      var iconColor;
      if (this.iconColor != null) {
        iconColor = this.iconColor;
      } else if (isRed && flat) {
        iconColor = _defaultIconColorRed;
      } else {
        iconColor = _defaultIconColor;
      }
      var iconByPath = (iconPath != null)
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Image(
                image: AssetImage(iconPath ?? ''),
                width: 16.0,
                height: 16.0,
                color: iconColor,
              ),
            )
          : null;

      var iconByData = (iconData != null)
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Icon(
                iconData,
                size: 16.0,
                color: iconColor,
              ),
            )
          : null;

      widgets = [
        if (iconPath != null && !iconTrailing && iconByPath != null) iconByPath,
        if (iconData != null && !iconTrailing && iconByData != null) iconByData,
        if (text != null)
          Texts(
            caps ? text?.toUpperCase() : text,
            color: color,
            textSize: textSize ?? _defaultTextSize,
            fontWeight: onPressed == null
                ? fontWeightDisabled ?? _defaultFontWeightDisabled
                : fontWeight ?? _defaultFontWeight,
            showShadow: showShadow,
          ),
        if (iconData != null && iconTrailing && iconByData != null) iconByData,
        if (iconPath != null && iconTrailing && iconByPath != null) iconByPath,
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
