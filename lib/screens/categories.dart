import 'package:flutter/material.dart';
import 'package:thefarmer/widgets/text_widget.dart';

import '../services/utils.dart';
import '../widgets/categories_widget.dart';

class CatergoriesScreen extends StatelessWidget {
   CatergoriesScreen({Key? key}) : super(key: key);

   List<Color> gridColors = [
     const Color(0xff53B175),
     const Color(0xffF8A44C),
     const Color(0xffF7A593),
     const Color(0xffD3B0E0),
     const Color(0xffFDE598),
     const Color(0xffB7DFF5),
   ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/cat/fruits.png',
      'catText': 'Fruits',
    },

    {
      'imgPath': 'assets/images/cat/veg.png',
      'catText': 'Vegetables',
    },

    {
      'imgPath': 'assets/images/cat/Spinach.png',
      'catText': 'Herbs',
    },

    {
      'imgPath': 'assets/images/cat/nuts.png',
      'catText': 'Nuts',
    },

    {
      'imgPath': 'assets/images/cat/spices.png',
      'catText': 'Spices',
    },

    {
      'imgPath': 'assets/images/cat/grains.png',
      'catText': 'Grains',
    },

  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: TextWidget(text: 'Categories',
      color: color,
      textSize: 24,
        isTitle: true,
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(crossAxisCount: 2,
        childAspectRatio: 240/250,
        crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index) {
          return CategoriesWidget(
            catText: catInfo[index]['catText'],
            imgPath: catInfo[index]['imgPath'],
            passedcolor: gridColors[index],

          );
          }),
        ),
      )
      );
  }
}