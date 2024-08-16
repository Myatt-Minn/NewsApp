import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_newsapp_api/consts/vars.dart';
import 'package:flutter_newsapp_api/models/article_model.dart';
import 'package:flutter_newsapp_api/screens/search_screen.dart';
import 'package:flutter_newsapp_api/services/API_Handler.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:flutter_newsapp_api/widgets/article_widget.dart';
import 'package:flutter_newsapp_api/widgets/drawer_widget.dart';
import 'package:flutter_newsapp_api/widgets/loading_widget.dart';
import 'package:flutter_newsapp_api/widgets/tab_widget.dart';
import 'package:flutter_newsapp_api/widgets/topTrending.dart';
import 'package:flutter_newsapp_api/widgets/topTrendingLoading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<ArticleModel>> getNews() async {
    List<ArticleModel> articles = await ApiHandler.getData(limit: "10");
    return articles;
  }

  Future<List<ArticleModel>> gettop() async {
    List<ArticleModel> trendings = await ApiHandler.getTopTrending();
    return trendings;
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  var newstype = NewsType.allNews;
  int currentpageindex = 0;
  String sortBy = SortByEnum.publishedAt.name;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'News App',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(fontSize: 22, letterSpacing: 0.6, color: color)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const SearchScreen(),
                      type: PageTransitionType.rightToLeft));
            },
            icon: const Icon(IconlyLight.search),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              TabWidget(
                color: newstype == NewsType.allNews
                    ? Theme.of(context).cardColor
                    : Colors.transparent,
                text: "All news",
                fontsize: newstype == NewsType.allNews ? 22 : 18,
                function: () {
                  if (newstype == NewsType.allNews) {
                    return;
                  }
                  setState(() {
                    newstype = NewsType.allNews;
                  });
                },
              ),
              SizedBox(
                width: 25,
              ),
              TabWidget(
                color: newstype == NewsType.topTrending
                    ? Theme.of(context).cardColor
                    : Colors.transparent,
                text: "Top Trending",
                fontsize: newstype == NewsType.topTrending ? 22 : 18,
                function: () {
                  if (newstype == NewsType.topTrending) {
                    return;
                  }
                  setState(() {
                    newstype = NewsType.topTrending;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        newstype == NewsType.allNews
            ? SizedBox(
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaginationButtons(
                      text: "Pre",
                      function: () {
                        if (currentpageindex == 0) {
                          return;
                        }
                        setState(() {
                          currentpageindex--;
                        });
                      },
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: ((context, index) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: currentpageindex == index
                                    ? Colors.blue
                                    : Theme.of(context).cardColor,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentpageindex = index;
                                      });
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text('${index + 1}'))),
                              ),
                            ));
                          })),
                    ),
                    PaginationButtons(
                      text: "Next",
                      function: () {
                        if (currentpageindex == 4) {
                          return;
                        }
                        setState(() {
                          currentpageindex++;
                        });
                      },
                    ),
                  ],
                ),
              )
            : Container(),
        const SizedBox(
          height: 12,
        ),
        newstype == NewsType.topTrending
            ? Container()
            : Align(
                alignment: Alignment.centerRight,
                child: Material(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                        value: sortBy,
                        items: dropdownItems,
                        onChanged: (String? value) {}),
                  ),
                ),
              ),
        newstype == NewsType.topTrending
            ? FutureBuilder(
                future: gettop(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Toptrendingloading();
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  return SizedBox(
                    height: size.height * 0.5,
                    child: Swiper(
                        autoplay: true,
                        autoplayDelay: 3000,
                        layout: SwiperLayout.STACK,
                        itemWidth: size.width * 0.9,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const Toptrending());
                        }),
                  );
                })
            : Expanded(
                child: FutureBuilder(
                    future: getNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ChangeNotifierProvider.value(
                                    value: snapshot.data![index],
                                    child: const ArticleWidget()));
                          });
                      // return ListView.builder(
                      //     itemCount: snapshot.data!.length,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //           padding: const EdgeInsets.all(8),
                      //           child: ChangeNotifierProvider.value(
                      //               value: snapshot.data![index],
                      //               child: const ArticleWidget()));
                      //     });
                    }),
              )
      ]),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItem = [
    DropdownMenuItem(
      value: SortByEnum.publishedAt.name,
      child: Text(SortByEnum.publishedAt.name),
    ),
    DropdownMenuItem(
      value: SortByEnum.popularity.name,
      child: Text(SortByEnum.popularity.name),
    ),
    DropdownMenuItem(
      value: SortByEnum.relevancy.name,
      child: Text(SortByEnum.relevancy.name),
    ),
  ];
  return menuItem;
}

class PaginationButtons extends StatelessWidget {
  final String text;
  final Function function;
  const PaginationButtons({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          function();
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(8),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue),
        child: Text(text));
  }
}
