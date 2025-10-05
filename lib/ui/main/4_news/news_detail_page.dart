import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/model/news_model.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_app_bar.dart';
import 'package:quali_prevention_app/services/news_service.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final NewsService newsService = NewsService();

  late News? article = News(
    id: 0,
    title: '',
    image: '',
    description: '',
    shortDescription: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  late int articleId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadArticle({required int articleId}) async {
    article = await newsService.getArticleById(articleId: articleId);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>?;
    if (arguments != null) {
      articleId = arguments['articleId'] ?? 0;
      _loadArticle(articleId: articleId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Actualités'),
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
                  left: 20, right: 20, top: 25, bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                            article?.image != null && article!.image.isNotEmpty
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            article == null ? '' : article!.title,
                            style: GoogleFonts.poppins(
                              color: textPrimary,
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Flexible(
                            child: Text(
                              article == null ? '' : article!.description!,
                              style: GoogleFonts.poppins(
                                color: textBlack,
                                fontSize: 18,
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
            ),
          ],
        ),
      ),
    );
  }
}
