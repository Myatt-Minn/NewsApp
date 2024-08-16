import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp_api/models/article_model.dart';
import 'package:flutter_newsapp_api/services/API_Handler.dart';
import 'package:provider/provider.dart';

class ArticleinfoScreen extends StatelessWidget {
  final String articleUrl;
  const ArticleinfoScreen({super.key, required this.articleUrl});
  Future<List<ArticleModel>> getNews() async {
    List<ArticleModel> articles = await ApiHandler.getData();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ArticleModel articleModelProvider =
        Provider.of<ArticleModel>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text("No data"),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  const BackButton(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articleModelProvider.aurthor.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                articleModelProvider.title.toString(),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return FancyShimmerImage(
                          width: double.infinity,
                          imageUrl: articleModelProvider.urlToImage.toString(),
                          boxFit: BoxFit.fill,
                        );
                      },

                      autoplay: true,
                      itemCount: 3,
                      pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.white,
                          activeColor: Colors.red,
                        ),
                      ),
                      // control: const SwiperControl(),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description'),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          articleModelProvider.content.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
