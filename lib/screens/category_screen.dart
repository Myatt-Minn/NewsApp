import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_newsapp_api/models/article_model.dart';

import 'package:flutter_newsapp_api/services/API_Handler.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:flutter_newsapp_api/widgets/article_widget.dart';
import 'package:flutter_newsapp_api/widgets/empty_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryname;
  const CategoryScreen({super.key, required this.categoryname});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<List<ArticleModel>> getNews() async {
    List<ArticleModel> cateogories =
        await ApiHandler.getCategory(widget.categoryname);
    return cateogories;
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'News Related to Category',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(fontSize: 22, letterSpacing: 0.6, color: color)),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
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
          }),
    );
  }
}
