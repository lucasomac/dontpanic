import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/database.dart';
import 'package:dontpanic/data/repository/secure_contact_repository.dart';
import 'package:dontpanic/data/repository/sos_repository.dart';
import 'package:dontpanic/domain/repository/secure_contact_repository_impl.dart';
import 'package:dontpanic/domain/repository/sos_repository_impl.dart';
import 'package:kiwi/kiwi.dart';

class DontPanicModule {
  static inject() {
    KiwiContainer container = KiwiContainer();
    container.registerInstance(FirebaseFirestore.instance);
    // container.registerSingleton((container) => FirebaseFirestore, name: 'firestoreInstance');
    container.registerSingleton((container) => Database(container.resolve<FirebaseFirestore>()), name: "database");
    container.registerFactory((container) => container.resolve<Database>('database').getSecureContactCollection(), name: "collectionSecureContact");
    container.registerFactory((container) => container.resolve<Database>('database').getSosCollection(), name: "collectionSos");
    container.registerFactory<SecureContactRepository>((container) => SecureContactRepositoryImpl(container.resolve<CollectionReference>('collectionSecureContact')));
    container.registerFactory<SosRepository>((container) => SosRepositoryImpl(container.resolve<CollectionReference>('collectionSos')));
  }
}
