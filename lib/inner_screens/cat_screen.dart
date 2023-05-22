import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thefarmer/provider/products_provider.dart';
import 'package:thefarmer/widgets/back_widget.dart';
import 'package:thefarmer/widgets/empty_products_widget.dart';

import '../consts/contss.dart';
import '../models/products_model.dart';
import '../services/utils.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProdcutSearch = [];
  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productByCat = productsProvider.findByCategory(catName);

    return Scaffold(
      appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: TextWidget(
            text: catName,
            color: color,
            textSize: 22,
            isTitle:true,)
      ),
      body: productByCat.isEmpty
          ? const EmptyProdWidget(
        text: 'No Products belong to this Category',
      )

      : SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (valuee){
                  setState(() {
                    listProdcutSearch =
                        productsProvider.searchQuery(valuee);
                  });
                },
                decoration: InputDecoration
                  (focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 1)
                ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  hintText: "Search for farm product",
                  prefixIcon: Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: (){
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                        Icons.close,
                        color: _searchTextFocusNode.hasFocus? Colors.red : color),
                  ),
                ),
              ),
            ),
          ),
          _searchTextController!.text.isNotEmpty &&
          listProdcutSearch.isEmpty
              ? const EmptyProdWidget(
              text: 'No products found, please try another keyword')
          : GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            // crossAxisSpacing: 10,
            childAspectRatio: size.width / (size.height * 0.61),
            children: List.generate(
                _searchTextController!.text.isNotEmpty
                    ? listProdcutSearch.length
                    : productByCat.length, (index) {
              return ChangeNotifierProvider.value(
                value: _searchTextController!.text.isNotEmpty
                    ? listProdcutSearch[index]
                    : productByCat[index],
                child: const FeedsWidget(),
              );
            }),
          ),
        ],),
      ),
    );
  }
}
