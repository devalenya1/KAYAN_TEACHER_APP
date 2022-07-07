import 'package:eschool_teacher/cubits/downloadfileCubit.dart';
import 'package:eschool_teacher/data/repositories/downloadstudymaterialRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/ui/widgets/downloadFileBottomsheetContainer.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';

class DownloadFileButton extends StatelessWidget {
  final StudyMaterial? studyMaterial;
  //TODO : Add file to download
  const DownloadFileButton({
    Key? key,
    this.studyMaterial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        UiUtils.showBottomSheet(
            child: BlocProvider<DownloadFileCubit>(
              create: (context) => DownloadFileCubit(SubjectRepository()),
              child: DownloadFileBottomsheetContainer(
                  studyMaterial: studyMaterial!),
            ),
            context: context);
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
