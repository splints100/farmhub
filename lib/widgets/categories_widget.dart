import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thefarmer/inner_screens/cat_screen.dart';
import 'package:thefarmer/provider/dark_theme_provider.dart';
import 'package:thefarmer/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedcolor})
      : super(key: key);
 final String catText, imgPath;
 final Color passedcolor;


  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
  final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: catText);
      },
      child: Container (
        //height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedcolor.withOpacity(0.7),width: 2)
        ),
        child: Column (children: [
          Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                  imgPath,
                    ),
                fit:BoxFit.fill)),
          ),
          TextWidget(text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
          ),
        ],
        ),
      ),
    );
  }
}
