import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitline/core/const/appColor.dart';

Widget headerBuilder({required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeaderButton(search: false),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        _buildHeaderButton(search: true),
      ],
    ),
  );
}

Widget _buildHeaderButton({required bool search}) {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      color: AppColor.headerButton,
      border: Border.all(color: AppColor.headerButtonStroke, width: 1),
      borderRadius: BorderRadius.circular(32),
    ),
    child: Center(child: FaIcon(search == false ? Icons.arrow_back_ios_new_outlined : FontAwesomeIcons.search)),
  );
}
