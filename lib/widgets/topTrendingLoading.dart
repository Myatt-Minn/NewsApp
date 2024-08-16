import 'package:flutter/material.dart';
import 'package:flutter_newsapp_api/services/utils.dart';
import 'package:shimmer/shimmer.dart';

class Toptrendingloading extends StatefulWidget {
  const Toptrendingloading({super.key});

  @override
  State<Toptrendingloading> createState() => _ToptrendingloadingState();
}

class _ToptrendingloadingState extends State<Toptrendingloading> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        child: Shimmer.fromColors(
          baseColor: baseShimmer,
          highlightColor: highlightShimmer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                    color: widgetShimmer,
                    width: double.infinity,
                    height: size.height * 0.33),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.04,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: widgetShimmer),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Container(
                      width: 35,
                      height: 35,
                      color: widgetShimmer,
                    ),
                  ),
                  Container(
                    height: size.height * 0.02,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: widgetShimmer),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
