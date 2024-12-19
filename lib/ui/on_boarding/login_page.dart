import 'package:flutter/material.dart';
import 'package:log_pass/data/local/dbHelper.dart';
import 'package:log_pass/ui/homePage.dart';
import 'package:log_pass/ui/on_boarding/sing_up_page.dart';

class LoginPage extends StatelessWidget {
  var emaiController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Email
          TextField(
            controller: emaiController,
            decoration: getTextField(),
          ),

          SizedBox(
            height: 11,
          ),

          ///  Pass
          TextField(
            controller: passController,
            decoration: getTextField()
                .copyWith(hintText: 'enter your password', labelText: 'pass'),
          ),

          SizedBox(
            height: 11,
          ),

          ElevatedButton(
              onPressed: () async {
                DbHelper dbHelper = DbHelper.getInstance();

                if (emaiController.text.isNotEmpty &&
                    passController.text.isNotEmpty) {
                  if (await dbHelper.authentication(
                      emailDA: emaiController.text.toString(),
                      passDA: passController.text.toString())) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('email/ passwors hua nai ,punor try kora')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Fill hua nai khalitahi bur so, aru try kora!!')));
                }
              },
              style: OutlinedButton.styleFrom(),
              child: Text('login')),

          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 20,
            width: double.infinity,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingUpPage(),
                      ));
                },
                child: Text('create newuser'),
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration getTextField() {
    return InputDecoration(
        labelText: ' email',
        hintText: 'Enter your email',
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(21)));
  }
}
