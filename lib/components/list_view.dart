import 'package:flutter/material.dart';
import 'package:login_with_sqllite/model/user_model.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key, required this.users, required this.index});

  final List<UserModel> users;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    users[index].userId,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    users[index].userName,
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  Text(
                    users[index].userEmail,
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
