import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thesis_mobile/core/bloc/achievements/achievements_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/loading_screen.dart';
import 'package:thesis_mobile/view/new_ui/screens/main_screen.dart';
import 'package:thesis_mobile/view/old_ui/screens/navbar_screen.dart';
import 'package:thesis_mobile/view/onboarding/onboarding_screen.dart';
import 'package:thesis_mobile/view/questionnaire/finish_screen.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => CartBloc(),
            lazy: false,
          ),
          BlocProvider<StatisticsBloc>(
            create: (_) => StatisticsBloc(),
            lazy: false,
          ),
          BlocProvider<TaskManagerBloc>(
            create: (_) => TaskManagerBloc(),
            lazy: false,
          ),
          BlocProvider<AchievementsBloc>(
            create: (_) => AchievementsBloc(),
            lazy: false,
          ),
          BlocProvider<StockBloc>(
            create: (_) => StockBloc(),
            lazy: false,
          ),
          BlocProvider<AddressBloc>(
            create: (_) => AddressBloc(),
            lazy: false,
          ),
          BlocProvider<OrderBloc>(
            create: (_) => OrderBloc(),
            lazy: false,
          )
        ],
        child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Grocery Research',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    canvasColor: AppColors.cloud,
                    primaryColor: AppColors.mintGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    backgroundColor: AppColors.cloud,
                    textTheme: TextTheme(
                        headline3: NewTypography.header24,
                        headline4: NewTypography.header16,
                        headline5: NewTypography.header14,
                        headline6: NewTypography.header12,
                        bodyText2: NewTypography.defaultText14,
                        subtitle1: NewTypography.defaultText12,
                        subtitle2: NewTypography.defaultText10),
                    appBarTheme: AppBarTheme(
                      iconTheme: const IconThemeData(color: AppColors.graphite),
                      backgroundColor: AppColors.cloud,
                      elevation: 0,
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: AppColors.graphite),
                    ),
                    bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.transparent)),
                home: const MyHomePage(),
              );
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screenStages = [
    const OnBoardingScreen(),
    const NavbarScreen(),
    const MainScreen(),
    const FinishScreen()
  ];

  @override
  void initState() {
    final TaskManagerBloc taskManagerBloc =
        BlocProvider.of<TaskManagerBloc>(context);
    taskManagerBloc.initUIDTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerBloc, TaskManagerState>(
      builder: (context, state) {
        if (state.uID.isEmpty) {
          return const LoadingScreen();
        }

        return screenStages[state.stage.index];
      },
    );
  }
}
