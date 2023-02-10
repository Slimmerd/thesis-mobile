import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/new_ui/screens/main_screen.dart';
import 'package:thesis_mobile/view/old_ui/screens/navbar_screen.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => CartBloc(),
            lazy: false,
          ),
          // BlocProvider<FavouriteBloc>(
          //   create: (_) => FavouriteBloc(),
          //   lazy: false,
          // ),
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
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ru'), // Russian
                ],
                theme: ThemeData(
                    canvasColor: AppColors.Cloud,
                    primaryColor: AppColors.MintGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    backgroundColor: AppColors.Cloud,
                    // primarySwatch: Colors.blue,
                    // canvasColor: Colors.transparent
                    textTheme: TextTheme(
                        headline3: NewTypography.Header24,
                        headline4: NewTypography.Header16,
                        headline5: NewTypography.Header14,
                        headline6: NewTypography.Header12,
                        bodyText2: NewTypography.DefaultText14,
                        subtitle1: NewTypography.DefaultText12,
                        subtitle2: NewTypography.DefaultText10),
                    appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: AppColors.Graphite),
                      backgroundColor: AppColors.Cloud,
                      elevation: 0,
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: AppColors.Graphite),
                    ),
                    bottomSheetTheme: BottomSheetThemeData(
                        backgroundColor: Colors.transparent)),
                home: const MyHomePage(),
              );
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavbarScreen();
  }
}
