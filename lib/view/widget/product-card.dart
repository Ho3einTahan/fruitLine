import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../core/const/appColor.dart';

Widget buildProductCardItem({required String imagePath, required String productName, required double price}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColor.cardGrey,
    ),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Image.asset('images/$imagePath.png', width: 110, height: 100),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Align(alignment: Alignment.centerRight, child: Text('نارگیل', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 16, bottom: 24),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(price.toString().extractNumber().seRagham(separator: ','), style: const TextStyle(fontSize: 16, color: AppColor.priceRed, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
          Positioned(bottom: 12, left: 12, child: _buildAddToBasketButton()),
        ],
      ),
    ),
  );
}

Widget _buildAddToBasketButton() {
  return Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      color: AppColor.primaryGreen,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Center(
      child: FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 25),
    ),
  );
}
