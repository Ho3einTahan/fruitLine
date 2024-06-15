import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitline/core/class/model/cart.dart';
import 'package:fruitline/view/screen/cart-screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../core/const/appColor.dart';
import '../../core/function/convert-number-to-kg.dart';
import '../widget/cliper-container-class.dart';
import '../widget/header-screen-widget.dart';

class ProductDetail_Screen extends StatefulWidget {
  const ProductDetail_Screen({super.key});

  @override
  State<ProductDetail_Screen> createState() => _ProductDetail_ScreenState();
}

class _ProductDetail_ScreenState extends State<ProductDetail_Screen> {
  var cartBox = Hive.box<Cart>('cart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cardGrey,
      body: SafeArea(
        child: Column(
          children: [
            headerBuilder(title: ''),
            Expanded(flex: 3, child: Image.asset('images/banana.png', width: 230, height: 230)),
            Expanded(
              flex: 7,
              child: ClipPath(
                clipper: InvertedArcClipper(),
                child: Container(
                  color: AppColor.lightWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _buildProductInfo(productName: 'موز خارجی', price: '2000', productDescription: 'موز خارجی دارای خواص زیادی میباشد .'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo({required String productName, required String price, required String productDescription}) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(productName),
              _buildAdd_MinusProductCounterButton(),
            ],
          ),
          const SizedBox(height: 6),
          Text(' کیلویی ${price.extractNumber().seRagham(separator: ",")} تومان',
              textDirection: TextDirection.rtl, style: const TextStyle(color: AppColor.priceRed, fontWeight: FontWeight.w700, fontSize: 17)),
          const SizedBox(height: 8),
          Text(productDescription, style: const TextStyle(color: AppColor.productDescription, fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureCard(imgName: 'organic', title: '100', subTitle: 'ارگانیک', isOrganaic: true),
              _buildFeatureCard(imgName: 'kalery', title: '80', subTitle: 'کالری', isOrganaic: false),
            ],
          ),
          const Spacer(),
          _buildAddToCart(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required String imgName, required String title, required String subTitle, required bool isOrganaic}) {
    return Container(
      width: 163,
      height: 80,
      decoration: BoxDecoration(
        color: AppColor.featureCard,
        border: Border.all(color: AppColor.cardGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('images/$imgName.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${title.extractNumber()}${isOrganaic ? '%' : ''}',
                style: const TextStyle(color: AppColor.primaryGreen, fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Text(
                subTitle,
                style: const TextStyle(color: AppColor.featureCardText, fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCart() {
    return GestureDetector(
      onTap: () {
        cartBox.add(
            Cart(count: 2, fruitName: 'موز', imageAddress: 'https://www.themilefarmshop.co.uk/images/shop/more/951x951_730_075614eaaa14db6aadebfffc27f74c70_1597321310redpepper.jpg', price: 25000));
        // Cart? cartInstance = cartBox.get(1);
        // print(cartInstance?.fruitName);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColor.addToCart,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Center(
            child: Text(
          'افزودن به سبد',
          style: TextStyle(color: AppColor.lightWhite, fontSize: 24, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }

  Widget _buildAdd_MinusProductCounterButton() {
    return InputQty(
      maxVal: 100,
      initVal: 1,
      minVal: 1,
      steps: 1,
      validator: (value) {
        List<String> numberList = value.toString().split('');
        String weight = convertNumberToWeight_Kg(numberList: numberList);
        return weight;
      },
      decoration: QtyDecorationProps(
        border: InputBorder.none,
        plusBtn: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(color: AppColor.primaryGreen, borderRadius: BorderRadius.circular(24)),
          child: const Center(child: FaIcon(FontAwesomeIcons.plus, color: AppColor.lightWhite)),
        ),
        minusBtn: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColor.cardGrey,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(child: FaIcon(FontAwesomeIcons.minus, color: Colors.grey)),
        ),
      ),
    );
  }
}
