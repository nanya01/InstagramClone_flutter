import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/auth/auth_service.dart';
import 'package:instagram_flutter/screens/auth_screen/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  String image = 'assets/images/ic_instagram.svg';
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
  }

  void loginScreen() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthService()
        .loginUser(email: _emailController.text, password: _pwdController.text);

    if (res == "success") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                image,
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _pwdController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: loginScreen,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor))
                    : Container(
                        child: const Text('Log in'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            )),
                            color: blueColor),
                      ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Don\'t have an account?'),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
