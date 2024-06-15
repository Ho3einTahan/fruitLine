import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitline/core/const/appColor.dart';

Widget headerBuilder({required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    child: Row(
      children: [
        _buildHeaderButton(),
        const SizedBox(width: 110),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildHeaderButton() {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      color: AppColor.headerButton,
      border: Border.all(color: AppColor.headerButtonStroke, width: 1),
      borderRadius: BorderRadius.circular(32),
    ),
    child: const Center(child: FaIcon(Icons.arrow_back_ios_new_outlined)),
  );
}
