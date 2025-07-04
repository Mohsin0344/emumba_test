import 'package:emumba_test/data/events_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app_routes/app_route_model/manage_event_route_model.dart';
import '../../../app_routes/route_names.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../view_models/events/get_events_view_model.dart';
import '../../../view_models/nav_bar/nav_bar_view_model.dart';
import 'events/events_calendar_screen.dart';
import 'events/events_list_view_screen.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  late NavBarViewModel navBarViewModel;
  late GetEventsViewModel getEventsViewModel;

  final List<Widget> _screens = [
    const EventsListViewScreen(),
    const EventsCalendarScreen(),
  ];

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {
    navBarViewModel = context.read<NavBarViewModel>();
    getEventsViewModel = context.read<GetEventsViewModel>();
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
                    navBarViewModel.navBarItemTitles.length,
                    (index) => navbarItem(
                      title: navBarViewModel.navBarItemTitles[index],
                      isActive: index == tabIndex,
                      onTap: () {
                        getEventsViewModel.selectedDateTime = null;
                        getEventsViewModel.selectedEventType = null;
                        getEventsViewModel.getEvents();
                        navBarViewModel.changeTap(
                          tabIndex: index,
                        );
                      },
                      icon: navBarViewModel.navBarIcons[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => Navigator.pushNamed(
          context,
          RouteNames.manageEventScreen,
          arguments: const ManageEventRouteModel(
            event: null,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.secondaryColor,
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
