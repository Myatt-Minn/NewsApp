import 'package:flutter/material.dart';
import 'package:flutter_newsapp_api/consts/vars.dart';
import 'package:flutter_newsapp_api/models/category_model.dart';
import 'package:flutter_newsapp_api/screens/category_screen.dart';
import 'package:flutter_newsapp_api/services/categorydata.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:flutter_newsapp_api/widgets/empty_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  List<CategoriesModel> categories = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    categories = getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _searchFocusNode.unfocus();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: color,
                    )),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      hintText: 'Search',
                      suffix: IconButton(
                        onPressed: () {
                          _searchFocusNode.unfocus();
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.close,
                          color: color,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onEditingComplete: () {},
                    autofocus: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: MasonryGridView.count(
                itemCount: categories.length,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(color: color),
                            borderRadius: BorderRadius.circular(18)),
                        padding: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: CategoryScreen(
                                        categoryname: categories[index].name!),
                                    type: PageTransitionType.bottomToTop));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Image.asset(categories[index].image!),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(categories[index].name!)
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            // const EmptyNewsWidget(
            //     text: "Ooops No realted articles found!",
            //     imagePath: "assets/images/search.png")
          ],
        ),
      )),
    );
  }
}
