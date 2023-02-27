import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/default_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Widget> slides = DefaultData.onboardingSlider
      .map((e) => Slider(text: e['text'], icon: e['icon']))
      .toList();

  int currentIndex = 0;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerBloc, TaskManagerState>(
      builder: (context, state) {
        TaskManagerBloc task = context.read<TaskManagerBloc>();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Research"),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return slides[index];
                    }),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                      currentIndex == slides.length - 1 ? "Continue" : "Next"),
                  onPressed: () {
                    if (currentIndex == slides.length - 1) {
                      task.initUIDTask();
                      task.addLogTask('[OLDUI][CREATED] UID ${state.uID}');

                      final addressContext =
                          BlocProvider.of<AddressBloc>(context);
                      addressContext.setAddress(Address(
                        id: addressContext.state.latestAddress + 1,
                        city: 'London',
                        street: 'Park row',
                        building: '10',
                      ));
                      task.addLogTask('[OLDUI][CREATED] Address');

                      task.addLogTask('[OLDUI][STAGE] Transfer to OLDUI');
                      task.updateStageTask(TaskManagerStage.oldUI);
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34.0),
                      ),
                      elevation: 0,
                      minimumSize: const Size(335, 53),
                      textStyle: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.mintGreen,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  final String text;
  final IconData icon;
  const Slider({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.mintGreen,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(text, style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}
