import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_module.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import '../project_module.dart';

class ProjectDetailPage extends StatelessWidget {
  static const String route = '/';
  static String fullRoute = ProjectModule.route + ProjectDetailModule.route;
  final ProjectDetailController controller;

  const ProjectDetailPage({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Ocorreu um erro interno').show();
          }
        },
        builder: (context, state) {
          var projectModel = state.projectModel;
          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando...'),
              );

            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );

            case ProjectDetailStatus.failure:
              if (null != projectModel) {
                return _BuildProjectDetail(
                  projectModel: projectModel,
                  controller: controller,
                );
              }
              return const Center(
                child: Text('Erro ao carregar projeto.'),
              );
            case ProjectDetailStatus.complete:
              return _BuildProjectDetail(
                projectModel: projectModel!,
                controller: controller,
              );
          }
        },
      ),
    );
  }
}

class _BuildProjectDetail extends StatelessWidget {
  final ProjectModel projectModel;
  final ProjectDetailController controller;
  const _BuildProjectDetail(
      {required this.projectModel, required this.controller});

  @override
  Widget build(BuildContext context) {
    final _totalTask = projectModel.taks
        .fold<int>(0, (taskValue, task) => taskValue += task.duration);

    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(projectModel: projectModel),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ProjectPieChart(
                  projectEstimate: projectModel.estimate,
                  totalTasks: _totalTask,
                ),
              ),
              ...projectModel.taks
                  .map((project) => ProjectTaskTile(project: project))
                  .toList(),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Visibility(
                visible: projectModel.status != ProjectStatus.finalizado,
                child: ElevatedButton.icon(
                  onPressed: controller.finish,
                  icon: const Icon(JobTimerIcons.ok_circled2_1),
                  label: const Text('Finalizar Projeto'),
                  style: ElevatedButton.styleFrom(primary: Colors.green[800]),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
