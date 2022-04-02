import 'package:eschool_teacher/ui/widgets/dismissibleBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/dismissibleSecondaryBackgroundContainer.dart';
import 'package:flutter/material.dart';

class VideosContainer extends StatefulWidget {
  VideosContainer({Key? key}) : super(key: key);

  @override
  State<VideosContainer> createState() => _VideosContainerState();
}

class _VideosContainerState extends State<VideosContainer> {
  Widget _buildVideoContainer({
    required String videoThumbnailUrl,
    required String videoTitle,
  }) {
    return Dismissible(
      key: Key(videoTitle),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          print("Delete");
        } else if (direction == DismissDirection.startToEnd) {
          print("Edit");
        }
        return Future.value(false);
      },
      background: DismissibleBackgroundContainer(),
      secondaryBackground: DismissibleSecondaryBackgroundContainer(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                offset: Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 0)
          ],
        ),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                height: 65,
                width: boxConstraints.maxWidth * (0.3),
              ),
              SizedBox(
                width: boxConstraints.maxWidth * (0.05),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chapter 1 : Organic chemsitry",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Chapter 1 : Organic chemistry description",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12.0),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
        width: MediaQuery.of(context).size.width * (0.85),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVideoContainer(
            videoThumbnailUrl: "videoThumbnailUrl", videoTitle: "videoTitle")
      ],
    );
  }
}
