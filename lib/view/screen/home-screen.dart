import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitline/core/const/appColor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/face-image-name.dart';
import '../widget/product-card.dart';

ValueNotifier<int> tempIndex = ValueNotifier(100);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.initialPage == 10) {
        _pageController.jumpToPage(0);
      }
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 65,
              title: _buildAppBar(),
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 10,
                  onPageChanged: (value) {
                    if (value == 9) {
                      _pageController.jumpToPage(0);
                    }
                  },
                  itemBuilder: (context, index) {
                    return _buildBannerPromotion(
                      image: 'images/fruit${index + 1}.png',
                      isProduct: index == 0 ? true : false,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 10,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xff0C1305),
                      dotColor: Color(0xffB3B3B3),
                      dotHeight: 6,
                    ), // your preferred effect
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'دسته بندی ها 😊',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'همه',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: ShowModalCategory(categoriesData: categoriesData),
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
                    productName: categoriesData[index].values.first,
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

class ShowModalCategory extends SliverPersistentHeaderDelegate {
  List<Map<String, dynamic>> categoriesData;

  ShowModalCategory({required this.categoriesData});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: shrinkOffset == 0 ? Colors.transparent : Colors.white,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesData.length,
          itemBuilder: (context, index) {
            String imagePath = categoriesData[index + 1].keys.first;
            String fruitName = categoriesData[index + 1].values.first;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoriesItem(
                  imagePath: imagePath,
                  fruitName: fruitName,
                  index: index,
                ),
                Text(fruitName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 132;

  @override
  double get minExtent => 132;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    throw UnimplementedError();
  }
}

Widget _buildAppBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColor.primaryPistachio,
          ),
          child: const Center(
              child: FaIcon(
            CupertinoIcons.square_grid_2x2,
            color: AppColor.primaryGreen,
            size: 30,
          )),
        ),
        const SizedBox(width: 12),
        const Text('خانه',
            style: TextStyle(
              fontSize: 22,
              color: AppColor.primaryGreen,
              fontWeight: FontWeight.bold,
            )),
        const Spacer(),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColor.primaryPistachio,
          ),
          child: Center(child: Image.asset('images/notif.png')),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColor.primaryPistachio,
          ),
          child: Center(
            child: badges.Badge(
              badgeStyle: const badges.BadgeStyle(badgeColor: AppColor.primaryGreen),
              badgeContent: const Text('3', style: TextStyle(color: Colors.white, fontSize: 15)),
              child: Image.asset('images/cart.png'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.amber.withOpacity(0.8),
          ),
          child: Center(
              child: Image.asset(
            'images/profile.png',
          )),
        ),
      ],
    ),
  );
}

Widget _buildSearchBar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    height: 50,
    child: const TextField(
      textAlign: TextAlign.end,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: '... جست و جو',
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: FaIcon(FontAwesomeIcons.search),
        ),
      ),
    ),
  );
}

Widget _buildBannerPromotion({required String image, required bool isProduct}) {
  return Container(
    height: 160,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: AppColor.lightPink,
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(image),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom: 10,
          right: 10,
          child: Visibility(
            visible: isProduct,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryGreen.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {},
                child: const Text('سفارش بده',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.lightWhite,
                      fontWeight: FontWeight.w800,
                    ))),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoriesItem({
  required String fruitName,
  required String imagePath,
  required int index,
}) {
  return GestureDetector(
    onTap: () {
      tempIndex.value = index;
    },
    child: ValueListenableBuilder<int>(
      valueListenable: tempIndex,
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: value == index ? AppColor.primaryGreen.withOpacity(0.8) : AppColor.cardGrey,
            borderRadius: BorderRadius.circular(55),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // if (index == 0) ...{
              //   Icon(CupertinoIcons.square_grid_2x2_fill, color: value == index ? AppColor.lightWhite : Colors.black),
              //   Text('همه',
              //       style: TextStyle(
              //         color: value == index ? AppColor.lightWhite : Colors.black,
              //         fontSize: 22,
              //         fontWeight: FontWeight.w700,
              //       )),
              // } else ...{
              Image.asset('images/${imagePath}-cat.png', width: 45, height: 45),
              // },
            ],
          ),
        );
      },
    ),
  );
}
