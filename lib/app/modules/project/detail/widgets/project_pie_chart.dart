import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  final int totalTasks;
  final int projectEstimate;

  const ProjectPieChart(
      {Key? key, required this.totalTasks, required this.projectEstimate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _residual = projectEstimate - totalTasks;
    final theme = Theme.of(context);
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: totalTasks.toDouble(),
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '${totalTasks}h',
                  titleStyle: TextStyle(
                    color: theme.scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: _residual.toDouble(),
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '${_residual}h',
                  titleStyle: TextStyle(
                    color: theme.scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
