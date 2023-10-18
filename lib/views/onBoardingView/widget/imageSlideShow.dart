import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../ViewModel/onBoarding_viewModel.dart';
import '../../../utils/app_String.dart';

class PhotoSlideshow extends StatefulWidget {
  const PhotoSlideshow({super.key});

  @override
  State<PhotoSlideshow> createState() => _PhotoSlideshowState();
}

class _PhotoSlideshowState extends State<PhotoSlideshow> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Positioned(
      left: 0,
      child: Stack(
        children: [
          SizedBox(
            width: screen.width * 0.65,
            height: screen.height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double imageSizeHeight = constraints.maxHeight;
                double imageSizeWidth = constraints.maxWidth;
                return CarouselSlider(
                    items: context
                        .read<OnboardingViewModel>()
                        .slideImage
                        .map((image) => Image.asset(
                              image,
                              fit: BoxFit.cover,
                              height: imageSizeHeight,
                              width: imageSizeWidth,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: screen.height,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      autoPlay: true,
                      onPageChanged: (index, autoPlay) {
                        setState(() {
                          _count = index;
                        });
                      },
                    ));
              },
            ),
          ),
          Container(
            width: screen.width * 0.65,
            height: screen.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [Colors.black.withOpacity(0), Colors.black87],
              ),
            ),
          ),
          SizedBox(
            width: screen.width * 0.65,
            height: screen.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screen.width * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.onBoardingContent1,
                          style: TextStyle(
                            color: Color(0xFFFEFEFE),
                            fontSize: 28,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          AppStrings.onBoardingContent2,
                          style: TextStyle(
                            color: Color(0xFFFEFEFE),
                            fontSize: 18,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: screen.height * 0.02,
                        ),
                        SizedBox(
                          width: 185.0,
                          height: 16.0,
                          child: ListView.builder(
                            itemCount: context.read<OnboardingViewModel>().slideImage.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: index == _count ? 32.0 : 16.0,
                                height: 16,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFEFEFE),
                                  shape: index == _count
                                      ? RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        )
                                      : const OvalBorder(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screen.height * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
