import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_academy_app/common/model/prospect_model.dart';
import 'package:sdm_academy_app/common/style.dart';
import 'package:sdm_academy_app/global_widgets/custom_app_bar.dart';
import 'package:sdm_academy_app/global_widgets/custom_text_button.dart';
import 'package:sdm_academy_app/global_widgets/custom_text_field.dart';
import 'package:sdm_academy_app/services/prospect_service.dart';

class NewProspectPage extends StatefulWidget {
  const NewProspectPage({super.key});

  @override
  State<NewProspectPage> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<NewProspectPage> {
  final ProspectService prospectService = ProspectService();

  late String? selectedValue = 'Type de chauffage';

  late List<String> items = <String>[
    'Type de chauffage',
    'Electrique',
    'Bois',
    'Gaz',
    'PAC',
  ];

  late FocusNode lastNameFocusNode;
  late TextEditingController lastNameController;
  late bool lastNameIsEmpty;

  late FocusNode firstNameFocusNode;
  late TextEditingController firstNameController;
  late bool firstNameIsEmpty;

  late FocusNode emailFocusNode;
  late TextEditingController emailController;
  late bool emailIsEmpty;

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

  late FocusNode surfaceFocusNode;
  late TextEditingController surfaceController;
  late bool surfaceIsEmpty;

  late FocusNode heatingTypeFocusNode;
  late TextEditingController heatingTypeController;
  late bool heatingTypeIsEmpty;

  late FocusNode annualAmountFocusNode;
  late TextEditingController annualAmountController;
  late bool annualAmountIsEmpty;

  late FocusNode commentFocusNode;
  late TextEditingController commentController;
  late bool commentIsEmpty;

  late bool optin;

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

    surfaceFocusNode = FocusNode();
    surfaceController = TextEditingController();
    surfaceIsEmpty = true;

    heatingTypeFocusNode = FocusNode();
    heatingTypeController = TextEditingController();
    heatingTypeIsEmpty = true;

    annualAmountFocusNode = FocusNode();
    annualAmountController = TextEditingController();
    annualAmountIsEmpty = true;

    commentFocusNode = FocusNode();
    commentController = TextEditingController();
    commentIsEmpty = true;

    optin = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Filleul'),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,
            bottom: 170,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ajouter un filleul',
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
                    /*Divider(
                      color: grey,
                      height: 1,
                    ),
                    CustomTextField(
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
                    /*CustomTextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      focusNode: surfaceFocusNode,
                      controller: surfaceController,
                      labelText: 'Superficie',
                      icon: Icons.multiple_stop_rounded,
                      onChanged: (value) {
                        setState(() {
                          surfaceIsEmpty = value.isEmpty;
                        });
                      },
                      onUnfocus: () => surfaceFocusNode.unfocus(),
                      isEmpty: surfaceIsEmpty,
                    ),
                    Divider(
                      color: grey,
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            selectedValue ?? 'Choisir',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: item == selectedValue
                                            ? FontWeight.w800
                                            : FontWeight.w400,
                                        color: primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 300,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: primaryBackground,
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: primary,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: primaryBackground,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: WidgetStateProperty.all(6),
                              thumbVisibility: WidgetStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: grey,
                      height: 1,
                    ),
                    CustomTextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      focusNode: annualAmountFocusNode,
                      controller: annualAmountController,
                      labelText: 'Montant annuel',
                      icon: Icons.euro_rounded,
                      onChanged: (value) {
                        setState(() {
                          annualAmountIsEmpty = value.isEmpty;
                        });
                      },
                      onUnfocus: () => annualAmountFocusNode.unfocus(),
                      isEmpty: annualAmountIsEmpty,
                    ),*/
                    Divider(
                      color: grey,
                      height: 1,
                    ),
                    CustomTextField(
                      maxLines: 5,
                      focusNode: commentFocusNode,
                      controller: commentController,
                      labelText: 'Commentaire',
                      icon: Icons.comment,
                      onChanged: (value) {
                        setState(() {
                          commentIsEmpty = value.isEmpty;
                        });
                      },
                      onUnfocus: () => commentFocusNode.unfocus(),
                      isEmpty: commentIsEmpty,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        'Cette personne m’a autorisé à communiquer ses informations personnelles auprès de SDM Academy',
                        style: GoogleFonts.poppins(
                          color: darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Switch(
                        activeColor: const Color(0xff7FAF00),
                        activeTrackColor: const Color(0xff7FAF00),
                        overlayColor:
                            WidgetStateProperty.all(const Color(0xff7FAF00)),
                        hoverColor:
                            optin ? const Color(0xff7FAF00) : Colors.white,
                        thumbColor: optin
                            ? WidgetStateProperty.all(Colors.white)
                            : null,
                        value: optin,
                        onChanged: (value) {
                          setState(() {
                            optin = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                isEnabled: !lastNameIsEmpty &&
                    !firstNameIsEmpty &&
                    !emailIsEmpty &&
                    !phoneIsEmpty &&
                    /*!addressIsEmpty &&
                    !postalCodeIsEmpty &&
                    !cityIsEmpty &&
                    !surfaceIsEmpty &&
                    items.indexOf(selectedValue!) != 0 &&
                    !annualAmountIsEmpty &&
                    !commentIsEmpty &&*/
                    optin,
                onPressed: () async {
                  Prospect prospect = Prospect(
                    civility: '1',
                    lastName: lastNameController.text,
                    firstName: firstNameController.text,
                    email: emailController.text,
                    mobilePhone: phoneController.text,
                    /*address: addressController.text,
                    postalCode: postalCodeController.text,
                    city: cityController.text,
                    surface: int.parse(surfaceController.text),
                    typeChauffage: items.indexOf(selectedValue!),
                    factureParAn: int.parse(annualAmountController.text),*/
                    comment: commentController.text,
                  );
                  print(prospect.toJson());
                  await prospectService.createProspect(prospect).then(
                    (value) async {
                      print(value);

                      await Fluttertoast.showToast(
                        msg: value
                            ? 'Prospect ajouté avec succès'
                            : 'Erreur lors de l\'ajout du prospect',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 3,
                        backgroundColor: value ? Colors.green : Colors.red,
                        textColor: white,
                        fontSize: 18.0,
                      );

                      await Navigator.pushReplacementNamed(context, '/home');
                    },
                  );
                },
                text: 'Envoyer',
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
            ],
          ),
        ),
      ),
    );
  }
}
