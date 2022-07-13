import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/editStudyMaterialBottomSheet.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class StudyMaterialContainer extends StatelessWidget {
  final bool showEditAndDeleteButton;
  final StudyMaterial studyMaterial;

  const StudyMaterialContainer(
      {Key? key,
      required this.studyMaterial,
      required this.showEditAndDeleteButton})
      : super(key: key);

  //
  Widget _buildAddedVideoActionButton(
      {required String title,
      required double rightMargin,
      required double width,
      required Function onTap,
      required Color backgroundColor,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        margin: EdgeInsets.only(right: rightMargin),
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: backgroundColor),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          UiUtils.getTranslatedLabel(context, title),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 13.5, color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
        fontSize: 13.5);

    final subTitleTextStyle =
        TextStyle(color: assignmentViewButtonColor, fontSize: 13);

    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Show youtubelink or added file path
            Text(studyMaterial.fileName,
                overflow: TextOverflow.ellipsis,
                style: titleTextStyle,
                textAlign: TextAlign.left),

            studyMaterial.studyMaterialType != StudyMaterialType.youtubeVideo
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(UiUtils.getTranslatedLabel(context, filePathKey),
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle,
                          textAlign: TextAlign.left),
                      GestureDetector(
                        onTap: () {
                          UiUtils.openFileInBrowser(
                              studyMaterial.fileUrl, context);
                        },
                        child: Text(
                          "${studyMaterial.fileName}.${studyMaterial.fileExtension}",
                          style: subTitleTextStyle,
                        ),
                      ),
                    ],
                  )
                : SizedBox(),

            studyMaterial.studyMaterialType == StudyMaterialType.youtubeVideo
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(UiUtils.getTranslatedLabel(context, youtubeLinkKey),
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle,
                          textAlign: TextAlign.left),
                      GestureDetector(
                        onTap: () {
                          UiUtils.openFileInBrowser(
                              studyMaterial.fileUrl, context);
                        },
                        child: Text(
                          studyMaterial.fileUrl,
                          style: subTitleTextStyle,
                        ),
                      ),
                    ],
                  )
                : SizedBox(),

            studyMaterial.studyMaterialType != StudyMaterialType.file
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(
                          UiUtils.getTranslatedLabel(
                              context, thumbnailImageKey),
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle,
                          textAlign: TextAlign.left),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    studyMaterial.fileThumbnail)),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  )
                : SizedBox(),

            SizedBox(
              height: 20,
            ),
            showEditAndDeleteButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildAddedVideoActionButton(
                          context: context,
                          rightMargin: 15,
                          width: boxConstraints.maxWidth * (0.3),
                          title: UiUtils.getTranslatedLabel(context, editKey),
                          onTap: () {
                            UiUtils.showBottomSheet(
                                child: EditStudyMaterialBottomSheet(
                                    studyMaterial: studyMaterial),
                                context: context);
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary),
                      _buildAddedVideoActionButton(
                          context: context,
                          rightMargin: 0,
                          width: boxConstraints.maxWidth * (0.3),
                          title: UiUtils.getTranslatedLabel(context, deleteKey),
                          onTap: () {
                            //
                          },
                          backgroundColor: Theme.of(context).colorScheme.error),
                    ],
                  )
                : SizedBox()
          ],
        );
      }),
      width: MediaQuery.of(context).size.width * (0.85),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
