import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp_api/consts/vars.dart';
import 'package:flutter_newsapp_api/models/article_model.dart';
import 'package:flutter_newsapp_api/screens/newsDetail_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ArticleModel articleModelProvider =
        Provider.of<ArticleModel>(context);

    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FancyShimmerImage(
                        imageUrl: articleModelProvider.urlToImage.toString(),
                        boxFit: BoxFit.fill,
                        width: size.height * 0.15,
                        height: size.height * 0.15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          articleModelProvider.description.toString(),
                          style: smallText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "⏱︎ Reading time",
                            style: smallText,
                          ),
                        ),
                        Row(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: NewsdetailScreen(
                                        url:
                                            articleModelProvider.url.toString(),
                                      ),
                                      type: PageTransitionType.leftToRight));
                            },
                            icon: const Icon(
                              Icons.link,
                              color: Colors.blue,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              articleModelProvider.publishedAt.toString(),
                              style: smallText,
                              maxLines: 1,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
