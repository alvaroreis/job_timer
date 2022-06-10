import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/detail_appbar.dart';
import 'controller/task_controller.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;

  const TaskPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _durationEC.dispose();
    _nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (TaskStatus.failure == state) {
          return AsukaSnackbar.alert('Ocorreu um erro ao salvar task.').show();
        } else if (TaskStatus.success == state) {
          Modular.to.pop();
        }
      },
      child: Scaffold(
        appBar: DetailAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: 'Criar nova task',
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _durationEC,
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('Permitido somente números'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ButtonWithLoader(
                    bloc: widget.controller,
                    selector: (state) => TaskStatus.loading == state,
                    label: 'Salvar',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller.register(
                          name: _nameEC.text,
                          duration: int.parse(_durationEC.text),
                        );
                      }
                    },
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
