import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/model/user_model.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_text_button.dart';
import 'package:quali_prevention_app/global_widgets/custom_text_field.dart';
import 'package:quali_prevention_app/services/auth_service.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final AuthService authService = AuthService();

  late FocusNode lastNameFocusNode;
  late TextEditingController lastNameController;
  late bool lastNameIsEmpty;

  late FocusNode firstNameFocusNode;
  late TextEditingController firstNameController;
  late bool firstNameIsEmpty;

  late FocusNode emailFocusNode;
  late TextEditingController emailController;
  late bool emailIsEmpty;

  late FocusNode passwordFocusNode;
  late TextEditingController passwordController;
  late bool passwordIsEmpty;

  late FocusNode phoneFocusNode;
  late TextEditingController phoneController;
  late bool phoneIsEmpty;

  late FocusNode addressFocusNode;
  late TextEditingController addressController;
  late bool addressIsEmpty;

  late FocusNode postalCodeFocusNode;
  late TextEditingController postalCodeController;
  late bool postalCodeIsEmpty;

  late FocusNode cityFocusNode;
  late TextEditingController cityController;
  late bool cityIsEmpty;

  late FocusNode matriculeFocusNode;
  late TextEditingController matriculeController;
  late bool matriculeIsEmpty;

  late FocusNode companyNameFocusNode;
  late TextEditingController companyNameController;
  late bool companyNameIsEmpty;

  late FocusNode activityFocusNode;
  late TextEditingController activityController;
  late bool activityIsEmpty;

  @override
  void initState() {
    super.initState();
    lastNameFocusNode = FocusNode();
    lastNameController = TextEditingController();
    lastNameIsEmpty = true;

    firstNameFocusNode = FocusNode();
    firstNameController = TextEditingController();
    firstNameIsEmpty = true;

    emailFocusNode = FocusNode();
    emailController = TextEditingController();
    emailIsEmpty = true;

    passwordFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordIsEmpty = true;

    phoneFocusNode = FocusNode();
    phoneController = TextEditingController();
    phoneIsEmpty = true;

    addressFocusNode = FocusNode();
    addressController = TextEditingController();
    addressIsEmpty = true;

    postalCodeFocusNode = FocusNode();
    postalCodeController = TextEditingController();
    postalCodeIsEmpty = true;

    cityFocusNode = FocusNode();
    cityController = TextEditingController();
    cityIsEmpty = true;

    matriculeFocusNode = FocusNode();
    matriculeController = TextEditingController();
    matriculeIsEmpty = true;

    companyNameFocusNode = FocusNode();
    companyNameController = TextEditingController();
    companyNameIsEmpty = true;

    activityFocusNode = FocusNode();
    activityController = TextEditingController();
    activityIsEmpty = true;
  }

  bool _isValidEmail(String email) {
    // Expression régulière pour valider le format de l'email
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._çéà$&+=?,/:!*%#-]+@[a-zA-Z0-9._çéà$&+=?,/:!*%#-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
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
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 25,
                bottom: 75,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Inscription',
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
                          keyboardType: TextInputType.name,
                          focusNode: lastNameFocusNode,
                          controller: lastNameController,
                          labelText: 'Nom',
                          icon: Icons.person,
                          onChanged: (value) {
                            setState(() {
                              lastNameIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => lastNameFocusNode.unfocus(),
                          isEmpty: lastNameIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          focusNode: firstNameFocusNode,
                          controller: firstNameController,
                          labelText: 'Prénom',
                          icon: Icons.person,
                          onChanged: (value) {
                            setState(() {
                              firstNameIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => firstNameFocusNode.unfocus(),
                          isEmpty: firstNameIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
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
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.phone,
                          focusNode: phoneFocusNode,
                          controller: phoneController,
                          labelText: 'Téléphone',
                          icon: Icons.phone,
                          onChanged: (value) {
                            setState(() {
                              phoneIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => phoneFocusNode.unfocus(),
                          isEmpty: phoneIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        /*CustomTextField(
                          keyboardType: TextInputType.text,
                          focusNode: addressFocusNode,
                          controller: addressController,
                          labelText: 'Adresse',
                          icon: Icons.place,
                          onChanged: (value) {
                            setState(() {
                              addressIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => addressFocusNode.unfocus(),
                          isEmpty: addressIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          focusNode: postalCodeFocusNode,
                          controller: postalCodeController,
                          labelText: 'Code postal',
                          icon: Icons.place,
                          onChanged: (value) {
                            setState(() {
                              postalCodeIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => postalCodeFocusNode.unfocus(),
                          isEmpty: postalCodeIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          focusNode: cityFocusNode,
                          controller: cityController,
                          labelText: 'Ville',
                          icon: Icons.place,
                          onChanged: (value) {
                            setState(() {
                              cityIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => cityFocusNode.unfocus(),
                          isEmpty: cityIsEmpty,
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Informations complémentaires',
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
                          keyboardType: TextInputType.number,
                          focusNode: matriculeFocusNode,
                          controller: matriculeController,
                          labelText: 'Matricule Beauty Sané',
                          icon: Icons.apartment,
                          onChanged: (value) {
                            setState(() {
                              matriculeIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => matriculeFocusNode.unfocus(),
                          isEmpty: matriculeIsEmpty,
                        ),
                        /*Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          focusNode: companyNameFocusNode,
                          controller: companyNameController,
                          labelText: 'Nom de la société',
                          icon: Icons.text_format_sharp,
                          onChanged: (value) {
                            setState(() {
                              companyNameIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => companyNameFocusNode.unfocus(),
                          isEmpty: companyNameIsEmpty,
                        ),
                        Divider(
                          color: grey,
                          height: 1,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          focusNode: activityFocusNode,
                          controller: activityController,
                          labelText: 'Activité',
                          icon: Icons.work,
                          onChanged: (value) {
                            setState(() {
                              activityIsEmpty = value.isEmpty;
                            });
                          },
                          onUnfocus: () => activityFocusNode.unfocus(),
                          isEmpty: activityIsEmpty,
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextButton(
                    isEnabled: !lastNameIsEmpty &&
                        !firstNameIsEmpty &&
                        !emailIsEmpty &&
                        !passwordIsEmpty &&
                        !phoneIsEmpty,
                    /*!addressIsEmpty &&
                        !postalCodeIsEmpty &&
                        !cityIsEmpty &&
                        !matriculeIsEmpty,
                        !companyNameIsEmpty &&
                        !activityIsEmpty,*/
                    onPressed: () async {
                      // Vérification du format de l'email
                      if (!_isValidEmail(emailController.text)) {
                        await Fluttertoast.showToast(
                          msg: 'Le format de l\'adresse e-mail est invalide',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0,
                        );
                        return; // Arrête le processus si l'email est invalide
                      }

                      // Vérification du format du mot de passe
                      if (!_isValidPassword(passwordController.text)) {
                        await Fluttertoast.showToast(
                          msg:
                              'Le mot de passe doit contenir au moins 8 caractères, incluant au moins une lettre et un chiffre',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0,
                        );
                        return; // Arrête le processus si le mot de passe est invalide
                      }

                      CreateUser createuser = CreateUser(
                        lastName: lastNameController.text,
                        firstName: firstNameController.text,
                        email: emailController.text,
                        phoneNo: phoneController.text,
                        /*firstAddress: addressController.text,
                        city: cityController.text,
                        zip: postalCodeController.text,*/
                        matricule: matriculeController.text,
                        /*company: companyNameController.text,
                        activite: activityController.text,*/
                        password: passwordController.text,
                      );
                      bool value = await authService.createUser(createuser);

                      await Fluttertoast.showToast(
                        msg: value
                            ? 'Inscription réussie'
                            : 'Erreur lors de l\'ajout de l\'inscription',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 3,
                        backgroundColor: value ? Colors.green : Colors.red,
                        textColor: white,
                        fontSize: 18.0,
                      );

                      if (value) {
                        await Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    text: 'S\'inscrire',
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
                          onPressed: () async {
                            await Navigator.pushReplacementNamed(
                                context, '/sign_in');
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                            backgroundColor: Colors.transparent,
                            overlayColor: primary.withOpacity(0.5),
                          ),
                          child: Text(
                            'Déjà un compte ? Se connecter',
                            style: GoogleFonts.poppins(
                              color: darkGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
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
