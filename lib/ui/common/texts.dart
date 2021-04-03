import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wireguard_flutter/ui/ui_constants.dart';

const _defaultTextColor = Colors.black;
const _defaultTextLinkColorDisabled = Colors.black54;
const _defaultTextSize = AppSize.fontRegular;
const _defaultFontWeight = FontWeight.w400;
const _defaultFont = Font.openSans;

enum Font { openSans, titillium }

class Texts extends StatelessWidget {
  //
  final String? text;
  final Color? color;
  final double? textSize;
  final bool? isCenter;
  final bool? isRight;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;
  final bool? capitalize;
  final VoidCallback? onPressed;
  final bool? isLink;
  final List<RichTextData>? richTextDatas;
  final TextDecoration? decoration;
  final bool? isBlue;
  final bool? showShadow;
  final Font? font;

  //
  const Texts(
    this.text, {
    this.color,
    this.textSize,
    this.isCenter = false,
    this.isRight = false,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.capitalize,
    this.onPressed,
    this.isLink = false,
    this.richTextDatas,
    this.decoration,
    this.isBlue = false,
    this.showShadow = false,
    this.font,
  });

  Texts.small(
    String? text, {
    FontWeight? fontWeight,
    Color? color,
    bool? isCenter = false,
    bool? isRight = false,
    double? height,
    Font? font,
  }) : this(
          text,
          textSize: AppSize.fontSmall,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
          height: height,
          font: font,
        );

  const Texts.smallVery(
    String? text, {
    FontWeight? fontWeight,
    Color? color,
    bool? isCenter = false,
    bool? isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontSmallVery,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
        );

  const Texts.big(
    String? text, {
    FontWeight? fontWeight,
    Color? color,
    bool? isCenter = false,
    bool? isRight = false,
    double? height,
  }) : this(
          text,
          textSize: AppSize.fontBig,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
          height: height,
        );

  const Texts.semiBold(
    String? text, {
    double? textSize,
    Color? color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          fontWeight: FontWeight.w600,
          textSize: textSize,
          color: color,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.bold(
    String? text, {
    double? textSize,
    Color? color,
    bool isCenter = false,
    double? height,
    Font? font,
  }) : this(
          text,
          fontWeight: FontWeight.bold,
          textSize: textSize,
          color: color,
          isCenter: isCenter,
          height: height,
          font: font,
        );

  const Texts.smallBold(
    String text, {
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          color: color,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.blue(
    String text, {
    FontWeight? fontWeight,
  }) : this(
          text,
          isBlue: true,
          fontWeight: fontWeight,
        );

  const Texts.blueBold(
    String text, {
    double? textSize,
  }) : this(
          text,
          isBlue: true,
          fontWeight: FontWeight.bold,
          textSize: textSize,
        );

  const Texts.blueSmall(
    String text, {
    FontWeight? fontWeight,
  }) : this(
          text,
          isBlue: true,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
        );

  const Texts.red(
    String text, {
    FontWeight? fontWeight,
    Font? font,
  }) : this(
          text,
          color: AppColors.red,
          fontWeight: fontWeight,
          font: font,
        );

  const Texts.green(
    String text, {
    FontWeight? fontWeight,
  }) : this(
          text,
          color: AppColors.greenLight,
          fontWeight: fontWeight,
        );

  const Texts.redNormal(
    String text, {
    FontWeight? fontWeight,
  }) : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontNormal,
          fontWeight: fontWeight,
        );

  const Texts.normal(
    String text, {
    FontWeight? fontWeight,
    Color? color,
    Font? font,
    bool isCenter = false,
  }) : this(
          text,
          color: color,
          textSize: AppSize.fontNormal,
          fontWeight: fontWeight,
          font: font,
          isCenter: isCenter,
        );

  const Texts.redSmallBold(text)
      : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontSmall,
          fontWeight: FontWeight.bold,
        );

  const Texts.redBold(text)
      : this(
          text,
          color: AppColors.red,
          fontWeight: FontWeight.bold,
        );

  const Texts.redSmall(
    String text, {
    FontWeight? fontWeight,
    bool isCenter = false,
  }) : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          isCenter: isCenter,
        );

  const Texts.greenSmall(
    String text, {
    FontWeight? fontWeight,
    bool isCenter = false,
  }) : this(
          text,
          color: AppColors.greenLight,
          textSize: AppSize.fontSmall,
          isCenter: isCenter,
          fontWeight: fontWeight,
        );

  const Texts.grey(
    String text, {
    isCenter = false,
    isRight = false,
    double? textSize,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          text,
          color: Colors.black54,
          isCenter: isCenter,
          isRight: isRight,
          textSize: textSize,
          overflow: overflow,
          fontWeight: fontWeight,
          height: height,
        );

  const Texts.greySemiBold(
    String text, {
    bool isCenter = false,
    double? textSize,
  }) : this(
          text,
          color: Colors.black54,
          isCenter: isCenter,
          fontWeight: FontWeight.w600,
          textSize: textSize,
        );

  const Texts.greyBold(
    String text, {
    bool isCenter = false,
    double? height,
  }) : this(
          text,
          color: Colors.black54,
          isCenter: isCenter,
          fontWeight: FontWeight.bold,
          height: height,
        );

  const Texts.greySmall(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          text,
          color: Colors.black54,
          textSize: AppSize.fontSmall,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: fontWeight,
          height: height,
        );

  const Texts.greyNormal(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          text,
          color: Colors.black54,
          textSize: AppSize.fontNormalBig,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: fontWeight,
          height: height,
        );

  const Texts.greySmallVery(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          text,
          color: Colors.black54,
          textSize: 10.0,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: fontWeight,
          height: height,
        );

  const Texts.greySmallBold(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight fontWeight = FontWeight.bold,
  }) : this(
          text,
          color: Colors.black54,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.link(
    String text, {
    @required VoidCallback? onPressed,
    double? textSize,
    bool isCenter = false,
    FontWeight fontWeight = FontWeight.w700,
    double? height,
  }) : this(
          text,
          fontWeight: fontWeight,
          isLink: true,
          onPressed: onPressed,
          textSize: textSize,
          isCenter: isCenter,
          height: height,
        );

  const Texts.title(
    String text, {
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontMedium,
          fontWeight: FontWeight.w600,
          isCenter: isCenter,
          isRight: isRight,
          color: Colors.white,
        );

  const Texts.subtitle(
    String text, {
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          color: Colors.black54,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.rich(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double? textSize,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
          height: height,
        );

  const Texts.richSmall(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmall,
    FontWeight? fontWeight,
    Color? color,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
          color: color,
        );

  const Texts.richSmallVery(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmallVery,
    FontWeight? fontWeight,
    Color? color,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
          color: color,
        );

  const Texts.richBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double? textSize,
    Color? color,
    double? height,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize ?? AppSize.fontRegular,
          fontWeight: FontWeight.bold,
          isCenter: isCenter,
          isRight: isRight,
          color: color,
          height: height,
        );

  const Texts.richSemiBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double? textSize,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize ?? AppSize.fontRegular,
          fontWeight: FontWeight.w600,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.richSmallBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmall,
    FontWeight fontWeight = FontWeight.bold,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
        );

  @override
  Widget build(BuildContext context) {
    var color = this.color ??
        ((isBlue ?? false) ? Theme.of(context).accentColor : _defaultTextColor);
    if (isLink ?? false) {
      color = onPressed == null
          ? _defaultTextLinkColorDisabled
          : Theme.of(context).accentColor;
    }

    if (richTextDatas != null && richTextDatas?.isNotEmpty == true) {
      return Text.rich(
        TextSpan(
          children: (richTextDatas ?? [])
              .map(
                (data) => TextSpan(
                  text: data.text,
                  style: _fontStyle(TextStyle(
                    fontSize: data.size ?? textSize ?? _defaultTextSize,
                    color: data.color ?? color,
                    fontWeight:
                        data.fontWeight ?? fontWeight ?? _defaultFontWeight,
                    height: height,
                  )),
                ),
              )
              .toList(),
        ),
        textAlign: (isCenter ?? false)
            ? TextAlign.center
            : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
      );
    }

    var style = TextStyle(
      fontSize: textSize ?? _defaultTextSize,
      color: color,
      fontWeight: fontWeight ?? _defaultFontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: (showShadow ?? false)
          ? [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 0,
                color: Color.fromARGB(60, 0, 0, 0),
              ),
            ]
          : null,
    );

    if (isLink ?? false) {
      return GestureDetector(
        child: Text.rich(
          TextSpan(
            text: capitalize == true ? text?.toUpperCase() : text,
            style: _fontStyle(style),
          ),
          textAlign: (isCenter ?? false)
              ? TextAlign.center
              : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
          overflow: overflow,
          maxLines: maxLines,
        ),
        onTap: onPressed,
      );
    }

    return Text(
      (capitalize == true ? text?.toUpperCase() : text) ?? '',
      textAlign: (isCenter ?? false)
          ? TextAlign.center
          : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
      overflow: overflow,
      maxLines: maxLines,
      style: _fontStyle(style),
    );
  }

  TextStyle _fontStyle(TextStyle style) {
    switch (font ?? _defaultFont) {
      case Font.titillium:
        return GoogleFonts.titilliumWeb(
          textStyle: style,
        );
      case Font.openSans:
      default:
        return GoogleFonts.openSans(
          textStyle: style,
        );
    }
  }
}

class RichTextData {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;

  RichTextData(
    this.text, {
    this.color = _defaultTextColor,
    this.fontWeight,
    this.size,
  });

  RichTextData.grey(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.black54;

  RichTextData.greySmall(
    this.text, {
    this.fontWeight,
  })  : color = Colors.black54,
        this.size = AppSize.fontSmall;

  RichTextData.blue(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.blue;

  RichTextData.blueSmall(
    this.text, {
    this.fontWeight,
  })  : color = Colors.blue,
        this.size = AppSize.fontSmall;

  RichTextData.greyLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.white24;

  RichTextData.green(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.green;

  RichTextData.greenLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.green.withOpacity(0.4);

  RichTextData.red(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.red;

  RichTextData.redLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.red.withOpacity(0.4);

  RichTextData.bold(
    this.text, {
    this.size,
  })  : color = _defaultTextColor,
        fontWeight = FontWeight.bold;

  RichTextData.light(
    this.text, {
    this.size,
  })  : color = _defaultTextColor,
        fontWeight = FontWeight.w300;
}
