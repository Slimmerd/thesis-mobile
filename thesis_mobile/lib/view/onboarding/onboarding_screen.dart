import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Widget> slides = [Slider1(), Slider2(), Slider3(), Slider4(), Slider5()];

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
            title: Text("Research"),
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
                margin: EdgeInsets.all(20),
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
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.MintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34.0),
                      ),
                      elevation: 0,
                      minimumSize: Size(335, 53),
                      textStyle: TextStyle(fontSize: 18)),
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
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.MintGreen,
      ),
    );
  }
}

class Slider1 extends StatelessWidget {
  const Slider1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco,
            size: 64,
            color: AppColors.MintGreen,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              'Hello, this is application is used in research about impact of interface design decisions on people\'s consumption',
              style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}

class Slider2 extends StatelessWidget {
  const Slider2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 64,
            color: AppColors.MintGreen,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              'The goal is to establish dependency of user interface design on consumption. Also test hypotheses related to reducing environmental impact and consumption',
              style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}

class Slider3 extends StatelessWidget {
  const Slider3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bug_report,
            size: 64,
            color: AppColors.MintGreen,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              'As a tester you need explore both versions of application and make 3 orders in each of them. Don\'t forget to view all sections of the application, not only related to the list of products and orders',
              style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}

class Slider4 extends StatelessWidget {
  const Slider4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 64,
            color: AppColors.MintGreen,
          ),
          Text(
              'When you complete the task you can transfer to the next stage in profile screen',
              style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}

class Slider5 extends StatelessWidget {
  const Slider5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz,
            size: 64,
            color: AppColors.MintGreen,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              'At the end you will have to complete questionare about two applications that you\'ve used',
              style: Theme.of(context).textTheme.headline3)
        ],
      ),
    );
  }
}
