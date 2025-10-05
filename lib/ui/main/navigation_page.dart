import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/services/show_form_service.dart';
import 'package:quali_prevention_app/ui/main/1_home/home_page.dart';
import 'package:quali_prevention_app/ui/main/2_commissions/commissions_page.dart';
import 'package:quali_prevention_app/ui/main/3_prospect/new_prospect_page.dart';
import 'package:quali_prevention_app/ui/main/4_news/news_page.dart';
import 'package:quali_prevention_app/ui/main/5_products/products_page.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final ShowForm showFormService = ShowForm();
  late bool showForm;

  late GlobalKey floatingButtonKey = GlobalKey();

  late int selectedIndex;

  final List<Widget> pages = [
    const HomePage(),
    const CommissionsPage(),
    const NewProspectPage(),
    const NewsPage(),
    const ProductsPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    showForm = false;
    selectedIndex = 0;
    loadShowForm();
  }

  Future<void> loadShowForm() async {
    bool showForm = await showFormService.getShowForm();
    setState(() {
      this.showForm = showForm;
    });
  }

  Widget buildNavItem(String title, String icon, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        color: Colors.transparent,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, 0),
              child: SizedBox(
                width: 60,
                height: 50,
                child: selectedIndex == index
                    ? SvgPicture.asset('assets/svg/active/$icon.svg')
                    : SvgPicture.asset('assets/svg/inactive/$icon.svg'),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1,
                fontWeight:
                    selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
                color: selectedIndex == index ? textPrimary : textBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      color: white,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildNavItem('Accueil', 'accueil', 0),
                          buildNavItem('Commissions', 'commissions', 1),
                          const SizedBox(width: 30),
                          buildNavItem('Actus', 'actus', 3),
                          buildNavItem('Formations', 'produits', 4),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 22,
            bottom: 80,
            child: FloatingActionButton(
              key: floatingButtonKey,
              onPressed: () async {
                if (showForm) {
                  onItemTapped(2);
                } else {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'contact@mybeeacademy-sdm.fr',
                  );

                  if (await canLaunchUrl(emailLaunchUri)) {
                    await launchUrl(emailLaunchUri);
                  }
                }
              },
              shape: const CircleBorder(),
              backgroundColor: textPrimary,
              child: Icon(
                Icons.add,
                color: white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
