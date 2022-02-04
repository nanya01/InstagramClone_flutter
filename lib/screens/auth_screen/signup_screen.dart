import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/auth/auth_service.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _pwdControlller = TextEditingController();
  final TextEditingController _bioControlller = TextEditingController();
  final TextEditingController _usernameControlller = TextEditingController();
  String image = 'assets/images/ic_instagram.svg';
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthService().signupUser(
        email: _emailControlller.text,
        password: _pwdControlller.text,
        username: _usernameControlller.text,
        bio: _bioControlller.text,
        file: _image!);

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(

          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res, Colors.red);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailControlller.dispose();
    _pwdControlller.dispose();
    _bioControlller.dispose();
    _usernameControlller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 64,
            horizontal: 32,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(),
                  flex: 1,
                ),
                SvgPicture.asset(
                  image,
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textEditingController: _usernameControlller,
                    hintText: 'Enter your username',
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _emailControlller,
                    hintText: 'Enter your Email',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _pwdControlller,
                  hintText: 'Enter your Password',
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _bioControlller,
                    hintText: 'Enter your bio',
                    textInputType: TextInputType.multiline),
                const SizedBox(height: 24),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Sign up'),
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
                      child: const Text('Already have an account?'),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(),
                  flex: 1,
                ),
              ])),
        ),
      ),
    );
  }
}
