import 'dart:math';

import 'package:aithena/config/network/api.state.dart';
import 'package:aithena/config/utils/preety.dio.dart';
import 'package:aithena/data/db/db.dart';
import 'package:aithena/data/model/client.req.dart';
import 'package:aithena/data/model/client.res.dart';
import 'package:aithena/data/model/login.req.dart';
import 'package:aithena/data/model/login.res.dart';
import 'package:aithena/screens/home.page.dart';
import 'package:aithena/screens/regiterSchool.page.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late final ClientInitRes clientSecret;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callSecret();
  }

  void callSecret() async {
    final api = APIStateNetwork(await xxxUrlEncoder());
    setState(() async {
      clientSecret = await api.getCLientSecret(
        ClientInitBody(ip: generateRandomString(30)),
      );
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool btnLoder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left Side: Login Form
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 80,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back 👋",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Today is a new day. It's your day. You shape it.\nSign in to start managing your projects.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Email",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "example@email.com",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Password",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                // Add login logic here
                                setState(() {
                                  btnLoder = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  final api = APIStateNetwork(
                                    await xxxUrlEncoder(),
                                  );

                                  try {
                                    final respone = await api.login(
                                      LoginRequest(
                                        grantType: "password",
                                        username: _emailController.text,
                                        password: _passwordController.text,
                                        scope: "",
                                        clientId: clientSecret.clientId,
                                        clientSecret: clientSecret.clientSecret,
                                      ),
                                    );
                                    setState(() {
                                      btnLoder = false;
                                    });
                                    final data = LoginRes.fromJson(respone.response.data);
                                    HiveService().saveData("user", {
                                      "token": data.accessToken,
                                      "tokenType": data.tokenType,
                                      "type": data.type,
                                      "_id": data.id,
                                    
                                    }, "@AUTH");
                                    Flushbar(
                                      message: respone.response.data["message"],
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                      flushbarPosition: FlushbarPosition
                                          .TOP, // 👈 top position
                                      borderRadius: BorderRadius.circular(10),
                                      margin: EdgeInsets.all(10),
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ).show(context).then((_) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => DashboardScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    });
                                  } catch (e) {
                                    print("fale");
                                    setState(() {
                                      btnLoder = false;
                                    });

                                    Flushbar(
                                      message: "Invalid credentials",
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      flushbarPosition: FlushbarPosition
                                          .TOP, // 👈 top position
                                      borderRadius: BorderRadius.circular(10),
                                      margin: EdgeInsets.all(10),
                                      icon: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    ).show(context);
                                  }
                                }
                              },
                              child: btnLoder == true
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Sign In",
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't you have an account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          SchoolRegisterPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Right Side: Image / Art
              if (constraints.maxWidth > 900)
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage("assets/images/LoginArt.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

String generateRandomString(int length) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(
    length,
    (index) => chars[rand.nextInt(chars.length)],
  ).join();
}
