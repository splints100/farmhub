import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thefarmer/provider/products_provider.dart';
import 'package:thefarmer/provider/wishlist_provider.dart';
import 'package:thefarmer/services/global_method.dart';
import 'package:thefarmer/widgets/text_widget.dart';

import '../../inner_screens/product_details.dart';
import '../../models/wishlist_model.dart';
import '../../provider/products_provider.dart';
import '../../services/utils.dart';
import '../../widgets/heart_btn.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final getCurrProduct = productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductDetails.routeName,
                  arguments: wishlistModel.productId);
            },
          child: Container (
            height: size.height*0.20,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: color, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    //width: size.width * 0.2,
                    height: size.width * 0.25,
                    child:FancyShimmerImage(
                      imageUrl: getCurrProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Flexible(
                      child: Row(children: [
                        IconButton(
                          onPressed: (){},
                          icon: Icon(IconlyLight.bag2,
                              color: color
                          ),
                        ),
                        HeartBTN(
                          productId: getCurrProduct.id,
                          isInWishlist: _isInWishlist,
                        )
                      ],
                      ),
                    ),

                      TextWidget(
                        text: getCurrProduct.title,
                        color: color,
                        textSize: 20.0,
                        maxLines: 1,
                        isTitle: true,
                      ),
                    const SizedBox(
                        height: 5),
                    TextWidget(
                      text: '\$${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18.0,
                      maxLines: 2,
                      isTitle: true
                    ),
                  ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
