import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderBanner<T> extends StatefulWidget {
  final List<T> dataList;
  final String? Function(T data) getImage;
  final void Function(T data) onTap;
  const SliderBanner({
    Key? key,
    required this.dataList,
    required this.getImage,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SliderBanner<T>> createState() => _SliderBannerState<T>();
}

class _SliderBannerState<T> extends State<SliderBanner<T>>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: widget.dataList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
          //color: Colors.grey[400],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              //height: 200.0,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (position, reason) {
                //logger().d(reason);
                //logger().d(CarouselPageChangedReason.controller);
                _tabController.index = position;
              },
              enableInfiniteScroll: false,
            ),
            items: widget.dataList.map<Widget>((data) {
              return Builder(
                builder: (BuildContext context) {
                  var image = widget.getImage(data);
                  return InkWell(
                    onTap: () {
                      widget.onTap(data);
                    },
                    child: Container(
                        //width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: image != null
                                ? DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover)
                                : null)),
                  );
                },
              );
            }).toList(),
          ),
          TabPageSelector(
            controller: _tabController,
            indicatorSize: 10,
          )
        ],
      ),
    );
  }
}
