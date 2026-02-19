import 'package:frontend/views/widgets/banner_widget.dart';
import 'package:frontend/views/widgets/category_widget.dart';
import 'package:frontend/views/widgets/header_widget.dart';
import 'package:frontend/views/widgets/reuseable_text_widget.dart';
import 'package:frontend/views/widgets/toprated_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/popular_product_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * .20),
          child: const HeaderWidget2()
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(),
            CategoryWidget(),
            ReuseableTextWidget(title: "Popular Products",subtitle: "",),
            PopularProductWidget(),
            ReuseableTextWidget(title: "Top Rated Products",subtitle: "",),
            TopratedProductWidget(),
          ],
        ),
      ),
    );
  }
}

