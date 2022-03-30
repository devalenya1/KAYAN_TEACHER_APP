import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class ChaptersContainer extends StatefulWidget {
  const ChaptersContainer({Key? key}) : super(key: key);

  @override
  State<ChaptersContainer> createState() => _ChaptersContainerState();
}

class _ChaptersContainerState extends State<ChaptersContainer> {
  Widget _buildChapterDetailsContainer(
      {required String chapterName, required String chapterDescription}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          //Navigator.of(context).pushNamed(Routes.chapterDetails);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(UiUtils.getTranslatedLabel(context, chapterNameKey),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 2.5,
              ),
              Text("Trees & Plants",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 15,
              ),
              Text(UiUtils.getTranslatedLabel(context, chapterDescriptionKey),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 2.5,
              ),
              Text(
                  "Lorem ipsum dolor sit amet, consecteturadipiscing elit. Lorem ipsum dolor sit amet, consecteturadipiscing elit.",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  textAlign: TextAlign.left),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10.0)),
          width: MediaQuery.of(context).size.width * (0.85),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChapterDetailsContainer(
            chapterName: "Chapter Name",
            chapterDescription: "Chapter Description"),
        _buildChapterDetailsContainer(
            chapterName: "Chapter Name",
            chapterDescription: "Chapter Description"),
        _buildChapterDetailsContainer(
            chapterName: "Chapter Name",
            chapterDescription: "Chapter Description"),
        _buildChapterDetailsContainer(
            chapterName: "Chapter Name",
            chapterDescription: "Chapter Description"),
        _buildChapterDetailsContainer(
            chapterName: "Chapter Name",
            chapterDescription: "Chapter Description"),
      ],
    );
  }
}
