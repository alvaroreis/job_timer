import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/routes/app_routes.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';

import '../../../core/routes/app_routes.dart';

class HeaderProjectMenu extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  HeaderProjectMenu({required this.controller});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size.width * .45,
                height: constraints.maxHeight * .50,
                child: DropdownButtonFormField<ProjectStatus>(
                  items: ProjectStatus.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.label)))
                      .toList(),
                  onChanged: (status) {
                    if (null != status) {
                      controller.filter(status);
                    }
                  },
                  value: ProjectStatus.em_andamento,
                  hint: const Text('Selecione...'),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.all(8.0),
                    isCollapsed: true,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .45,
                height: constraints.maxHeight * .50,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      await Modular.to
                          .pushNamed(AppRoutes.project_register_page_route);
                      controller.findAll();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Novo Projeto')),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
