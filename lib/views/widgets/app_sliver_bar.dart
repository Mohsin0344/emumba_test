import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../view_models/nav_bar/nav_bar_view_model.dart';

class AppSliverBar extends StatefulWidget {
  const AppSliverBar({super.key});

  @override
  State<AppSliverBar> createState() => _AppSliverBarState();
}

class _AppSliverBarState extends State<AppSliverBar> {
  late NavBarViewModel navBarViewModel;


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
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      pinned: true,
      centerTitle: true,
      title: BlocBuilder<NavBarViewModel, int>(
        builder: (context, tabIndex) {
          return Text(
            'My ${navBarViewModel.navBarItemTitles[tabIndex]}',
            style: AppFonts.bodyFont(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
    );
  }
}
