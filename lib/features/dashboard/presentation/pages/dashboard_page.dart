import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics_app/core/widgets/snack_bar.dart';
import 'package:logistics_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';

import '../../../../core/theme/app_colours.dart';
import '../../../../injection.dart' as di;
import '../../data/models/dashboard_model.dart';
import '../widgets/recent_activities.dart';
import '../widgets/stats_card.dart';

class DashboardPage extends StatefulWidget {
  final int userId;

  const DashboardPage({Key? key, required this.userId}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<DashboardBloc>()..add(GetDashboardDataEvent(userId: widget.userId)),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          builder: (context, state) {
            var dashboardBloc = DashboardBloc.get(context);

            if (state is LoadingDashboardState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedDashboardState) {
              final draftCard = dashboardBloc.dashboardCardsList.firstWhere(
                (card) => card.cardName == 'Draft',
                orElse:
                    () =>
                        DashboardCardsModel(cardName: 'Draft', cardIntValue: 0),
              );
              final inProgressCard = dashboardBloc.dashboardCardsList
                  .firstWhere(
                    (card) => card.cardName == 'In Progress',
                    orElse:
                        () => DashboardCardsModel(
                          cardName: 'In Progress',
                          cardIntValue: 0,
                        ),
                  );
              final doneCard = dashboardBloc.dashboardCardsList.firstWhere(
                (card) => card.cardName == 'Done',
                orElse:
                    () =>
                        DashboardCardsModel(cardName: 'Done', cardIntValue: 0),
              );
              final urgentCard = dashboardBloc.dashboardCardsList.firstWhere(
                (card) => card.cardName == 'Urgent',
                orElse:
                    () => DashboardCardsModel(
                      cardName: 'Urgent',
                      cardIntValue: 0,
                    ),
              );

              final barColors = [
                AppColors.primary,
                AppColors.accent,
                AppColors.success,
                AppColors.info,
                AppColors.warning,
              ];

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Requests Dashboard',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  fontSize: 36.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Today, ${DateTime.now().day} ${_getMonthName(DateTime.now().month)}',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(Icons.notifications_outlined, size: 24.w),
                          //   style: IconButton.styleFrom(
                          //     backgroundColor: Colors.grey[200],
                          //     padding: EdgeInsets.all(10.w),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Stats cards
                      Row(
                        children: [
                          Expanded(
                            child: StatsCard(
                              title: 'Pending Requests',
                              value: draftCard.cardIntValue.toString(),
                              icon: Icons.pending_actions_outlined,
                              color: AppColors.warning,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: StatsCard(
                              title: 'In Progress',
                              value: inProgressCard.cardIntValue.toString(),
                              icon: Icons.hourglass_bottom_outlined,
                              color: AppColors.info,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: StatsCard(
                              title: 'Completed',
                              value: doneCard.cardIntValue.toString(),
                              icon: Icons.check_circle_outline,
                              color: AppColors.success,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: StatsCard(
                              title: 'Urgent',
                              value: urgentCard.cardIntValue.toString(),
                              icon: Icons.warning_amber_outlined,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Chart section
                      Text(
                        'Requests by Category',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        height: 160.h,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child:
                            dashboardBloc.categoryCountsList.isEmpty
                                ? Center(
                                  child: Text(
                                    'No category data available',
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                )
                                : BarChart(
                                  BarChartData(
                                    barGroups:
                                        dashboardBloc.categoryCountsList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                              final index = entry.key;
                                              final category = entry.value;
                                              return BarChartGroupData(
                                                x: index,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY:
                                                        category.requestCount
                                                            .toDouble(),
                                                    color:
                                                        barColors[index %
                                                            barColors.length],
                                                    width: 20.w,
                                                  ),
                                                ],
                                                showingTooltipIndicators: [0],
                                              );
                                            })
                                            .toList(),
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(
                                      leftTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      rightTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      topTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            final index = value.toInt();
                                            if (index <
                                                dashboardBloc
                                                    .categoryCountsList
                                                    .length) {
                                              return SideTitleWidget(
                                                axisSide: meta.axisSide,
                                                child: Text(
                                                  dashboardBloc
                                                      .categoryCountsList[index]
                                                      .categoryName,
                                                  style: TextStyle(
                                                    fontSize: 22.sp,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      ),
                      SizedBox(height: 35.h),

                      // Recent activity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Requests',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'View All',
                              style: TextStyle(fontSize: 22.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      const RecentActivityItem(
                        title: 'Salary Certificate Requested',
                        time: '10 minutes ago',
                        statusColor: AppColors.info,
                      ),
                      const Divider(),
                      const RecentActivityItem(
                        title: 'Maintenance Request Completed',
                        time: '1 hour ago',
                        statusColor: AppColors.success,
                      ),
                      const Divider(),
                      const RecentActivityItem(
                        title: 'Complaint Escalated',
                        time: '3 hours ago',
                        statusColor: AppColors.warning,
                      ),
                      const Divider(),
                      const RecentActivityItem(
                        title: 'Overtime Approved',
                        time: 'Yesterday, 18:45',
                        statusColor: AppColors.success,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          listener: (context, state) {
            if (state is ErrorDashboardState) {
              SnackBarMessage().showSnackBar(
                message: state.message,
                backgroundColor: AppColors.error,
                context: context,
              );
            }
          },
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
