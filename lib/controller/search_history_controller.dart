import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flow_app/model/search_history_model.dart';
import 'package:get/get.dart';

class SearchHistoryController extends GetxController {
    final FirebaseFirestore firestore;
    final searchHistory = <SearchHistoryModel>[].obs;

  SearchHistoryController(this.firestore);

  Future<void> saveSearchQuery(String query) async {
    final history = SearchHistoryModel(query: query, timestamp: DateTime.now());
    await firestore.collection('search_history').add(history.toMap());
    searchHistory.add(history);
  }

  Future<void> fetchSearchHistory() async {
    final snapshot = await firestore.collection('search_history').get();
    searchHistory.assignAll(snapshot.docs.map((doc) => SearchHistoryModel.fromMap(doc.data()!)).toList());
  }
}
