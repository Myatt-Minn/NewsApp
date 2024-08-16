import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType {
  allNews,
  topTrending,
}

enum SortByEnum {
  relevancy,
  popularity,
  publishedAt,
}

TextStyle smallText = GoogleFonts.montserrat(fontSize: 15);

List<String> searchItems = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
];
