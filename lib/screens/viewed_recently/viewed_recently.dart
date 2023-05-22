import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thefarmer/screens/viewed_recently/viewed_widget.dart';
import 'package:thefarmer/services/global_method.dart';
import 'package:thefarmer/services/utils.dart';
import 'package:thefarmer/widgets/back_widget.dart';
import 'package:thefarmer/widgets/empty_screen.dart';
import 'package:thefarmer/widgets/text_widget.dart';

import '../../provider/viewed_prod_provider.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();
    Color color = Utils(context).color;
    //Size size = Utils(context).getScreenSize;

    if (viewedProdItemsList.isEmpty) {
      return const EmptyScreen(
          title: 'No Viewed item',
          subtitle: 'Select item and products',
          buttonText: 'Shop Now',
          imagePath: 'assets/images/history.png');
    }
    else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Empty history',
                  subtitle: 'Confirm you want to clear history',
                  fct: () {},
                  context: context);
            },

              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'History',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
          Theme
              .of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: viewedProdItemsList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: ChangeNotifierProvider.value(
                    value: viewedProdItemsList[index],
                    child: ViewedRecentlyWidget()),
              );
            }
        ),
      );
    }
    }
}
