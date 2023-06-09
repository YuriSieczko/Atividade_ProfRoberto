import 'package:flutter/material.dart';
import 'package:login_with_sqllite/components/list_view.dart';

import '../common/routes/view_routes.dart';
import '../external/database/db_sql_lite.dart';
import '../model/user_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //final _formKey = GlobalKey<FormState>();
  final _userLoginController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  late final UserModel user;

  final db = SqlLiteDb();

  List<UserModel> users = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    db.getAllUser().then((list) {
      setState(() {
        users = list!;
      });
    });
  }

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
        title: const Text('Administrador'),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: users.length,
        itemBuilder: (context, index) {
          if (users.isEmpty) {
            return const Center(
              child: Text(
                'Lista vazia',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return UserListView(users: users, index: index);
          }
        },
      ),
    );
  }
}
