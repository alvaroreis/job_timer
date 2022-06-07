import 'package:flutter/material.dart';
import 'package:job_timer/app/modules/project/register/project_register_module.dart';
import 'package:validatorless/validatorless.dart';

import '../project_module.dart';

class ProjectRegisterPage extends StatefulWidget {
  static const String route = '/';
  static String full_route = ProjectModule.route + ProjectRegisterModule.route;

  const ProjectRegisterPage({Key? key}) : super(key: key);

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
    return Scaffold(
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
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {}
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
