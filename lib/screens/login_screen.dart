import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';

import '../resources/auth_methods.dart';
import '../utills/color..dart';
import '../utills/utils.dart';
import '../widgets/textfield_input.dart';
import 'feed_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String textrole = '';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _auth = FirebaseAuth.instance;
  DatabaseReference dbref = FirebaseDatabase.instance.ref().child("Users");

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FeedScreen()));
      setState(() {
        _isLoading = false;
      });
    } else {
      showSnackBar('Please enter email and password correctly', context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // void _signIn() async {
  //   try {
  //     final newUser = await _auth.signInWithEmailAndPassword(
  //         email: _emailController.text, password: _passwordController.text);
  //     if (newUser != null) {
  //       //final User user = await _auth.currentUser!();
  //       //final userID = user.uid;

  //       DatabaseEvent event = await dbref
  //           .child(FirebaseAuth.instance.currentUser!.uid.toString());

  //       await dbref
  //           .child(FirebaseAuth.instance.currentUser!.uid.toString())
  //           .once()
  //           .then((DatabaseEvent snapshot) {
  //         setState(() {
  //           if (snapshot['role'] == 'Admin') {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) {
  //               return const PrescriptionPage();
  //             }));
  //           } else if (snapshot.value!['role'] == 'Doctor') {}
  //         });
  //       });
  //     } else {
  //       print("something wrong");
  //     }
  //   } catch (e) {}
  // }

  navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        // actions: [
        //   // ElevatedButton(
        //   //   onPressed: () {
        //   //     Navigator.push(
        //   //       context,
        //   //       MaterialPageRoute(builder: (context) => const UploadPage()),
        //   //     );
        //   //   },
        //   //   child: const Text(
        //   //     'Upload report',
        //   //     style:
        //   //         TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        //   //   ),
        //   // ),
        // ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              SvgPicture.asset(
                'assets/icons8-remind-app.svg',
                height: 100,
              ),
              const Text(
                'Medical Profile',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextfieldInput(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: 'Enter Your email',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextfieldInput(
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                isPass: true,
              ),
              const SizedBox(
                height: 20,
              ),
              // DropdownButtonFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Role',
              //   ),
              //   value: textrole.isNotEmpty ? textrole : null,
              //   items: <String>['Paitient', 'Doctor', 'Admin']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       child: Text(value),
              //       value: value,
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       textrole = value.toString();
              //     });
              //   },
              // ),
              // const SizedBox(
              //   height: 24.0,
              // ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                      : const Text(
                    'Log In',
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      color: Colors.teal),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       child: const Text("Are you a doctor?"),
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 8.0,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     ElevatedButton(
              //         style: ButtonStyle(
              //           padding:
              //               MaterialStateProperty.all(const EdgeInsets.all(5)),
              //           backgroundColor: MaterialStateProperty.all(Colors.teal),
              //         ),
              //         onPressed: () {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) {
              //             return const DoctorLoginPage();
              //           }));
              //         },
              //         child: const Text(
              //           'Login as a doctor',
              //           style: TextStyle(color: Colors.black),
              //         )),
              //   ],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("dont you have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  ),
                  InkWell(
                    onTap: navigateToSignUp,
                    child: Container(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              )
              //bla blal bal
            ],
          ),
        ),
      ),
    );
  }
}