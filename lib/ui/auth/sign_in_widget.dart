import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_text_button.dart';
import 'package:quali_prevention_app/global_widgets/custom_text_field.dart';
import 'package:quali_prevention_app/services/auth_service.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late FocusNode emailFocusNode;
  late TextEditingController emailController;
  late bool emailIsEmpty;
  late FocusNode passwordFocusNode;
  late TextEditingController passwordController;
  late bool passwordIsEmpty;
  late bool isLoading;
  late String? errorMessage;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    emailController = TextEditingController();
    emailIsEmpty = true;
    passwordFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordIsEmpty = true;
    isLoading = false;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._çéà$&+=?,/:!*%#-]+@[a-zA-Z0-9._çéà$&+=?,/:!*%#-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _login() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Vérification du format de l'email
    if (!_isValidEmail(emailController.text)) {
      setState(() {
        isLoading = false;
        errorMessage = 'Le format de l\'adresse e-mail est invalide';
      });

      await Fluttertoast.showToast(
        msg: 'Le format de l\'adresse e-mail est invalide',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      return;
    }

    final authService = AuthService();

    try {
      final token = await authService.getAccessToken(
        emailController.text,
        passwordController.text,
      );

      if (!mounted) {
        return;
      }

      if (token == null) {
        setState(() {
          isLoading = false;
          errorMessage =
              'Identifiants incorrects. Vérifiez votre e-mail et votre mot de passe.';
        });

        await Fluttertoast.showToast(
          msg:
              'Identifiants incorrects. Vérifiez votre e-mail et votre mot de passe.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
        return;
      }

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
        errorMessage =
            'Impossible de se connecter pour le moment. Veuillez réessayer.';
      });

      await Fluttertoast.showToast(
        msg: 'Impossible de se connecter pour le moment. Veuillez réessayer.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 100, color: white),
            Container(
              decoration: BoxDecoration(
                color: primaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Connexion',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          controller: emailController,
                          labelText: 'Adresse e-mail',
                          icon: Icons.email,
                          onChanged: (value) {
                            setState(() {
                              emailIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => emailFocusNode.unfocus(),
                          isEmpty: emailIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          isObscure: true,
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          labelText: 'Mot de passe',
                          icon: Icons.lock,
                          onChanged: (value) {
                            setState(() {
                              passwordIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => passwordFocusNode.unfocus(),
                          isEmpty: passwordIsEmpty,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextButton(
                    isLoading: isLoading,
                    isEnabled: !emailIsEmpty && !passwordIsEmpty,
                    onPressed: () => _login(),
                    text: 'Se connecter',
                    backgroundColor: secondary,
                    disabledColor: Colors.grey.withOpacity(0.4),
                    textColor: Colors.white,
                    disabledTextColor: Colors.grey,
                    enabledBorder: BorderSide(
                      color: const Color(0xFF2F52A9).withOpacity(0.4),
                      width: 2,
                    ),
                    disabledBorder: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async =>
                              await Navigator.pushReplacementNamed(
                            context,
                            '/sign_up',
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                            backgroundColor: Colors.transparent,
                            overlayColor: primary.withOpacity(0.5),
                          ),
                          child: Text(
                            'Pas encore de compte ? S\'inscrire',
                            style: GoogleFonts.poppins(
                              color: darkGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        /*const SizedBox(width: 10),
                        Container(
                          width: 1,
                          height: 16,
                          color: darkGrey,
                        ),
                       const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(100, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                            backgroundColor: Colors.transparent,
                            overlayColor: primary.withOpacity(0.5),
                          ),
                          child: Text(
                            'Mot de passe oublié',
                            style: GoogleFonts.poppins(
                              color: darkGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
