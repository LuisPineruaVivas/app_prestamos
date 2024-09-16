class ClientModel {
  String? clientId;
  String nombreCliente;
  String cedulaCliente;
  String tlfnCliente;
  String emailCliente;
  String notasCliente;
  dynamic documentoCliente;

  ClientModel({
    required this.clientId,
    required this.nombreCliente,
    required this.cedulaCliente,
    required this.tlfnCliente,
    required this.emailCliente,
    required this.notasCliente,
    required this.documentoCliente,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        clientId: json["Cliente_id"],
        nombreCliente: json["Nombre_cliente"],
        cedulaCliente: json["Cedula_cliente"],
        tlfnCliente: json["Tlfn_cliente"],
        emailCliente: json["Email_cliente"],
        notasCliente: json["Notas_cliente"],
        documentoCliente: json["Documento_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "Cliente_id": clientId,
        "Nombre_cliente": nombreCliente,
        "Cedula_cliente": cedulaCliente,
        "Tlfn_cliente": tlfnCliente,
        "Email_cliente": emailCliente,
        "Notas_cliente": notasCliente,
        "Documento_cliente": documentoCliente,
      };
}
