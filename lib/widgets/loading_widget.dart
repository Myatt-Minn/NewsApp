import 'package:flutter/material.dart';
import 'package:flutter_newsapp_api/consts/vars.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  late Color baseShimmer, widgetShimmer, highlightShimmer;
  @override
  void didChangeDependencies() {
    baseShimmer = Utils(context).baseShimmerColor;
    widgetShimmer = Utils(context).widgetShimmerColor;
    highlightShimmer = Utils(context).highlightShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8),
                child: ArticleShimmerEffect(
                    baseShimmer: baseShimmer,
                    highlightShimmer: highlightShimmer,
                    widgetShimmer: widgetShimmer,
                    size: size));
          }),
    );
  }
}

class ArticleShimmerEffect extends StatelessWidget {
  const ArticleShimmerEffect({
    super.key,
    required this.baseShimmer,
    required this.highlightShimmer,
    required this.widgetShimmer,
    required this.size,
  });

  final Color baseShimmer;
  final Color highlightShimmer;
  final Color widgetShimmer;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
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
            child: Shimmer.fromColors(
              baseColor: baseShimmer,
              highlightColor: highlightShimmer,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        color: widgetShimmer,
                        width: size.height * 0.12,
                        height: size.height * 0.12),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: widgetShimmer),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height * 0.04,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: widgetShimmer),
                        ),
                        Row(children: [
                          ClipOval(
                            child: Container(
                              width: 35,
                              height: 35,
                              color: widgetShimmer,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: size.height * 0.04,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: widgetShimmer),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
