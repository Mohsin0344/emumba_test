import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../view_models/nav_bar/nav_bar_view_model.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  late NavBarViewModel navBarViewModel;

  List navBarItemTitles = [
    'List View',
    'Calendar View',
  ];

  List navBarIcons = [
    Icons.list,
    Icons.calendar_month,
  ];

  final List<Widget> _screens = [
    const SizedBox(),
    const SizedBox(),
  ];

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {
    navBarViewModel = context.read<NavBarViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavBarViewModel, int>(
        builder: (context, tabIndex) {
          return IndexedStack(
            index: tabIndex,
            children: _screens,
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 80.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              topLeft: Radius.circular(12.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              0.w,
              10.h,
              0.w,
              0,
            ),
            child: BlocBuilder<NavBarViewModel, int>(
              builder: (context, tabIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    navBarItemTitles.length,
                    (index) => navbarItem(
                      title: navBarItemTitles[index],
                      isActive: index == tabIndex,
                      onTap: () => navBarViewModel.changeTap(
                        tabIndex: index,
                      ),
                      icon: navBarIcons[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  navbarItem(
      {required String title,
      required bool isActive,
      required Function() onTap,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          children: [
            Icon(
              icon,
              color:
                  isActive ? AppColors.secondaryColor : AppColors.disabledColor,
            ),
            4.verticalSpace,
            Flexible(
              child: Text(
                title,
                style: AppFonts.bodyFont(
                  color: isActive
                      ? AppColors.secondaryColor
                      : AppColors.disabledColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
