import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/model/client_model.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final ClientModel clientData;
  final Function() onTap;

  const ClientCard({super.key, required this.onTap, required this.clientData});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: double.infinity,
            height: 120,
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
                                    clientData.nombreCliente.ellipsis(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                clientData.cedulaCliente,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              10.height(),
                              infoButton()
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
          image: DecorationImage(image: AssetImage('images/user.png'))),
    );
  }

  Widget infoButton() {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 200,
        height: 35,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(children: [
            Image.asset('images/presta.png'),
            const SizedBox(width: 10),
            const Text(
              'Ver Prestamos',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ]),
        ),
      ),
    );
  }
}
