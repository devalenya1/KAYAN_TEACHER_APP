import 'package:eschool_teacher/cubits/announcementsCubit.dart';
import 'package:eschool_teacher/data/models/announcement.dart';
import 'package:eschool_teacher/data/models/classSectionDetails.dart';
import 'package:eschool_teacher/data/models/subject.dart';
import 'package:eschool_teacher/ui/widgets/customShimmerContainer.dart';
import 'package:eschool_teacher/ui/widgets/errorContainer.dart';
import 'package:eschool_teacher/ui/widgets/shimmerLoadingContainer.dart';
import 'package:eschool_teacher/ui/widgets/studyMaterialWithDownloadButtonContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timeago/timeago.dart' as timeago;

class AnnouncementsContainer extends StatelessWidget {
  final Subject subject;
  final ClassSectionDetails classSectionDetails;

  AnnouncementsContainer(
      {Key? key, required this.classSectionDetails, required this.subject})
      : super(key: key);

  Widget _buildAnnouncementShimmerLoading(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
      width: MediaQuery.of(context).size.width * (0.8),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 4.0,
              width: boxConstraints.maxWidth * (0.65),
            )),
            SizedBox(
              height: 10,
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 3.0,
              width: boxConstraints.maxWidth * (0.5),
            )),
            SizedBox(
              height: 20,
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 3.0,
              height: UiUtils.shimmerLoadingContainerDefaultHeight - 2,
              width: boxConstraints.maxWidth * (0.3),
            )),
          ],
        );
      }),
    );
  }

  Widget _buildAnnouncementContainer(
      {required Announcement announcement,
      required BuildContext context,
      required int index,
      required int totalAnnouncements,
      required bool hasMoreAnnouncements,
      required bool hasMoreAnnouncementsInProgress,
      required bool fetchMoreAnnouncementsFailure}) {
    //show announcement loading container for last announcement container
    if (index == (totalAnnouncements - 1)) {
      //If has more assignment
      if (hasMoreAnnouncements) {
        if (hasMoreAnnouncementsInProgress) {
          return _buildAnnouncementShimmerLoading(context);
        }
        if (fetchMoreAnnouncementsFailure) {
          return Center(
            child: CupertinoButton(
                child: Text(UiUtils.getTranslatedLabel(context, retryKey)),
                onPressed: () {
                  context.read<AnnouncementsCubit>().fetchMoreAnnouncements(
                      classSectionId: classSectionDetails.id,
                      subjectId: subject.id);
                }),
          );
        }
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement.title,
              style: TextStyle(
                height: 1.2,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: announcement.description.isEmpty ? 0 : 5,
            ),
            announcement.description.isEmpty
                ? SizedBox()
                : Text(
                    announcement.description,
                    style: TextStyle(
                      height: 1.2,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.5,
                    ),
                  ),
            ...announcement.files
                .map((studyMaterial) =>
                    StudyMaterialWithDownloadButtonContainer(
                        boxConstraints: boxConstraints,
                        studyMaterial: studyMaterial))
                .toList(),
            SizedBox(
              height: announcement.files.isNotEmpty ? 0 : 5,
            ),
            Text(timeago.format(announcement.createdAt),
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.75),
                    fontWeight: FontWeight.w400,
                    fontSize: 10),
                textAlign: TextAlign.start)
          ],
        );
      }),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width * (0.85),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
      builder: (context, state) {
        if (state is AnnouncementsFetchSuccess) {
          return Column(
            children:
                List.generate(state.announcements.length, (index) => index)
                    .map((index) => _buildAnnouncementContainer(
                        context: context,
                        announcement: state.announcements[index],
                        index: index,
                        totalAnnouncements: state.announcements.length,
                        hasMoreAnnouncements:
                            context.read<AnnouncementsCubit>().hasMore(),
                        hasMoreAnnouncementsInProgress:
                            state.fetchMoreAnnouncementsInProgress,
                        fetchMoreAnnouncementsFailure:
                            state.moreAnnouncementsFetchError))
                    .toList(),
          );
        }
        if (state is AnnouncementsFetchFailure) {
          return Center(
            child: ErrorContainer(
              errorMessageCode: state.errorMessage,
              onTapRetry: () {
                context.read<AnnouncementsCubit>().fetchAnnouncements(
                    classSectionId: classSectionDetails.id,
                    subjectId: subject.id);
              },
            ),
          );
        }

        return Column(
          children: List.generate(
                  UiUtils.defaultShimmerLoadingContentCount, (index) => index)
              .map((e) => _buildAnnouncementShimmerLoading(context))
              .toList(),
        );
      },
    );
  }
}
