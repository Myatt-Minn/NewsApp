import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:flutter_newsapp_api/widgets/article_widget.dart';
import 'package:flutter_newsapp_api/widgets/empty_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Book Mark',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(fontSize: 22, letterSpacing: 0.6, color: color)),
        ),
        centerTitle: true,
      ),
      body: const EmptyNewsWidget(
        text: "You haven't added anything to BookMark!",
        imagePath: "assets/images/bookmark.png",
      ),
    );
  }
}
