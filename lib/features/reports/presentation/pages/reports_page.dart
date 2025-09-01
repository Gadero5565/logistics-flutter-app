// features/reports/presentation/pages/reports_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/theme/app_colours.dart';
import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:logistics_app/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:logistics_app/injection.dart' as di;

class ReportsPage extends StatefulWidget {
  final int userId;

  const ReportsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Reports'),
      ),
      body: BlocProvider(
        create: (context) => di.sl<ReportsBloc>()..add(GetReportsDataEvent(userId: widget.userId)),
        child: BlocConsumer<ReportsBloc, ReportsState>(
          listener: (context, state) {
            if (state is ErrorReportsState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingReportsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedReportsState) {
              return _buildReportsContent(state.dashboardData);
            } else if (state is ErrorReportsState) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildReportsContent(DashboardEntity dashboardData) {
    // Calculate total requests for percentage calculations
    final totalRequests = dashboardData.dashboardCards.fold<int>(
      0,
          (sum, card) => sum + card.cardIntValue,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request Status Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: PieChart(
              PieChartData(
                sections: _buildPieChartSections(dashboardData.dashboardCards, totalRequests),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Request Types Comparison',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 250,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: BarChart(
              BarChartData(
                barGroups: _buildBarChartGroups(dashboardData.categoryCounts),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < dashboardData.categoryCounts.length) {
                          final category = dashboardData.categoryCounts[value.toInt()];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              category.categoryName,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Status Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusSummary(dashboardData.dashboardCards),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      List<DashboardCardsEntity> dashboardCards, int totalRequests) {
    final statusColors = {
      'Draft': AppColors.statusPending,
      'In Progress': AppColors.info,
      'Done': AppColors.success,
      'Urgent': AppColors.error,
    };

    return dashboardCards.map((card) {
      final percentage = totalRequests > 0
          ? (card.cardIntValue / totalRequests * 100).round()
          : 0;

      return PieChartSectionData(
        value: card.cardIntValue.toDouble(),
        color: statusColors[card.cardName] ?? AppColors.primary,
        title: '$percentage%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<BarChartGroupData> _buildBarChartGroups(List<CategoryEntity> categoryCounts) {
    return categoryCounts.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: category.requestCount.toDouble(),
            color: _getBarColor(index),
            width: 15,
          )
        ],
      );
    }).toList();
  }

  Color _getBarColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.info,
      AppColors.warning,
      AppColors.secondary,
      AppColors.primaryLight,
    ];
    return colors[index % colors.length];
  }

  Widget _buildStatusSummary(List<DashboardCardsEntity> dashboardCards) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: dashboardCards.map((card) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.cardName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  card.cardIntValue.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}