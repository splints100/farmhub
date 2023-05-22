import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class BackWidget extends StatefulWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  State<BackWidget> createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        Navigator.pop(context);
      },
      child: Icon(IconlyLight.arrowLeft2, color: Colors.green,),
    );
  }
}
