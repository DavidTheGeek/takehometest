import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'search.dart';
import 'colors.dart';
import 'strings.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MyHomePage(),
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        title: Strings.appName);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late AnimationController _controller;
  late Animation<int> _buyNumberAnimation, _rentNumberAnimation;
  late AnimationController _slideUpController;
  late Animation<Offset> _slideUpAnimation;
  late AnimationController _slideUpActionController;
  late Animation<Offset> _slideUpActionAnimation;
  late AnimationController _homeLocationController;
  late Animation<Offset> _homeLocationAnimation;
  final List listOfActionButtons = <String>[
    "assets/images/search.png",
    "assets/images/message.png",
    "assets/images/home.png",
    "assets/images/heart.png",
    "assets/images/avatar.png",
  ];
  bool loading = true;
  bool showHomes = false;
  int selectedAction = 2;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          loading = false;
          showHomes = true;
        });
      });
    });

    // Slide in animation
    _slideController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));
    _slideController.forward();

    // Fade out animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _slideController,
            curve: const Interval(0.1, 1.0, curve: Curves.easeIn)));
    // Number count up animation
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _buyNumberAnimation =
        IntTween(begin: 0, end: Strings.buyNumber).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _rentNumberAnimation =
        IntTween(begin: 0, end: Strings.rentNumber).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _controller.forward();

    //  Slide up animation homes
    _slideUpController = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);
    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start at the bottom
      end: const Offset(0, 0), // End at the center
    ).animate(CurvedAnimation(
      parent: _slideUpController,
      curve: Curves.easeInOut,
    ));
    _slideUpController.forward();

    //  Slide up animation action
    _slideUpActionController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _slideUpActionAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start at the bottom
      end: const Offset(0, 0), // End at the center
    ).animate(CurvedAnimation(
      parent: _slideUpActionController,
      curve: Curves.easeInOut,
    ));
    _slideUpActionController.forward();

    // Location
    _homeLocationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _homeLocationAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _homeLocationController,
      curve: Curves.easeInOut,
    ));
    _homeLocationController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _controller.dispose();
    _slideUpController.dispose();
    _homeLocationController.dispose();
    _slideUpActionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(backgroundColor: AppColors.secondaryBackgroundColor)
        : Scaffold(
            appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              AppColors.mainBackgroundColor,
                              AppColors.secondaryBackgroundColor
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp))),
                title: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        decoration: BoxDecoration(
                            color: AppColors.locationColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: AnimatedBuilder(
                            animation: _slideController,
                            builder: (context, child) {
                              return Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: child);
                            },
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              const Icon(Icons.location_on,
                                  color: AppColors.textColorPrimary, size: 14),
                              Text(Strings.location,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ])))),
                centerTitle: false,
                actions: [
                  AnimatedBuilder(
                      animation: _slideController,
                      builder: (context, child) {
                        return Opacity(
                            opacity: _opacityAnimation.value, child: child);
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset("assets/images/ic_dp.png",
                              width: 40, height: 40)))
                ],
                elevation: 0),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.mainBackgroundColor,
                                AppColors.secondaryBackgroundColor
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)),
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                                opacity: _opacityAnimation.value, child: child);
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 30, 20, 30),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Strings.greeting,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text(Strings.instruction,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 30),
                                    Row(children: [
                                      Expanded(flex: 5, child: buyLayout()),
                                      Expanded(flex: 5, child: rentLayout())
                                    ])
                                  ])))),
                  Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.mainBackgroundColor,
                                AppColors.secondaryBackgroundColor
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)),
                      child: Visibility(
                          visible: showHomes,
                          child: SlideTransition(
                              position: _slideUpAnimation,
                              child: Container(
                                  width: double.maxFinite,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bodyColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        StaggeredGrid.count(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 1,
                                            crossAxisSpacing: 1,
                                            children: [
                                              StaggeredGridTile.count(
                                                  crossAxisCellCount: 4,
                                                  mainAxisCellCount: 2,
                                                  child: Card(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 10, 10, 5),
                                                      color:
                                                          AppColors.bodyColor,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Stack(
                                                          children: <Widget>[
                                                            Positioned.fill(
                                                                child: ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                    child: Image.asset(
                                                                        "assets/images/home_one.jpg",
                                                                        width: double
                                                                            .maxFinite,
                                                                        height:
                                                                            180,
                                                                        fit: BoxFit
                                                                            .fill))),
                                                            locationOverlay(
                                                                0,
                                                                TextAlign
                                                                    .center,
                                                                AppColors
                                                                    .homeLocationColorOne)
                                                          ]))),
                                              StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 4,
                                                  child: Card(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 5, 5, 10),
                                                      color:
                                                          AppColors.bodyColor,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Stack(children: [
                                                        Positioned.fill(
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                child: Image.asset(
                                                                    "assets/images/home_two.jpeg",
                                                                    width: double
                                                                        .maxFinite,
                                                                    height: 180,
                                                                    fit: BoxFit
                                                                        .fill))),
                                                        locationOverlay(
                                                            1,
                                                            TextAlign.left,
                                                            AppColors
                                                                .homeLocationColorTwo)
                                                      ]))),
                                              StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 2,
                                                  child: Card(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          5, 5, 10, 10),
                                                      color:
                                                          AppColors.bodyColor,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Stack(children: [
                                                        Positioned.fill(
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                child: Image.asset(
                                                                    "assets/images/home_four.jpeg",
                                                                    width: double
                                                                        .maxFinite,
                                                                    height: 180,
                                                                    fit: BoxFit
                                                                        .fill))),
                                                        locationOverlay(
                                                            1,
                                                            TextAlign.left,
                                                            AppColors
                                                                .homeLocationColorTwo)
                                                      ]))),
                                              StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 2,
                                                  child: Card(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          5, 5, 10, 10),
                                                      color:
                                                          AppColors.bodyColor,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Stack(children: [
                                                        Positioned.fill(
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                child: Image.asset(
                                                                    "assets/images/home_three.jpeg",
                                                                    width: double
                                                                        .maxFinite,
                                                                    height: 180,
                                                                    fit: BoxFit
                                                                        .fill))),
                                                        locationOverlay(
                                                            1,
                                                            TextAlign.left,
                                                            AppColors
                                                                .homeLocationColorTwo)
                                                      ])))
                                            ])
                                      ])))))
                ])),
            floatingActionButton: SlideTransition(
                position: _slideUpActionAnimation,
                child: Visibility(
                    visible: showHomes,
                    child: IntrinsicWidth(
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.navigationBarColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                        listOfActionButtons.length,
                                        (index) => actionButtons(index)))))))),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat);
  }

  Widget buyLayout() {
    return Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        height: 180,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: AppColors.seedColor, shape: BoxShape.circle),
        child: Column(children: [
          const Text("BUY",
              style: TextStyle(fontSize: 14, color: Colors.white)),
          const SizedBox(height: 30),
          Text(_buyNumberAnimation.value.toString(),
              style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const Text("offers",
              style: TextStyle(fontSize: 12, color: Colors.white)),
        ]));
  }

  Widget rentLayout() {
    return Container(
        margin: const EdgeInsets.only(left: 6),
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        height: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.bodyColor,
            borderRadius: BorderRadius.circular(25)),
        child: Column(children: [
          const Text("RENT", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 30),
          Text(_rentNumberAnimation.value.toString(),
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text("offers", style: TextStyle(fontSize: 12)),
        ]));
  }

  Widget actionButtons(int index) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (index == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Search()));
          }
        },
        child: Container(
            margin: const EdgeInsets.all(6),
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: index == selectedAction
                    ? AppColors.seedColor
                    : AppColors.actionButton,
                shape: BoxShape.circle),
            child: Image.asset(listOfActionButtons[index],
                color: Colors.white, width: 17, height: 17)));
  }

  Widget locationOverlay(int index, TextAlign gravity, Color backgroundColor) {
    return AnimatedBuilder(
        animation: _homeLocationController,
        builder: (context, child) {
          return Positioned(
              bottom: 10,
              right: _homeLocationController.status == AnimationStatus.forward
                  ? null
                  : 10,
              left: _homeLocationController.status == AnimationStatus.forward
                  ? null
                  : 10,
              child: SlideTransition(
                  position: _homeLocationAnimation,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                              color: backgroundColor.withOpacity(0.5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Visibility(
                                        visible: _homeLocationController
                                                .status !=
                                            AnimationStatus.forward,
                                        child: Expanded(
                                            child: Text(
                                                Strings
                                                    .listOfHomeLocations[index],
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .textColorSecondary,
                                                    fontSize: 16),
                                                textAlign: gravity))),
                                    Image.asset("assets/images/next.png",
                                        width: 32,
                                        height: 32,
                                        color: Colors.white)
                                  ]))))));
        });
  }
}
