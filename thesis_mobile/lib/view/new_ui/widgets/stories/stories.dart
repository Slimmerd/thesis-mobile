import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  final controller = StoryController();

  @override
  Widget build(context) {
    List<StoryItem> storyItems = [
      StoryItem.pageProviderImage(
        Image.asset('assets/547.jpg').image,
      ),
      StoryItem.pageProviderImage(Image.asset('assets/548.jpg').image,
          duration: const Duration(seconds: 10)),
      StoryItem.pageProviderImage(Image.asset('assets/549.jpg').image,
          duration: const Duration(seconds: 10)),
    ];

    return StoryView(
        storyItems: storyItems,
        controller: controller,
        repeat: true,
        onStoryShow: (s) {
          final taskContext = BlocProvider.of<TaskManagerBloc>(context);
          taskContext.addLogTask('[NEWUI][OPENED] Story');
        },
        onComplete: () {
          Navigator.pop(context);
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        });
  }
}
