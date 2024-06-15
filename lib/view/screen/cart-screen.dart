import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../core/class/model/cart.dart';
import '../../core/const/appColor.dart';
import '../../core/function/convert-number-to-kg.dart';
import '../widget/header-screen-widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartBox = Hive.box<Cart>('cart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            headerBuilder(title: 'سبد خرید'),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: cartBox.listenable(),
                builder: (context, value, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(thickness: 0.4),
                    itemCount: cartBox.values.length,
                    itemBuilder: (context, index) {
                      final item = cartBox.getAt(index);
                      return _buildProductItem(
                        index: index,
                        fruitName: item!.fruitName,
                        price: item.price.toString(),
                        imgAddress: item.imageAddress,
                      );
                    },
                  );
                },
              ),
            ),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required String fruitName,
    required String price,
    required String imgAddress,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: imgAddress,
            height: 70,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Column(
            children: [
              Text(
                fruitName,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fruitName.length > 13 ? 18 : 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                price.extractNumber().seRagham(separator: ','),
                style: const TextStyle(
                  color: AppColor.priceRed,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildAdd_MinusProductCounterButton(index),
        ],
      ),
    );
  }

  Widget _buildAdd_MinusProductCounterButton(int index) {
    return InputQty(
      maxVal: 100,
      initVal: cartBox.getAt(index)?.count ?? 1,
      minVal: 1,
      steps: 1,
      validator: (value) {
        List<String> numberList = value.toString().split('');
        String weight = convertNumberToWeight_Kg(numberList: numberList);
        return weight;
      },
      onQtyChanged: (count) {
        if (count > 0) {
          final cartItem = cartBox.getAt(index) as Cart;
          print('Updating item at index $index with count $count');
          cartBox.putAt(index, Cart(count: count, fruitName: cartItem.fruitName, imageAddress: cartItem.imageAddress, price: cartItem.price));
        }
      },
      decoration: QtyDecorationProps(
        border: InputBorder.none,
        plusBtn: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColor.primaryGreen,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: FaIcon(FontAwesomeIcons.plus, color: AppColor.lightWhite),
          ),
        ),
        minusBtn: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColor.cardGrey,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: FaIcon(FontAwesomeIcons.minus, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return GestureDetector(
      onTap: () {
        print('Checkout button tapped');
      },
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
          color: AppColor.addToCart,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Center(
          child: Text(
            'ثبت سفارش',
            style: TextStyle(color: AppColor.lightWhite, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
