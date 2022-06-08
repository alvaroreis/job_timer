import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:job_timer/app/modules/project/register/project_register_module.dart';
import 'package:validatorless/validatorless.dart';

import '../project_module.dart';

class ProjectRegisterPage extends StatefulWidget {
  static const String route = '/';
  static String fullRoute = ProjectModule.route + ProjectRegisterModule.route;
  final ProjectRegisterController controller;

  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _estimateEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            Modular.to.pop();
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Ocorreu um erro ao salvar projeto').show();
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _estimateEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimativa obrigatória'),
                    Validatorless.number('Permitido somente números'),
                  ]),
                ),
                // const SizedBox(height: 10),
                // BlocSelector<ProjectRegisterController, ProjectRegisterStatus,
                //     bool>(
                //   bloc: widget.controller,
                //   selector: (state) => state == ProjectRegisterStatus.loading,
                //   builder: (context, show) {
                //     return Visibility(
                //       visible: show,
                //       child: const Center(
                //         child: CircularProgressIndicator.adaptive(),
                //       ),
                //     );
                //   },
                // ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ButtonWithLoader<ProjectRegisterController,
                      ProjectRegisterStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller.register(
                          _nameEC.text,
                          int.parse(_estimateEC.text),
                        );
                      }
                    },
                    label: 'Salvar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
