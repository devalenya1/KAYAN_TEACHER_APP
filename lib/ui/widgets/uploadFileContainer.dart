import 'package:eschool_teacher/features/uploadFile/uploadFileCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO : manage with key
class UploadFileContainer extends StatelessWidget {
  const UploadFileContainer({Key? key}) : super(key: key);

  Widget _buildProgressContainer(
      {required Color color,
      required BuildContext context,
      required double widthPercentage,
      required BoxConstraints boxConstraints}) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      width: boxConstraints.maxWidth * widthPercentage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileCubit>(
      create: (_) => UploadFileCubit(),
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return BlocConsumer<UploadFileCubit, UploadFileState>(
              bloc: context.read<UploadFileCubit>(),
              builder: (context, state) {
                if (state is UploadFileInitial) {
                  return _buildProgressContainer(
                      boxConstraints: boxConstraints,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.3),
                      context: context,
                      widthPercentage: 1.0);
                }
                if (state is UploadFileInProgress) {
                  return Stack(
                    children: [
                      _buildProgressContainer(
                          boxConstraints: boxConstraints,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.3),
                          context: context,
                          widthPercentage: 1.0),
                      _buildProgressContainer(
                          boxConstraints: boxConstraints,
                          color: Theme.of(context).colorScheme.primary,
                          context: context,
                          widthPercentage: 0.5),
                    ],
                  );
                }
                if (state is UploadFileSuccess) {
                  return Text((state as UploadFileFailure).errorMessage);
                }
                return Center(
                  child: Text((state as UploadFileFailure).errorMessage),
                );
              },
              listener: (context, state) {});
        },
      ),
    );
  }
}
