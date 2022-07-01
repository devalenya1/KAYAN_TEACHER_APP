import 'package:eschool_teacher/data/models/pickedStudyMaterial.dart';
import 'package:eschool_teacher/ui/widgets/addStudyMaterialBottomSheet.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AddedFileContainer extends StatelessWidget {
  final int fileIndex;
  final PickedStudyMaterial file;
  final Function(int, PickedStudyMaterial) onEdit;
  final Function(int) onDelete;
  const AddedFileContainer(
      {Key? key,
      required this.file,
      required this.fileIndex,
      required this.onDelete,
      required this.onEdit})
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

    final subTitleTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        fontSize: 13);

    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Show youtubelink or added file path
            Text(file.fileName,
                overflow: TextOverflow.ellipsis,
                style: titleTextStyle,
                textAlign: TextAlign.left),

            file.pickedStudyMaterialTypeId != 2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(UiUtils.getTranslatedLabel(context, filePathKey),
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle,
                          textAlign: TextAlign.left),
                      Text(
                        file.studyMaterialFile?.path ?? "",
                        style: subTitleTextStyle,
                      ),
                    ],
                  )
                : SizedBox(),

            file.pickedStudyMaterialTypeId == 2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(UiUtils.getTranslatedLabel(context, youtubeLinkKey),
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle,
                          textAlign: TextAlign.left),
                      Text(
                        file.youTubeLink ?? "",
                        style: subTitleTextStyle,
                      ),
                    ],
                  )
                : SizedBox(),

            file.pickedStudyMaterialTypeId != 1
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
                      Text(
                        file.videoThumbnailFile?.path ?? "",
                        style: subTitleTextStyle,
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildAddedVideoActionButton(
                    context: context,
                    rightMargin: 15,
                    width: boxConstraints.maxWidth * (0.3),
                    title: UiUtils.getTranslatedLabel(context, editKey),
                    onTap: () {
                      UiUtils.showBottomSheet(
                          child: AddStudyMaterialBottomsheet(
                              editFileDetails: true,
                              pickedStudyMaterial: file,
                              onTapSubmit: (updatedFile) {
                                onEdit(fileIndex, updatedFile);
                              }),
                          context: context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.onPrimary),
                _buildAddedVideoActionButton(
                    context: context,
                    rightMargin: 0,
                    width: boxConstraints.maxWidth * (0.3),
                    title: UiUtils.getTranslatedLabel(context, deleteKey),
                    onTap: () {
                      onDelete(fileIndex);
                    },
                    backgroundColor: Theme.of(context).colorScheme.error),
              ],
            )
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
