import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/register/project_register_page.dart';

class HeaderProjectMenu extends SliverPersistentHeaderDelegate {
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
                child: DropdownButtonFormField<ProjectStatus>(
                  items: ProjectStatus.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.label)))
                      .toList(),
                  onChanged: (valeu) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    isCollapsed: true,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .45,
                child: ElevatedButton.icon(
                    onPressed: () => Modular.to.pushNamed(
                          ProjectRegisterPage.fullRoute,
                        ),
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
