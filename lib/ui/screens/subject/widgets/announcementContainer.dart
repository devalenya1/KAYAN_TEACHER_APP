import 'package:eschool_teacher/ui/widgets/downloadFileButton.dart';
import 'package:flutter/material.dart';

class AnnouncementContainer extends StatefulWidget {
  AnnouncementContainer({Key? key}) : super(key: key);

  @override
  State<AnnouncementContainer> createState() => _AnnouncementContainerState();
}

class _AnnouncementContainerState extends State<AnnouncementContainer> {
  Widget _buildAnnouncementDetailsContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.075),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Albert C. Verdin",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text("21, March, 2022",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                "Exam Cancel Duo to teacher absent. This is Your Free Lecture. After class will continue as schedule.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0),
                textAlign: TextAlign.left),
            SizedBox(
              height: 15.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: boxConstraints.maxWidth * (0.7),
                  child: Text(
                    "Test paper.pdf",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                DownloadFileButton(),
              ],
            ),
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

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnnouncementDetailsContainer(),
        _buildAnnouncementDetailsContainer(),
        _buildAnnouncementDetailsContainer(),
        _buildAnnouncementDetailsContainer(),
      ],
    );
  }
}
