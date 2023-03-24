import 'package:flutter/material.dart';

/**
 * Helper class to hold diferent transition models
 */

class Transition extends PageRouteBuilder {
  Transition({required Widget pagina})
      : super(
            opaque: true,
            pageBuilder: (BuildContext context, _, __) {
              return pagina;
            },
            transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            });
}
