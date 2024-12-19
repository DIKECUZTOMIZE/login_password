import 'package:flutter/material.dart';
import 'package:log_pass/data/local/dbHelper.dart';
import 'package:log_pass/data/local/model/userModel.dart';
import 'package:log_pass/ui/on_boarding/login_page.dart';

class SingUpPage extends StatefulWidget {
  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var phNoNameController = TextEditingController();
  var passNameController = TextEditingController();
  var confirompassNameController = TextEditingController();
  var addressNameController = TextEditingController();

  bool isPassVisible = false;
  bool comfrimIsPassVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Name
                TextField(
                  controller: userNameController,
                  decoration: getTextField(),
                ),

                SizedBox(
                  height: 11,
                ),

                /// email
                TextField(
                  controller: emailController,
                  decoration: getTextField().copyWith(
                      hintText: 'Enter your email', labelText: 'email'),
                ),

                SizedBox(
                  height: 11,
                ),

                /// phon No:
                TextField(
                  controller: phNoNameController,
                  decoration: getTextField().copyWith(
                      hintText: 'Enter your mobilNoe', labelText: 'number'),
                ),

                SizedBox(
                  height: 11,
                ),

                /// Adress:
                TextField(
                  controller: addressNameController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: getTextField().copyWith(
                      hintText: 'Enter your adres', labelText: 'addr'),
                ),

                SizedBox(
                  height: 11,
                ),

                /// Password:
                TextField(
                  controller: passNameController,
                  obscureText: !isPassVisible,
                  obscuringCharacter: '*',
                  decoration: getTextField().copyWith(
                      hintText: 'password',
                      labelText: 'pass',
                      suffixIcon: SizedBox(
                        height: 20,
                        child: InkWell(
                          onTap: () {
                            isPassVisible = !isPassVisible;
                            setState(() {});
                          },
                          child: isPassVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      )),
                ),

                SizedBox(
                  height: 11,
                ),

                /// conFirm
                TextField(
                  controller: confirompassNameController,
                  obscureText: !comfrimIsPassVisible,
                  obscuringCharacter: '*',
                  decoration: getTextField().copyWith(
                      hintText: 'confirmPass',
                      labelText: 'confirm pass',
                      suffixIcon: SizedBox(
                          height: 20,
                          child: InkWell(
                            onTap: () {
                              comfrimIsPassVisible = !comfrimIsPassVisible;
                              setState(() {});
                            },
                            child: comfrimIsPassVisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ))),
                ),

                SizedBox(
                  height: 11,
                ),
                ElevatedButton(
                    onPressed: () async {
                      DbHelper dbhelper = DbHelper.getInstance();
                      if (userNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phNoNameController.text.isNotEmpty &&
                          passNameController.text.isNotEmpty &&
                          confirompassNameController.text.isNotEmpty &&
                          addressNameController.text.isNotEmpty) {
                        if (passNameController.text ==
                            confirompassNameController.text) {
                          if (await dbhelper.checkIfEmailAllreadyExits(
                              emailDC: emailController.text.toString())) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               backgroundColor: Colors.deepPurpleAccent,
                                content:
                                    Text('Email ase agore so, login kora')));
                          }
                          else {
                            bool check = await dbhelper.registerNewUser(
                                UserModel(
                                    nameU: userNameController.text,
                                    emailU: emailController.text,
                                    phNoU: phNoNameController.text,
                                    passU: passNameController.text,
                                    created_atU: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    adressU: addressNameController.text));

                           // Navigator.pop(context);
                            if (check) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Successfull hoi tumar registertu!!')));

                              // Navigator.pop(context);
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => LoginPage()));


                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text(
                                      'register faild hoi so , punor register kora')));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orangeAccent,
                              content: Text('passwprd match hua nai')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'Fill hua nai val dore aru punor try kora!!')));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    child: Text('sing up')),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                  width: 100,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('login'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration getTextField() {
    return InputDecoration(
        hintText: 'Enter your name',
        labelText: 'name',
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(21)));
  }
}
