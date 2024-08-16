import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_newsapp_api/providers/theme_provider.dart';
import 'package:flutter_newsapp_api/screens/bookmark_screen.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset('assets/images/newspaper.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Flexible(
                    child: Text('News App'),
                  ),
                ],
              ),
            ),
            ListTileItem(
              icon: IconlyBold.home,
              text: "Home",
              fn: () {},
            ),
            ListTileItem(
              icon: IconlyBold.bookmark,
              text: "Bookmark",
              fn: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const BookmarkScreen(),
                        type: PageTransitionType.rightToLeft));
              },
            ),
            Divider(),
            SwitchListTile(
                title: Text(
                  themeProvider.getDarkTheme ? 'Dark' : 'Light',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                secondary: Icon(
                  themeProvider.getDarkTheme
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                value: themeProvider.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeProvider.setDarkTheme = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class ListTileItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function fn;
  const ListTileItem({
    super.key,
    required this.icon,
    required this.text,
    required this.fn,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: () {
        fn();
      },
    );
  }
}
