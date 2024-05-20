import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'strings.dart';
import 'colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  late AnimationController _slideUpController;
  late Animation<Offset> _slideUpAnimation;
  final List listOfActionButtons = <String>[
    "assets/images/search.png",
    "assets/images/message.png",
    "assets/images/home.png",
    "assets/images/heart.png",
    "assets/images/avatar.png",
  ];
  final List listOfIcons = <IconData>[
    Icons.security,
    Icons.account_balance_wallet_outlined,
    Icons.backpack_outlined,
    Icons.layers_outlined
  ];
  int selectedAction = 0;
  int selectedOption = 1;

  @override
  void initState() {
    super.initState();

    //  Slide up animation
    _slideUpController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    _slideUpAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _slideUpController, curve: Curves.easeInOut));
    _slideUpController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/map.png"), fit: BoxFit.cover)),
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 10, 12, 12),
                                prefixIcon: const Icon(Icons.search),
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: Strings.location,
                                hintStyle: const TextStyle(
                                    color: AppColors.textColorSecondary)),
                            style: const TextStyle(
                                color: AppColors.textColorSecondary),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences)),
                    const SizedBox(width: 10),
                    IconButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white),
                        icon: Image.asset("assets/images/settings_sliders.png",
                            height: 16,
                            width: 16,
                            color: AppColors.textColorSecondary),
                        onPressed: () {}),
                  ]),
                )),
            backgroundColor: Colors.transparent,
            body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Stack(children: [
                        Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopupMenuButton<int>(
                                      position: PopupMenuPosition.over,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      icon: Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              color: AppColors
                                                  .searchButtonBackground,
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                              "assets/images/database.png",
                                              height: 16,
                                              width: 16,
                                              color: Colors.white)),
                                      onSelected: (int value) {},
                                      itemBuilder: (BuildContext context) {
                                        return Strings.listOfHomeIndex
                                            .map((int choice) {
                                          return PopupMenuItem<int>(
                                              value: choice,
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(listOfIcons[choice],
                                                        color: choice ==
                                                                selectedOption
                                                            ? AppColors
                                                                .seedColor
                                                            : AppColors
                                                                .textColorSecondary),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                        Strings.listOfHomeOptions[
                                                            choice],
                                                        style: TextStyle(
                                                            color: choice ==
                                                                    selectedOption
                                                                ? AppColors
                                                                    .seedColor
                                                                : AppColors
                                                                    .textColorSecondary))
                                                  ]));
                                        }).toList();
                                      }),
                                  const SizedBox(height: 16.0),
                                  IconButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              AppColors.searchButtonBackground),
                                      icon: Image.asset(
                                          "assets/images/send.png",
                                          height: 22,
                                          width: 22,
                                          color: Colors.white),
                                      onPressed: () {})
                                ])),
                        Positioned(
                            bottom: 16.0,
                            right: 16.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        AppColors.searchButtonBackground),
                                onPressed: () {
                                  // Button action
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/images/sort.png",
                                          height: 22,
                                          width: 22,
                                          color: Colors.white),
                                      const SizedBox(width: 3),
                                      const Text('List of variants')
                                    ])))
                      ])),
                      const SizedBox(height: 100)
                    ])),
            floatingActionButton: SlideTransition(
                position: _slideUpAnimation,
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
                                    (index) => actionButtons(index))))))),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat));
  }

  Widget actionButtons(int index) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (index == 2) {
            Navigator.of(context).pop();
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
}
