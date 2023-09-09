import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "assets/image/slider_image1.png",
  "assets/image/slider_image2.png",
  "assets/image/slider_image3.png",
];

class SliderView extends StatefulWidget {
  const SliderView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SliderViewState();
  }
}

class _SliderViewState extends State<SliderView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.2,
            aspectRatio: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 10.0,
              height: 10.0,
              margin:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          item,
          fit: BoxFit.cover,
        )),
  ))
      .toList();
}

