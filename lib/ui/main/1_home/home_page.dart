import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_academy_app/common/model/news_model.dart';
import 'package:sdm_academy_app/common/model/user_model.dart';
import 'package:sdm_academy_app/common/style.dart';
import 'package:sdm_academy_app/services/auth_service.dart';
import 'package:sdm_academy_app/services/news_service.dart';
import 'package:sdm_academy_app/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();
  final NewsService newsService = NewsService();
  User? user;
  String? currentMonthCa;
  bool isLoading = true;

  News? article = News(
    id: 0,
    title: '',
    image: '',
    description: '',
    shortDescription: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    user = await userService.getUserProfile();
    article = await newsService.getFeaturedArticle();
    currentMonthCa = await userService.getUserCA(params: '?month=current');
    setState(() {});
  }

  void logout(BuildContext context) async {
    AuthService authService = AuthService();
    await authService.logout();
    Navigator.of(context).pushReplacementNamed('/sign_in');
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
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
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: user?.picture != null
                                    ? NetworkImage(
                                        'https://crm.mybeeacademy-sdm.fr${user?.picture}')
                                    : const AssetImage(
                                        'assets/placeholder-white.png'),
                                backgroundColor: white,
                                radius: 25,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Bonjour',
                                      style: GoogleFonts.poppins(
                                        color: textSecondary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      user?.name ?? '',
                                      style: GoogleFonts.poppins(
                                        color: textPrimary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async => logout(context),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF99B0C),
                            Color(0xFFFCB514),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(18),
                      height: 100,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/turnover.svg',
                            width: 50,
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'CA du mois',
                                  style: GoogleFonts.poppins(
                                    color: white,
                                    height: 1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  currentMonthCa ?? '0€',
                                  style: GoogleFonts.poppins(
                                    color: white,
                                    height: 1,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 150),
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
                    'Dernière actualité',
                    style: GoogleFonts.poppins(
                      color: textSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (article != null)
                    GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/news_detail',
                          arguments: {'articleId': article!.id},
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff623B00).withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 30,
                                  offset: const Offset(
                                    0,
                                    5,
                                  ),
                                ),
                              ],
                            ),
                            height: 150,
                            child: Row(
                              children: [
                                Container(
                                  width: 140,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(28),
                                      bottomLeft: Radius.circular(28),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(28),
                                      bottomLeft: Radius.circular(28),
                                    ),
                                    child: article?.image != null &&
                                            article!.image.isNotEmpty
                                        ? Image.network(
                                            'https://crm.mybeeacademy-sdm.fr${article!.image}',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/placeholder-white.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(28),
                                        bottomRight: Radius.circular(28),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article!.title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            color: textSecondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Flexible(
                                          child: Text(
                                            article!.shortDescription,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: GoogleFonts.poppins(
                                              color: textBlack,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            height: 30,
                            child: IconButton.filled(
                              onPressed: () async => await Navigator.pushNamed(
                                context,
                                '/news_detail',
                                arguments: {'articleId': article!.id},
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: textSecondary.withOpacity(0.2),
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(28),
                                      bottomRight: Radius.circular(28),
                                    ),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                    const Color(0xFFFEEBCE)),
                              ),
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: textSecondary,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Add some spacing before the links
                  const SizedBox(height: 20),

                  // Container for the links
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                          onPressed: () => _launchURL(
                              'https://sdmformation-mybeeacademy.fr/rgpd-application-sdm-academy/'),
                          child: Text(
                            'Voir la politique de confidentialité',
                            style: GoogleFonts.poppins(
                              color: textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchURL(
                              'https://sdmformation-mybeeacademy.fr/contact-suppression-compte-sdm-academy/'),
                          child: Text(
                            'Demande de suppression de compte',
                            style: GoogleFonts.poppins(
                              color: textSecondary,
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
