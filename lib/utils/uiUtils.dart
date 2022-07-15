import 'package:eschool_teacher/app/appLocalization.dart';
import 'package:eschool_teacher/cubits/downloadfileCubit.dart';
import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/data/repositories/studyMaterialRepositoy.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/downloadFileBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/widgets/errorMessageOverlayContainer.dart';
import 'package:eschool_teacher/utils/constants.dart';
import 'package:eschool_teacher/utils/errorMessageKeysAndCodes.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class UiUtils {
  //This extra padding will add to MediaQuery.of(context).padding.top in orderto give same top padding in every screen

  static double screenContentTopPadding = 15.0;
  static double screenContentHorizontalPadding = 25.0;
  static double screenTitleFontSize = 18.0;
  static double screenSubTitleFontSize = 14.0;
  static double textFieldFontSize = 15.0;

  static double screenContentHorizontalPaddingPercentage = 0.075;

  //

  static double bottomSheetButtonHeight = 45.0;
  static double bottomSheetButtonWidthPercentage = 0.625;

  static double extraScreenContentTopPaddingForScrolling = 0.0275;
  static double appBarSmallerHeightPercentage = 0.175;

  static double appBarMediumtHeightPercentage = 0.2;

  static double bottomNavigationHeightPercentage = 0.075;
  static double bottomNavigationBottomMargin = 25;

  static double bottomSheetHorizontalContentPadding = 20;

  static double subjectFirstLetterFontSize = 20;

  static double shimmerLoadingContainerDefaultHeight = 7;

  static int defaultShimmerLoadingContentCount = 4;

  static double appBarBiggerHeightPercentage = 0.25;
  static double appBarContentTopPadding = 25.0;
  static double bottomSheetTopRadius = 20.0;
  static Duration tabBackgroundContainerAnimationDuration =
      Duration(milliseconds: 300);
  static Curve tabBackgroundContainerAnimationCurve = Curves.easeInOut;

  //to give bottom scroll padding in screen where
  //bottom navigation bar is displayed
  static double getScrollViewBottomPadding(BuildContext context) {
    return MediaQuery.of(context).size.height *
            (UiUtils.bottomNavigationHeightPercentage) +
        UiUtils.bottomNavigationBottomMargin * (1.5);
  }

  static Future<dynamic> showBottomSheet(
      {required Widget child,
      required BuildContext context,
      bool? enableDrag}) async {
    final result = await showModalBottomSheet(
        enableDrag: enableDrag ?? false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bottomSheetTopRadius),
                topRight: Radius.circular(bottomSheetTopRadius))),
        context: context,
        builder: (_) => child);

    return result;
  }

  static Future<void> showErrorMessageContainer(
      {required BuildContext context,
      required String errorMessage,
      required Color backgroundColor}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => ErrorMessageOverlayContainer(
        backgroundColor: backgroundColor,
        errorMessage: errorMessage,
      ),
    );

    overlayState?.insert(overlayEntry);
    await Future.delayed(errorMessageDisplayDuration);
    overlayEntry.remove();
  }

  static String getErrorMessageFromErrorCode(
      BuildContext context, String errorCode) {
    return UiUtils.getTranslatedLabel(
        context, ErrorMessageKeysAndCode.getErrorMessageKeyFromCode(errorCode));
  }

  //to give top scroll padding to screen content
  //
  static double getScrollViewTopPadding(
      {required BuildContext context, required double appBarHeightPercentage}) {
    return MediaQuery.of(context).size.height *
        (appBarHeightPercentage + extraScreenContentTopPaddingForScrolling);
  }

  static String getImagePath(String imageName) {
    return "assets/images/$imageName";
  }

  static String getLottieAnimationPath(String animationName) {
    return "assets/animations/$animationName";
  }

  static ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  static Color getColorFromHexValue(String hexValue) {
    int color = int.parse(hexValue.replaceAll("#", "0xff").toString());
    return Color(color);
  }

  static Locale getLocaleFromLanguageCode(String languageCode) {
    List<String> result = languageCode.split("-");
    return result.length == 1
        ? Locale(result.first)
        : Locale(result.first, result.last);
  }

  static String getTranslatedLabel(BuildContext context, String labelKey) {
    return (AppLocalization.of(context)!.getTranslatedValues(labelKey) ??
            labelKey)
        .trim();
  }

  static String getMonthName(int monthNumber) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[monthNumber - 1];
  }

  static List<String> buildMonthYearsBetweenTwoDates(
      DateTime startDate, DateTime endDate) {
    List<String> dateTimes = [];
    DateTime current = startDate;
    while (current.difference(endDate).isNegative) {
      current = current.add(Duration(days: 24));
      dateTimes.add("${getMonthName(current.month)}, ${current.year}");
    }
    dateTimes = dateTimes.toSet().toList();

    return dateTimes;
  }

  static Color getClassColor(int index) {
    int colorIndex = index < myClassesColors.length
        ? index
        : (index % myClassesColors.length);

    return myClassesColors[colorIndex];
  }

  static void showFeatureDisableInDemoVersion(BuildContext context) {
    showErrorMessageContainer(
        context: context,
        errorMessage:
            UiUtils.getTranslatedLabel(context, featureDisableInDemoVersionKey),
        backgroundColor: Theme.of(context).colorScheme.error);
  }

  static bool isDemoVersionEnable() {
    //If isDemoVersion is not declarer then it return always false
    return false;
  }

  static int getStudyMaterialId(
      String studyMaterialLabel, BuildContext context) {
    if (studyMaterialLabel == getTranslatedLabel(context, fileUploadKey)) {
      return 1;
    }
    if (studyMaterialLabel == getTranslatedLabel(context, youtubeLinkKey)) {
      return 2;
    }
    if (studyMaterialLabel == getTranslatedLabel(context, videoUploadKey)) {
      return 3;
    }
    return 0;
  }

  static int getStudyMaterialIdByEnum(
      StudyMaterialType studyMaterialType, BuildContext context) {
    if (studyMaterialType == StudyMaterialType.file) {
      return 1;
    }
    if (studyMaterialType == StudyMaterialType.youtubeVideo) {
      return 2;
    }
    if (studyMaterialType == StudyMaterialType.uploadedVideoUrl) {
      return 3;
    }
    return 0;
  }

  static String getBackButtonPath(BuildContext context) {
    return Directionality.of(context).name == TextDirection.rtl.name
        ? getImagePath("rtl_back_icon.svg")
        : getImagePath("back_icon.svg");
  }

  static String getStudyMaterialTypeLabelByEnum(
      StudyMaterialType studyMaterialType, BuildContext context) {
    if (studyMaterialType == StudyMaterialType.file) {
      return UiUtils.getTranslatedLabel(context, fileUploadKey);
    }
    if (studyMaterialType == StudyMaterialType.youtubeVideo) {
      return UiUtils.getTranslatedLabel(context, youtubeLinkKey);
    }
    if (studyMaterialType == StudyMaterialType.uploadedVideoUrl) {
      return UiUtils.getTranslatedLabel(context, videoUploadKey);
    }

    return "Other";
  }

  static void openFileInBrowser(String fileUrl, BuildContext context) async {
    try {
      final canLaunch = await canLaunchUrl(Uri.parse(fileUrl));
      if (canLaunch) {
        launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
      } else {
        UiUtils.showErrorMessageContainer(
            context: context,
            errorMessage:
                UiUtils.getTranslatedLabel(context, unableToOpenFileKey),
            backgroundColor: Theme.of(context).colorScheme.error);
      }
    } catch (e) {
      UiUtils.showErrorMessageContainer(
          context: context,
          errorMessage:
              UiUtils.getTranslatedLabel(context, unableToOpenFileKey),
          backgroundColor: Theme.of(context).colorScheme.error);
    }
  }

  static void openDownloadBottomsheet(
      {required BuildContext context,
      required bool storeInExternalStorage,
      required StudyMaterial studyMaterial}) {
    showBottomSheet(
            child: BlocProvider<DownloadFileCubit>(
              create: (context) => DownloadFileCubit(StudyMaterialRepository()),
              child: DownloadFileBottomsheetContainer(
                storeInExternalStorage: storeInExternalStorage,
                studyMaterial: studyMaterial,
              ),
            ),
            context: context)
        .then((result) {
      if (result != null) {
        if (result['error']) {
          showErrorMessageContainer(
              context: context,
              errorMessage: getErrorMessageFromErrorCode(
                  context, result['message'].toString()),
              backgroundColor: Theme.of(context).colorScheme.error);
        } else {
          try {
            OpenFile.open(result['filePath'].toString());
          } catch (e) {
            showErrorMessageContainer(
                context: context,
                errorMessage: getTranslatedLabel(
                    context,
                    storeInExternalStorage
                        ? fileDownloadedSuccessfullyKey
                        : unableToOpenKey),
                backgroundColor: Theme.of(context).colorScheme.error);
          }
        }
      }
    });
  }
}
