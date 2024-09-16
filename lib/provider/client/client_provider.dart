import 'dart:io';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/model/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class ClientProviderUseCase {
  Future<void> addClient();
  Future<void> viewClient();
  Future<void> viewClientById(String clientId);
  Future<void> deleteClient(String clientId);
  Future<void> updateClient(String clientId, String nombre, String cedula,
      String tlfn, String email, String notas);
  Future<void> clearFields();
}

class ClientProviderImpl extends ChangeNotifier
    implements ClientProviderUseCase {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientCedulaController = TextEditingController();
  TextEditingController clientNumberController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController clientNoteController = TextEditingController();

  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;
  set viewState(ViewState value) {
    _viewState = value;
    _updateState();
  }

  String _message = '';
  String get message => _message;
  set message(String value) {
    _message = value;
    _updateState();
  }

  String? _uploadedDocument;
  String? get uploadedDocument => _uploadedDocument;
  set uploadedDocument(String? doc) {
    _uploadedDocument = doc;
    _updateState();
  }

  final _clientRef = FirebaseFirestore.instance.collection('users');
  final _user = FirebaseAuth.instance.currentUser;

  //Lista Clientes
  List<ClientModel> _clients = [];
  List<ClientModel> get clients => _clients;

  //Para un solo cliente
  ClientModel? _singleClient;
  ClientModel? get singleClient => _singleClient;

  @override
  Future<void> addClient() async {
    _viewState = ViewState.busy;
    message = 'Guardando los datos del cliente';
    _updateState();

    try {
      final clientLoad = ClientModel(
          clientId: '',
          nombreCliente: clientNameController.text.trim(),
          cedulaCliente: clientCedulaController.text.trim(),
          tlfnCliente: clientNumberController.text.trim(),
          emailCliente: clientEmailController.text.trim(),
          notasCliente: clientNoteController.text.trim(),
          documentoCliente: _uploadedDocument);

      _clientRef
          .doc(_user!.uid)
          .collection('clientes')
          .add(clientLoad.toJson());

      _viewState = ViewState.succes;
      message = 'Cliente registrado correctamente';
      _updateState();
    } on SocketException catch (_) {
      _viewState = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseException catch (e) {
      _viewState = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      _viewState = ViewState.error;
      message = 'Ha ocurrido un error, Intente mas tarde';
      _updateState();
    }
  }

  @override
  Future<void> deleteClient(String clientId) async {
    _viewState = ViewState.busy;
    message = 'Borrando cliente...';
    _updateState();

    try {
      final result = await _clientRef
          .doc(_user!.uid)
          .collection('clientes')
          .doc(clientId)
          .get();

      if (result.exists) {
        await _clientRef
            .doc(_user.uid)
            .collection('clientes')
            .doc(clientId)
            .delete();

        _viewState = ViewState.succes;
        message = 'Cliente borrado correctamente';
      } else {
        message = "Cliente con el Id: $clientId no existe";
        _viewState = ViewState.error;
      }
      _updateState();
    } on SocketException catch (_) {
      _viewState = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseException catch (e) {
      _viewState = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      _viewState = ViewState.error;
      message = 'Ha ocurrido un error, Intente mas tarde';
      _updateState();
    }
  }

  @override
  Future<void> updateClient(String clientId, String nombre, String cedula,
      String tlfn, String email, String notas) async {
    _viewState = ViewState.busy;
    message = 'Guardando cambios';
    _updateState();

    try {
      final result = await _clientRef
          .doc(_user!.uid)
          .collection('clientes')
          .doc(clientId)
          .get();

      if (result.exists) {
        final clientData = ClientModel(
            clientId: '',
            nombreCliente: nombre,
            cedulaCliente: cedula,
            tlfnCliente: tlfn,
            emailCliente: email,
            notasCliente: notas,
            documentoCliente: _uploadedDocument);

        await _clientRef
            .doc(_user.uid)
            .collection('clientes')
            .doc(clientId)
            .update(clientData.toJson());

        _viewState = ViewState.succes;
        message = 'Datos guardados correctamente';
      } else {
        message = "Cliente con el Id: $clientId no existe";
        _viewState = ViewState.error;
      }
      _updateState();
    } on SocketException catch (_) {
      _viewState = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseException catch (e) {
      _viewState = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      _viewState = ViewState.error;
      message = 'Ha ocurrido un error, Intente mas tarde';
      _updateState();
    }
  }

  @override
  Future<void> viewClient() async {
    _viewState = ViewState.busy;
    message = 'Cargando Clientes';
    _updateState();
    List<ClientModel> tempData = [];

    try {
      final result =
          await _clientRef.doc(_user!.uid).collection('clientes').get();
      if (result.docs.isNotEmpty) {
        final clientData = result.docs;
        for (var i in clientData) {
          final clientDataModel = ClientModel.fromJson(i.data());
          clientDataModel.clientId = i.id;
          tempData.add(clientDataModel);
        }
        _clients = tempData;
      } else {
        _clients = [];
      }
      _viewState = ViewState.succes;
      message = 'Clientes cargados';
      _updateState();
    } on SocketException catch (_) {
      _viewState = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseException catch (e) {
      _viewState = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      _viewState = ViewState.error;
      message = 'Ha ocurrido un error, Intente mas tarde';
      _updateState();
    }
  }

  @override
  Future<void> viewClientById(String clientId) async {
    _viewState = ViewState.busy;
    message = 'Cargando datos del cliente...';
    _updateState();

    try {
      final result = await _clientRef
          .doc(_user!.uid)
          .collection('clientes')
          .doc(clientId)
          .get();

      if (result.exists) {
        final clientData = ClientModel.fromJson(result.data()!);
        _singleClient = clientData;
        _viewState = ViewState.succes;
        message = 'Datos cliente listos';
      } else {
        message = "Cliente con el Id: $clientId no existe";
        _viewState = ViewState.error;
      }
      _updateState();
    } on SocketException catch (_) {
      _viewState = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseException catch (e) {
      _viewState = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      _viewState = ViewState.error;
      message = 'Ha ocurrido un error, Intente mas tarde';
      _updateState();
    }
  }

  void _updateState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  @override
  Future<void> clearFields() async {
    clientNameController.clear();
    clientCedulaController.clear();
    clientNumberController.clear();
    clientEmailController.clear();
    clientNoteController.clear();
    _uploadedDocument = null;
  }
}
