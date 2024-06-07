import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cloud Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email ',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  ObsecureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password ',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    var auth = FirebaseAuth.instance;
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser(auth);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login Successfully.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (err) {
                        if (err.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No user found for that email.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (err.code == 'wrong-password') {
                          //showSnackBar(context, 'wrong-password');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('wrong-password'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (err.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('email-already-in-use'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          //showSnackBar(context, 'email-already-in-use');
                        } else {
                          //Text('there was an error , Please Try again Later'),
                          //showSnackBar(context, err.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err.toString()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (err) {
                        //showSnackBar(context,'there was an error , Please Try again Later');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'there was an error , Please Try again Later'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(color: kNavButton),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(FirebaseAuth auth) async {
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
