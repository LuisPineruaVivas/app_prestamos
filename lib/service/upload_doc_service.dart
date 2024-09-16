import 'dart:io';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/model/upload_doc_model.dart';
import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<UploadDocResultModel> uploadedDocumenToServer(String docPath) async {
  UploadTask uploadTask;

  final docName = docPath.split('/');
  appLogger("Subiendo documento al servidor");
  try {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('client_doc')
        .child('/$docName.pdf');
    uploadTask = ref.putFile(File(docPath));
    TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => appLogger('Tarea Completada'));
    final dowloadUrl = await snapshot.ref.getDownloadURL();
    return Future.value(
        UploadDocResultModel(state: ViewState.succes, filterUrl: dowloadUrl));
  } on FirebaseException catch (error) {
    appLogger("f-Error subiendo la imagen: $error");
    return Future.value(UploadDocResultModel(
        state: ViewState.error, filterUrl: '"f-Error subiendo la imagen:"'));
  } catch (error) {
    appLogger("Error subiendo la imagen: $error");
    return Future.value(UploadDocResultModel(
        state: ViewState.error, filterUrl: '"Error subiendo la imagen"'));
  }
}
