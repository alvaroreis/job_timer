import 'package:flutter/material.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_module.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';

import '../project_module.dart';

class ProjectDetailPage extends StatelessWidget {
  static const String route = '/';
  static String fullRoute = ProjectModule.route + ProjectDetailModule.route;
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProjectDetailAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: ProjectPieChart(),
                ),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(JobTimerIcons.ok_circled2_1),
                  label: const Text('Finalizar Projeto'),
                  style: ElevatedButton.styleFrom(primary: Colors.green[800]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
