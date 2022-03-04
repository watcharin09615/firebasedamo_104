import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebasedamo/pages/registor.dart';
import 'package:firebasedamo/pages/showproduct.dart';
import 'package:firebasedamo/service/auth_service.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Form(
        child: ListView(
          children: [
            input(_email, false, 'email'),
            input(_password, true, 'password'),
            login(),
            loginwithgoogle(),
            registorformButton()
          ],
        ),
      ),
    );
  }
  Container registorformButton() {
    return Container(
      child: TextButton(
        onPressed: () {
           var route = MaterialPageRoute(builder:(context) => const RegistorPage(),
            );
            Navigator.push(context, route);
        },
        child: const Text('ลงทะเบียน'),
      ),
    );
  }

  SizedBox login() {
    return SizedBox(
      width: 130,
      height: 45,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        ),
        onPressed: () {
          siginWithEmail(_email.text, _password.text);
            var route = MaterialPageRoute(
              builder: (context) => const ShowProductPage(),
            );
            Navigator.push(context, route);
        },
        child: const Text('เข้าสู่ระบบ'),
      ),
    );
  }

  Container loginwithgoogle() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: GoogleAuthButton(
        onPressed: () {
          signInWithGoogle();
        },
        darkMode: false,
      ),
    );
  }

  Container input(a,b,c) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: TextFormField(
        controller: a,
        obscureText: b,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter ' + c;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.blue,
          ),
          label: Text(
            c,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}