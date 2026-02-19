import 'package:frontend/controller/banner_controller.dart';
import 'package:frontend/model/banner.dart';
import 'package:frontend/provider/bannerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  final PageController _pageController = PageController();



  void _fetchBanner()async{
    final BannerController bannerController = BannerController();
    final banners = await bannerController.loadbanner();
    ref.read(bannerProvider.notifier).setBanner(banners);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchBanner();
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child:  Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: banners.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      final BannerModel banner = banners[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            banner.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                if (banners.isNotEmpty)
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: banners.length,
                    effect: WormEffect(), // Optional
                  ),
              ],
      )

    );
  }
}

