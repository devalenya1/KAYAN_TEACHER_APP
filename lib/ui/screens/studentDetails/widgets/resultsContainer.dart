import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class ResultsContainer extends StatefulWidget {
  ResultsContainer({Key? key}) : super(key: key);

  @override
  State<ResultsContainer> createState() => _ResultsContainerState();
}

class _ResultsContainerState extends State<ResultsContainer> {
  Widget _buildResultDetainsContainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.result);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * (0.075)),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.5),
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Unit Exam",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.75),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0),
                    ),
                    Spacer(),
                    Text(
                      "Date : 05, Jul, 2022",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.75),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "Grade - A+",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                    Spacer(),
                    Text(
                      "Percentage : 95%",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            );
          }),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
          padding: EdgeInsets.only(
              top: UiUtils.getScrollViewTopPadding(
                  context: context,
                  appBarHeightPercentage:
                      UiUtils.appBarBiggerHeightPercentage)),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildResultDetainsContainer();
          }),
    );
  }
}
