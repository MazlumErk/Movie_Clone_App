import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app_clone/Styles/TextStyles.dart';
import 'package:movie_app_clone/Styles/ContainerDecorations.dart';
import 'package:movie_app_clone/Styles/LoginTextFieldDecorations.dart';
import 'package:movie_app_clone/Data/hiveboxs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController passwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FittedBox(
                    child: Text(
                      'Movie',
                      style: TextStyles.titleTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  LoginInputBox("Name", nameController),
                  LoginInputBox("Password", passwController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              if (nameController.text != '' &&
                                  passwController != '') {
                                Map<String, dynamic> userData = {};
                                CollectionReference usersCollection =
                                    FirebaseFirestore.instance
                                        .collection('users');
                                QuerySnapshot users =
                                    await usersCollection.get();
                                for (var doc in users.docs) {
                                  userData[doc.id.toString()] = doc.data();
                                  print(userData[doc.id]["name"]);
                                  if (nameController.text.toString() ==
                                      userData[doc.id]["name"]) {
                                    if (passwController.text.toString() ==
                                        userData[doc.id]["passw"]) {
                                      hiveboxs.userBox.put("isUserLogin", true);
                                      hiveboxs.userBox.put('name',
                                          nameController.text.toString());
                                      hiveboxs.userBox.put('passw',
                                          passwController.text.toString());
                                      Navigator.of(context)
                                          .pushReplacementNamed('/home');
                                    }
                                  }
                                  print(hiveboxs.userBox.get("isUserLogin"));
                                }
                              } else {
                                final InputboxIsEmpty = SnackBar(
                                  content: Text(
                                      'Please make sure to enter the required information!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(InputboxIsEmpty);
                              }
                            },
                            child: Text("Login")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              if (nameController.text != '' &&
                                  passwController != '') {
                                var docUser = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc();
                                await docUser.set({
                                  'name': nameController.text.toString(),
                                  'passw': passwController.text.toString(),
                                  'id': docUser.id
                                });
                              } else{
                                final InputboxIsEmpty = SnackBar(
                                  content: Text(
                                      'Please make sure to enter the required information!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(InputboxIsEmpty);
                              }
                            },
                            child: Text("Register")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding LoginInputBox(
      String inputName, TextEditingController inputTextController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
      child: Container(
        decoration: ContainerDecorations.loginInputboxDecoration,
        padding: EdgeInsets.all(10),
        child: Center(
          child: TextField(
            controller: inputTextController,
            decoration: InputDecoration(
              labelText: inputName,
              labelStyle: TextStyles.loginInputLabelTextStyle,
              focusedBorder:
                  LoginTextFieldDecorations.loginTextFieldFocusedBorder,
              enabledBorder:
                  LoginTextFieldDecorations.loginTextFieldEnabledBorder,
            ),
          ),
        ),
      ),
    );
  }
}
