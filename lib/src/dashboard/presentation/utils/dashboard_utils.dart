import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tdd_courses_app/core/services/injection_container/injection_container.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';

class DashBoardUtils {
  const DashBoardUtils._();

  static Stream<LocalUserModel> get userDataStream =>
      serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (event) => LocalUserModel.fromMap(event.data()!),
          );
}
