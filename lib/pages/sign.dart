

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {

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
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                title: Text('Sign', style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email'
                  ),
                  onChanged: (text){
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
                        onPressed: (){
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )
                  ),
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
                        onPressed: isLogin || email.isEmpty || password.isEmpty ? null : () async {
                          setState(() {
                            isLogin = true;
                          });
                          FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeAuth(),
                          ));
                          setState(() {
                            isLogin = false;
                          });
                        },
                        child: isLogin ? CircularProgressIndicator() : Text('Sign'),
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
