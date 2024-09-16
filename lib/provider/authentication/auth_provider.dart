import 'dart:io';
import 'package:app_prestamos/enums/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationProviderUseCase {
  Future<void> loginUser();
  Future<void> registerUser();
  Future<void> logoutUser();
}

class AuthenticationProviderImpl extends ChangeNotifier
    implements AuthenticationProviderUseCase {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ViewState state = ViewState.idle;
  String message = '';

  @override
  Future<void> loginUser() async {
    state = ViewState.busy;
    message = 'Iniciando Sesion...';
    _updateState();

    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      state = ViewState.succes;
      message = 'Bienvenido, ${result.user!.email}';
      emailController.clear();
      passwordController.clear();
      _updateState();
    } on SocketException catch (_) {
      state = ViewState.error;
      message = 'Error de red, Intente mas tarde';
      _updateState();
    } on FirebaseAuthException catch (e) {
      state = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      state = ViewState.error;
      message = 'Error al iniciar sesion, Intente mas tarde';
      _updateState();
    }
  }

  @override
  Future<void> logoutUser() async {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    return await firebaseAuth.signOut();
  }

  @override
  Future<void> registerUser() async {
    state = ViewState.busy;
    message = 'Creando tu cuenta...';

    _updateState();

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        _firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
          "id": firebaseAuth.currentUser!.uid,
          "email": emailController.text.trim(),
          "usuario": userNameController.text.trim()
        });
      });

      state = ViewState.succes;
      message = "Bienvenido, ${userNameController.text}";
      userNameController.clear();
      emailController.clear();
      passwordController.clear();
      _updateState();
    } on SocketException catch (_) {
      state = ViewState.error;
      message = 'Problema de red, Intente de nuevo mas tarde.';
      _updateState();
    } on FirebaseAuthException catch (e) {
      state = ViewState.error;
      message = e.code;
      _updateState();
    } catch (e) {
      state = ViewState.error;
      message = e.toString();
      _updateState();
    }
  }

  void _updateState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
