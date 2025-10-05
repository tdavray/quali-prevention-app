import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/model/product_model.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_app_bar.dart';
import 'package:quali_prevention_app/services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductService productService = ProductService();

  late Product? product = Product(
    id: 0,
    name: '',
    icon: '',
    createdAt: '',
    updatedAt: '',
  );

  late int productId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadProduct({required int productId}) async {
    product = await productService.getProductById(productId: productId);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>?;
    if (arguments != null) {
      productId = arguments['productId'] ?? 0;
      _loadProduct(productId: productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Produit'),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 25, bottom: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product!.name,
                    style: GoogleFonts.poppins(
                      color: textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Accordion(
                      disableScrolling: true,
                      scaleWhenAnimating: false,
                      openAndCloseAnimation: true,
                      paddingListTop: 0,
                      paddingListHorizontal: 0,
                      headerBackgroundColorOpened: Colors.white,
                      headerPadding: const EdgeInsets.all(20),
                      headerBorderRadius: 0,
                      contentBorderWidth: 0,
                      contentBorderRadius: 0,
                      contentVerticalPadding: 0,
                      contentHorizontalPadding: 0,
                      paddingBetweenClosedSections: 1,
                      paddingBetweenOpenSections: 1,
                      paddingListBottom: 0,
                      children: [
                        AccordionSection(
                          isOpen: false,
                          headerBackgroundColor: white,
                          contentBackgroundColor: white,
                          leftIcon: SvgPicture.asset(
                            'assets/svg/products/duree.svg',
                            width: 30,
                            height: 30,
                          ),
                          rightIcon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: primary),
                          header: Text(
                            'Durée',
                            style: GoogleFonts.poppins(
                              color: textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffDCE5E7).withOpacity(0.5),
                                    white.withOpacity(0.5)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (product!.titleFonctionnement != null)
                                  Text(
                                    product!.titleFonctionnement!,
                                    style: GoogleFonts.poppins(
                                      color: textBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (product!.titleFonctionnement != null)
                                  const SizedBox(height: 10),
                                Text(
                                  product!.descriptionFonctionnement ?? '',
                                  style: GoogleFonts.poppins(
                                    color: textBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product!.imageFonctionnement != null)
                                  const SizedBox(height: 20),
                                if (product!.imageFonctionnement != null &&
                                    product!.imageFonctionnement!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      'https://crm.mybeeacademy-sdm.fr${product?.imageFonctionnement}',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        AccordionSection(
                          isOpen: false,
                          headerBackgroundColor: white,
                          contentBackgroundColor: white,
                          leftIcon: SvgPicture.asset(
                            'assets/svg/products/modules.svg',
                            width: 30,
                            height: 30,
                          ),
                          rightIcon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: primary),
                          header: Text(
                            'Modules',
                            style: GoogleFonts.poppins(
                              color: textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffDCE5E7).withOpacity(0.5),
                                    white.withOpacity(0.5)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (product!.titleReferences != null)
                                  Text(
                                    product!.titleReferences!,
                                    style: GoogleFonts.poppins(
                                      color: textBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (product!.titleReferences != null)
                                  const SizedBox(height: 10),
                                Text(
                                  product?.descriptionReferences ?? '',
                                  style: GoogleFonts.poppins(
                                    color: textBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product!.imageReferences != null)
                                  const SizedBox(height: 20),
                                if (product!.imageReferences != null &&
                                    product!.imageReferences!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      'https://crm.mybeeacademy-sdm.fr${product?.imageReferences}',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        AccordionSection(
                          isOpen: false,
                          headerBackgroundColor: white,
                          contentBackgroundColor: white,
                          leftIcon: SvgPicture.asset(
                            'assets/svg/products/objectifs.svg',
                            width: 30,
                            height: 30,
                          ),
                          rightIcon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: primary),
                          header: Text(
                            'Objectifs',
                            style: GoogleFonts.poppins(
                              color: textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffDCE5E7).withOpacity(0.5),
                                    white.withOpacity(0.5)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (product!.titlePrix != null)
                                  Text(
                                    product!.titlePrix!,
                                    style: GoogleFonts.poppins(
                                      color: textBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (product!.titlePrix != null)
                                  const SizedBox(height: 10),
                                Text(
                                  product!.descriptionPrix ?? '',
                                  style: GoogleFonts.poppins(
                                    color: textBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product!.imagePrix != null)
                                  const SizedBox(height: 20),
                                if (product!.imagePrix != null &&
                                    product!.imagePrix!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      'https://crm.mybeeacademy-sdm.fr${product?.imagePrix}',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        AccordionSection(
                          isOpen: false,
                          headerBackgroundColor: white,
                          contentBackgroundColor: white,
                          leftIcon: SvgPicture.asset(
                            'assets/svg/products/arguments.svg',
                            width: 30,
                            height: 30,
                          ),
                          rightIcon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: primary),
                          header: Text(
                            'Arguments',
                            style: GoogleFonts.poppins(
                              color: textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffDCE5E7).withOpacity(0.5),
                                    white.withOpacity(0.5)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (product!.titleArguments != null)
                                  Text(
                                    product!.titleArguments!,
                                    style: GoogleFonts.poppins(
                                      color: textBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (product!.titleArguments != null)
                                  const SizedBox(height: 10),
                                Text(
                                  product!.descriptionArguments ?? '',
                                  style: GoogleFonts.poppins(
                                    color: textBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product!.imageArguments != null)
                                  const SizedBox(height: 20),
                                if (product!.imageArguments != null &&
                                    product!.imageArguments!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      'https://crm.mybeeacademy-sdm.fr${product?.imageArguments}',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
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
