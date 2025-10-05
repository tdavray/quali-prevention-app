import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_academy_app/common/model/news_model.dart';
import 'package:sdm_academy_app/common/style.dart';
import 'package:sdm_academy_app/global_widgets/custom_app_bar.dart';
import 'package:sdm_academy_app/services/news_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsService newsService = NewsService();
  List<News> articles = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    loadNews(page: currentPage);
  }

  Future<void> loadNews({required int page}) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    List<News>? newArticles = await newsService.getNewsArticles(
      page: page,
      perPage: 4,
    );

    if (newArticles!.isNotEmpty) {
      // Incrémente currentPage d'abord
      currentPage++;
      setState(() {
        articles.addAll(newArticles);
        articles.sort((a, b) => a.id.compareTo(b.id));
        hasMore = newArticles.length ==
            4; // si on reçoit moins de 4 articles, il n'y a plus de données à charger
        isLoading = false;
      });
    } else {
      setState(() {
        hasMore = false;
        isLoading = false;
      });
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Actus',
                    style: GoogleFonts.poppins(
                      color: textPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  articles.isEmpty
                      ? Container(height: 500)
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: articles.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            News article = articles[index];
                            return GestureDetector(
                              onTap: () async => await Navigator.pushNamed(
                                context,
                                '/news_detail',
                                arguments: {'articleId': article.id},
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 140,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(28),
                                              bottomLeft: Radius.circular(28),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            child: Image.network(
                                              'https://crm.mybeeacademy-sdm.fr${article.image}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(28),
                                                bottomRight:
                                                    Radius.circular(28),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  article.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    color: textPrimary,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Flexible(
                                                  child: Text(
                                                    article.shortDescription,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: GoogleFonts.poppins(
                                                      color: textBlack,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.1,
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
                                      onPressed: () async =>
                                          await Navigator.pushNamed(
                                        context,
                                        '/news_detail',
                                        arguments: {'articleId': article.id},
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color: textPrimary.withOpacity(0.2),
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(28),
                                              bottomRight: Radius.circular(28),
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
                  const SizedBox(height: 20),
                  if (hasMore && articles.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        loadNews(page: currentPage);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.transparent,
                        overlayColor: primary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: textPrimary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  color: textPrimary, strokeWidth: 2),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Voir plus',
                                  style: GoogleFonts.poppins(
                                    color: textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: textPrimary,
                                  size: 16,
                                ),
                              ],
                            ),
                    ),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
