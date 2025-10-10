import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/model/product_model.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_app_bar.dart';
import 'package:quali_prevention_app/services/product_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductService productService = ProductService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
    print("PRODUCTS PAGE INIT");
    print(products);
  }

  Future<void> loadProducts() async {
    List<Product>? productsData = await productService.getAllProducts();
    products = productsData ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Formations'),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  products.isEmpty
                      ? Container(height: 500)
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            Product product = products[index];

                            return GestureDetector(
                              onTap: () async => await Navigator.pushNamed(
                                context,
                                '/product_detail',
                                arguments: {'productId': product.id},
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 185,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 25,
                                        bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
          (product.icon.isNotEmpty)
                                            ? Image.network(
            product.icon,
                                                alignment: Alignment.centerLeft,
                                                width: 50,
                                                height: 50,
                                              )
                                            : Image.asset(
                                                'assets/icon-logo-quali.png',
                                                width: 50,
                                                height: 50,
                                              ),
                                        const SizedBox(height: 20),
                                        Text(
                                          product.name,
                                          softWrap: true,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: textPrimary,
                                            height: 1,
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
                                      onPressed: () async =>
                                          await Navigator.pushNamed(
                                        context,
                                        '/product_detail',
                                        arguments: {'productId': product.id},
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color: textPrimary.withOpacity(0.2),
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color(0xFFCADEE4)),
                                      ),
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: textPrimary,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
