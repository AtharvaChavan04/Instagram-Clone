import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/constants/utils/colors.dart';
import 'package:instagram_clone/constants/utils/utils.dart';
import 'package:instagram_clone/model/resources/auth_methods.dart';
import 'package:instagram_clone/view/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/view/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/view/responsive/web_screen_layout.dart';
import 'package:instagram_clone/view/screens/login_screen.dart';
import 'package:instagram_clone/view/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      bio: _bioController.text,
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKUAAACUCAMAAADF0xngAAAAM1BMVEW6urr////T09O3t7f8/Pz09PTBwcH5+fnExMS9vb3i4uLc3Nzx8fHt7e3Hx8fY2NjNzc2XjyMWAAADg0lEQVR4nO2bDXOzIAzHgaDyIuj3/7QPaLtp26eKYNBb/ttu613b/S4hIZCUMRKJRCKRSCRSWekPf11OsFRtmDfp8AWglTCu6aSUXeOMUDqQ6ksZFbQwveRLyd4IfSGLArTDD6J8/MygQ3sZ17f2gbY05uOhtG1tvFm24d/U2NqAwdut4/IrpeSurex1EN0GZMTsRE1MAMt3QIZn2JpBZDcIf1VxcZrdkJybSowwJEByPlTxOYgkSM6rhJDaju6lQqSrCpSOb8f3EpJzhw9puUwxJY9PRw/09vu2+JmzQd7TwaS4+wEZ0hFqAAFLt+QkhokJ+zedtSwmpT6wKic1mAcMkbomn5ICkTJlA18LcTs/koYeQnS5P+rwII8VP8l1xlJoNUdI6YejBy+xg8uwpUOjPB48IXzQ8nqXQdlhQd6DUmdRYiXMPEokyJt4/B4xfpN8ebwkQjxU3GMfZz6D0mNBZtWXiIfdW9TqkHHuQTxEHnY5psN1xnkc86ir0y9gplfg9vtucU/EmDqyMhvse1awyR6XskKjIr3kqHAXDCq1yuxUhev/UHOk3f7XafPdot/Dpu18nzllvd4ZS6k6KkLuzkcS9ab6HXNXdYRaCX3EVNt509VIQS+YsDm3UX8MJhY56lsdZxW7wDxZBIDWNp/Wp2zsNFhSHXIWxNmsV8c3cTarurPXAqb9as7Na9R23m4Be8wKTr8uiUj6gwK48DDrBKRb5cdRDHbWIMbRq3ZKprX5JkI9joNxffM2bCJl0zszjF5XNWz4334wIUPOUP/ZIkP2NINndUCBKeFWw6vvtlw+cELhOl/HnVu45DOkE3FXx9nU49C3N8eaKZ3x03j4+QIY58L3wD1RkBsxVij4ZFe/2NOdPm4ArcmYhnga1Zw8zjzmtM1+1YwnMk4H2wK2PPfom7cg1zqpAx3CpiBkCPYzggh8XJL57p4V36crjwlevn2gIwsyfhfG1BDv0UsZ8oe0KXzpEVviZSGn9yvbLM/qiH9T0dbKWNqOT8mC6V2XzUFLuWJpM/ECPU3FrtuhP5GyL0SZNaaxrUL3xFmDOdsqlI18ySLjXV2ZeZMzYyeqTPycldGfKpLZdV98b1yrL5Eyk3u3qSryGarTdsenSuySJ2fLqAIZ8y6Up3v8D9mSKImSKImSKImSKImSKImSKImSKImSKImSKImSKImyCuU/40AykmCNS/MAAAAASUVORK5CYII=",
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
              ),
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
                      : const Text("Sign Up"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
