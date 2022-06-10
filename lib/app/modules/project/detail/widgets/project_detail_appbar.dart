import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/routes/app_routes.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import '../controller/project_detail_controller.dart';

class ProjectDetailAppbar extends SliverAppBar {
  final ProjectModel projectModel;
  ProjectDetailAppbar({super.key, required this.projectModel})
      : super(
          expandedHeight: 100,
          toolbarHeight: 100,
          pinned: true,
          title: Text(projectModel.name),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${projectModel.taks.length}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: '  '),
                                const TextSpan(
                                  text: 'tasks',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: projectModel.status !=
                                  ProjectStatus.finalizado,
                              replacement: const Text(
                                'Projeto Finalizado',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: _NewTasks(projectModel: projectModel)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}

class _NewTasks extends StatelessWidget {
  final ProjectModel projectModel;
  const _NewTasks({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed(
          AppRoutes.project_task_page_route,
          arguments: projectModel,
        );
        Modular.get<ProjectDetailController>().update();
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          const Text('Adicionar Tasks')
        ],
      ),
    );
  }
}
