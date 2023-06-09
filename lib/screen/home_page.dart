import 'package:flutter/material.dart';

import '../common/routes/view_routes.dart';
import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //final _formKey = GlobalKey<FormState>();
  final _userLoginController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  late final UserModel user;

  @override
  void dispose() {
    _userLoginController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    _getUserData(user);
    super.didChangeDependencies();
  }

  _getUserData(UserModel user) async {
    setState(() {
      _userLoginController.text = user.userId;
      _userNameController.text = user.userName;
      _userEmailController.text = user.userEmail;
    });
  }

  String editar = 'editar';
 
  String sair = 'sair';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home page'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == editar) {
                Navigator.pushNamed(
                  context,
                  RoutesApp.loginUpdate,
                  arguments: user,
                );
              } else if (value == sair) {
                Navigator.pushNamed(
                  context,
                  RoutesApp.home,
                  arguments: user,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: editar,
                child: const Text('Editar'),
              ),
              PopupMenuItem(
                value: sair,
                child: const Text('Sair'),
              ),
            ],
          )
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _userLoginController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'User'),
                ),
                TextField(
                  controller: _userNameController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: _userEmailController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
