import 'package:eschool_teacher/ui/widgets/downloadFileBottomsheetContainer.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadFileButton extends StatelessWidget {
  //TODO : Add file to download
  const DownloadFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        showModalBottomSheet(
            enableDrag: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
                    topRight: Radius.circular(UiUtils.bottomSheetTopRadius))),
            context: context,
            builder: (_) => DownloadFileBottomsheetContainer());
      },
      child: Container(
        width: 30,
        height: 30,
        padding: EdgeInsets.all(8.0),
        child: SvgPicture.asset(UiUtils.getImagePath("download_icon.svg")),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
      ),
    );
  }
}
