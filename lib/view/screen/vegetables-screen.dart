import 'package:flutter/material.dart';

import '../widget/face-image-name.dart';
import '../widget/header-screen-widget.dart';
import '../widget/product-card.dart';

class Vegetables_Screen extends StatefulWidget {
  const Vegetables_Screen({super.key});

  @override
  State<Vegetables_Screen> createState() => _Vegetables_ScreenState();
}

class _Vegetables_ScreenState extends State<Vegetables_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: headerBuilder(title: 'سبزیجات'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: productImagePathList.length,
                  (context, index) => buildProductCardItem(
                    imagePath: productImagePathList[index],
                    productName: categoriesData[index].keys.first,
                    price: 24000,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
