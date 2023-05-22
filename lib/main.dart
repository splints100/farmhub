import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:thefarmer/inner_screens/cat_screen.dart';
import 'package:thefarmer/inner_screens/feeds_screen.dart';
import 'package:thefarmer/inner_screens/on_sale_screen.dart';
import 'package:thefarmer/inner_screens/product_details.dart';
import 'package:thefarmer/provider/cart_provider.dart';
import 'package:thefarmer/provider/dark_theme_provider.dart';
import 'package:thefarmer/provider/orders_provider.dart';
import 'package:thefarmer/provider/products_provider.dart';
import 'package:thefarmer/provider/viewed_prod_provider.dart';
import 'package:thefarmer/provider/wishlist_provider.dart';
import 'package:thefarmer/screens/auth/forget_pass.dart';
import 'package:thefarmer/screens/auth/login.dart';
import 'package:thefarmer/screens/auth/register.dart';
import 'package:thefarmer/screens/btm_bar.dart';
import 'package:thefarmer/screens/cart/payment_screen.dart';
import 'package:thefarmer/screens/home_screens.dart';
import 'package:thefarmer/screens/orders/orders_screen.dart';
import 'package:thefarmer/screens/viewed_recently/viewed_recently.dart';
import 'package:thefarmer/screens/wishlist/wishlist_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'consts/theme_data.dart';
import 'fetch_screen.dart';
import 'l10n/l10n.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey = "pk_test_51LYsXdAKzVSa6KMN3E8rkZREPPFYaQGRmdaOP9bvDUoRmcdYeVj985ac7kOw68cvpk0RquVMThUFUxmYxKUGI1vp00IqADgW67";
   Stripe.instance.applySettings();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  static final String title = 'Localization';
  const MyApp({Key?  key}) : super (key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme();
  }

 @override
 void initState() {
   getCurrentAppTheme();
    super.initState();
 }

final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
     if(snapshot.connectionState == ConnectionState.waiting){
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         home: Scaffold(
         body: Center(
           child: CircularProgressIndicator(),
         ),
       ),
         supportedLocales: L10n.all,
         localizationsDelegates: [
           AppLocalizations.delegate,
           GlobalMaterialLocalizations.delegate,
           GlobalCupertinoLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate,
         ],
       );
     } else if (snapshot.hasError) {
        const MaterialApp(debugShowCheckedModeBanner: false,
          home: Scaffold(
           body: Center (
         child: Text('An Error Occured'),
       ),
       ),);
     }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create:(_){
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(
              create: (_) => ProductsProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishlistProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ViewedProdProvider(),
            ),
            ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
            ),
          ],

            child: Consumer<DarkThemeProvider>(builder: (context , themeProvider , child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                    theme: Styles.themeData (themeProvider.getDarkTheme, context),
                  home: const FetchScreen(),
                  //home: const PaymentDemo(),
                  routes: {
                    OnSaleScreen.routeName : (ctx) => const OnSaleScreen(),
                    FeedsScreen.routeName : (ctx) => const FeedsScreen(),
                    ProductDetails.routeName : (ctx) => const ProductDetails(),
                    WishlistScreen.routeName : (ctx)=> const WishlistScreen(),
                    OrdersScreen.routeName : (ctx)=> const OrdersScreen(),
                    ViewedRecentlyScreen.routeName : (ctx)=> const ViewedRecentlyScreen(),
                    RegisterScreen.routeName : (ctx)=> const RegisterScreen(),
                    LoginScreen.routeName : (ctx)=> const LoginScreen(),
                    ForgetPasswordScreen.routeName: (ctx) =>
                    const ForgetPasswordScreen(),
                    CategoryScreen.routeName : (ctx)=> const CategoryScreen(),
                    PaymentScreen.routeName : (ctx) => const PaymentScreen(),
                  },
              );

              }),
          );
      }
    );
  }
}


// class PaymentDemo extends StatelessWidget {
//   const PaymentDemo({Key? key}) : super(key: key);
//   Future<void> initPayment(
//       {required String email,
//       required double amount,
//       required BuildContext context}) async {
//     try {
//       // 1. Create a payment intent on the server
//       final response = await http.post(
//           Uri.parse(
//               'Your function'),
//           body: {
//             'email': email,
//             'amount': amount.toString(),
//           });

//       final jsonResponse = jsonDecode(response.body);
//       log(jsonResponse.toString());
//       // 2. Initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: jsonResponse['paymentIntent'],
//         merchantDisplayName: 'Grocery Flutter course',
//         customerId: jsonResponse['customer'],
//         customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//         // testEnv: true,
//         // merchantCountryCode: 'SG',
//       ));
//       await Stripe.instance.presentPaymentSheet();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Payment is successful'),
//         ),
//       );
//     } catch (errorr) {
//       if (errorr is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured ${errorr.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured $errorr'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//         child: const Text('Pay 20\$'),
//         onPressed: () async {
//           await initPayment(
//               amount: 50.0, context: context, email: 'email@test.com');
//         },
//       )),
//     );
//   }
// }





