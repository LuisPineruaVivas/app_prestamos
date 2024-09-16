import 'package:app_prestamos/styles/colors.dart';
import 'package:flutter/material.dart';

class BusyOverlay extends StatelessWidget {
  final Widget? child;
  final String title;
  final bool show;
  final int height;
  final double opacity;

  const BusyOverlay(
      {super.key,
      this.child,
      this.title = 'Por favor espere',
      this.show = false,
      this.height = 0,
      this.opacity = 0.7});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          child!,
          IgnorePointer(
            ignoring: !show,
            child: Opacity(
              opacity: show ? 1.0 : 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: whiteColor.withOpacity(opacity),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                          color: greyColor, backgroundColor: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(title,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: height.toDouble(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
