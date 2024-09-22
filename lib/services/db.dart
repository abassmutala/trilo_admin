import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trilo_admin/constants/api_path.dart';
import 'package:trilo_admin/models/store.dart';

import '../models/user.dart';

class DatabaseService {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  Future<void> _setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DocumentReference reference = _service.doc(path);
    await reference.set(data);
  }

  Future<String> _addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _service.collection(path);
    final docData = await reference.add(data);
    return docData.id;
  }

  Future<List<T>> _collectionFuture<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final CollectionReference<Map<String, dynamic>> reference =
        _service.collection(path);
    final QuerySnapshot<Map<String, dynamic>> snapshots = await reference.get();
    final docs = snapshots.docs.map((e) => builder(e.data())).toList();
    // final docs = snapshots.docs.map((e) => e.data()).toList();
    return docs;
  }

  Stream<List<T>> _collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) {
    final reference = _service.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (document) => builder(document.data()),
          )
          .toList(),
    );
  }

  Future<T> _getData<T>({required String path}) async {
    final reference = _service.doc(path);
    final snapshot = await reference.get();
    final data = snapshot.data() as T;
    return data;
  }

  Future<void> _updateData({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    final reference = _service.doc(documentPath);
    await reference.update(data);
  }

  Future<void> _deleteDoc({
    required String documentPath,
  }) async {
    final reference = _service.doc(documentPath);
    await reference.delete();
  }

  Future<int?> _getCount(String collectionPath) {
    final reference = _service.collection(collectionPath).count();
    return reference.get().then((value) => value.count);
  }

  // User
  Future<void> createProfile(User user) async {
    await _setData(
      path: APIPath.profile(user.uid),
      data: user.toMap(),
    );
  }

  Future<bool> checkIfUserExists(String uid) async {
    final DocumentSnapshot userDoc =
        await _service.doc(APIPath.profile(uid)).get();

    return !userDoc.exists ? false : true;
  }

  // Store
  Future<int?> getStoresCount() {
    return _getCount(APIPath.stores());
  }

  Future<int?> getAgentStoresCount(String uid) async {
    final user = await _getData(
      path: APIPath.profile(uid),
      // builder: ((data) => data["addedStores"]),
    );
    return user["addedStores"].length;
  }

  Future<List<Store>?> fetchStores() async {
    final reference =
        _service.collection("stores/").orderBy('regDate', descending: true);
    final data = await reference.get();
    return data.docs.map((e) => Store.fromMap(e.data())).toList();
  }

  Stream<List<Store>?> getStoresStream() {
    final reference = _service
        .collection(APIPath.stores())
        .orderBy('regDate', descending: true);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (document) => Store.fromMap(document.data()),
          )
          .toList(),
    );
  }

  Future<Store> getStore(String uid) async {
    final data = await _service.doc(APIPath.storeProfile(uid)).get();
    return Store.fromMap(
      data.data()!,
    );
  }

  Future<List<String>?> getUserStoresIds(String uid) async {
    DocumentReference userRef = _service.doc(APIPath.profile(uid));
    DocumentSnapshot userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      return null;
    }
    final data = userSnapshot.data() as Map<String, dynamic>;
    return List<String>.from(data["addedStores"]);
    // return user.addedStores as List<String>?;
  }

  Stream<List<Store>?> getUserStores(List? addedStores) {
    if (addedStores!.isEmpty) {
      return Stream.value([]);
    }
    final data = _service
        .collection(APIPath.stores())
        .where(FieldPath.documentId,
            whereIn: addedStores) //.sublist(0, 29).toList())
        .orderBy('regDate', descending: true)
        .snapshots();
    final stores = data.map((snapshot) =>
        snapshot.docs.map((e) => Store.fromMap(e.data())).toList());
    return stores;
  }

  // Agents
  Future<List?> getAgents() async {
    final data = await _service
        .collection(APIPath.users())
        .where("role", isEqualTo: "agent")
        .get();
    return data.docs.map((e) => e.data()).toList();
  }

  Future<int?> getAgentsCount() {
    final reference = _service
        .collection(APIPath.users())
        .where("role", isEqualTo: "agent")
        .count();
    return reference.get().then((value) => value.count);
  }
}
