import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/bloc/book_bloc.dart';
import 'package:firebase_test/pages/add.dart';
import 'package:firebase_test/pages/sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBloc(),
        )
      ],
      child: MaterialApp(
        initialRoute: FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
        routes: {
          'login': (context) => LoginPage(),
          'sign': (context) => SignPage(),
          'home': (context) => HomeAuth(),
          'add': (context) => AddPage()
        },
      )));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool showPassword = false;
  bool isLogin = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'My App',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffix: IconButton(
                        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )),
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ElevatedButton(
                        onPressed: isLogin || email.isEmpty || password.isEmpty
                            ? null
                            : () async {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(email: email, password: password);
                                Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
                              },
                        child: isLogin ? CircularProgressIndicator() : Text('Log in'),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text('Google'),
                onPressed: () async {
                  // Trigger the authentication flow
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                  // Obtain the auth details from the request
                  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                  // Create a new credential
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );

                  // Once signed in, return the UserCredential
                  await FirebaseAuth.instance.signInWithCredential(credential);
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignPage(),
                          ));
                        },
                        child: Text('Sign up'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
