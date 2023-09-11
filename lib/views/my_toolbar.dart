// @developed by @lucns

// Alternativa para AppBar, mas costumizada.

import 'package:flutter/material.dart';
import 'package:lucns_swapi/utils/app_colors.dart';

class MyToolbar {
  Widget getView(BuildContext context, String title, Function()? onBackPressed,
      Function()? onMenuPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        generateButton(Icons.arrow_back_ios, onBackPressed),
        Flexible(
            child: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        )),
        generateButton(Icons.more_vert, onMenuPressed),
      ],
    );
  }

  Widget generateButton(IconData icon, Function()? onClick) {
    if (onClick == null) {
      return const SizedBox(
          width: 60,
          height: 60,
          child: DecoratedBox(decoration: BoxDecoration(color: Colors.transparent)));
    }
    return RawMaterialButton(
        onPressed: onClick,
        elevation: 0,
        constraints: const BoxConstraints(),
        shape: const CircleBorder(),
        fillColor: Colors.transparent,
        splashColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white.withOpacity(0.4),
        highlightElevation: 0,
        padding: const EdgeInsets.all(16),
        child: Icon(icon, size: 28, color: Colors.white));
  }
}
