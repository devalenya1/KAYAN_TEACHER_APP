import 'package:eschool_teacher/cubits/downloadfileCubit.dart';
import 'package:flutter/material.dart';

import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/ui/widgets/customCloseButton.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Add View File Feature
//add download file function direct in initstate
//it will be in use to view assignment function
//download it in local temporary storage if user choose the view the file
class DownloadFileBottomsheetContainer extends StatefulWidget {
  final StudyMaterial? studyMaterial;
  const DownloadFileBottomsheetContainer({
    Key? key,
    this.studyMaterial,
  }) : super(key: key);

  @override
  State<DownloadFileBottomsheetContainer> createState() =>
      _DownloadFileBottomsheetContainerState();
}

class _DownloadFileBottomsheetContainerState
    extends State<DownloadFileBottomsheetContainer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * (0.075),
            vertical: MediaQuery.of(context).size.height * (0.04)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiUtils.getTranslatedLabel(context, fileDownloadKey),
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                CustomCloseButton(
                  onTapCloseButton: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.0125),
            ),
            Text(
              widget.studyMaterial!.fileName.toString(),
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.025),
            ),
            BlocConsumer<DownloadFileCubit, DownloadFileState>(
              listener: (context, state) {
                if (state is DownloadFileSuccess) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is DownloadFileInProgress) {
                  return Stack(
                    children: [
                      CustomRoundedButton(
                        height: UiUtils.bottomSheetButtonHeight,
                        widthPercentage:
                            UiUtils.bottomSheetButtonWidthPercentage,
                        titleColor: Theme.of(context).scaffoldBackgroundColor,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        buttonTitle:
                            UiUtils.getTranslatedLabel(context, downloadKey),
                        showBorder: false,
                        onTap: () {
                          context.read<DownloadFileCubit>().downloadFile(
                              studyMaterial: widget.studyMaterial!,
                              storeInExternalStorage: true);
                        },
                      ),
                      Container(
                        width: state.uploadedPercentage,
                        color: Colors.grey,
                      )
                    ],
                  );
                }
                return CustomRoundedButton(
                  height: UiUtils.bottomSheetButtonHeight,
                  widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                  titleColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  buttonTitle: UiUtils.getTranslatedLabel(context, downloadKey),
                  showBorder: false,
                  onTap: () {
                    context.read<DownloadFileCubit>().downloadFile(
                        studyMaterial: widget.studyMaterial!,
                        storeInExternalStorage: true);
                  },
                );
              },
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
              topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
            )),
      ),
    );
  }
}
