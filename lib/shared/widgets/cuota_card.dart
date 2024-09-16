import 'package:app_prestamos/styles/colors.dart';
import 'package:flutter/material.dart';

class CuotaCard extends StatefulWidget {
  final String monto;
  final String date;
  final bool isDone;

  const CuotaCard(this.monto, this.date, this.isDone, {super.key});

  @override
  State<CuotaCard> createState() => _CuotaCardState();
}

class _CuotaCardState extends State<CuotaCard> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget.isDone;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  imagen(),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.date,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Checkbox(
                                      value: isDone,
                                      activeColor: primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          isDone = !isDone;
                                        });
                                      })
                                ],
                              ),
                              Text(
                                'Monto: ${widget.monto}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget imagen() {
    return Container(
      height: 90,
      width: 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('images/cuota.png'))),
    );
  }
}
