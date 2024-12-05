import 'package:firebase_database/firebase_database.dart';

class FireBaseRealTimeDataBase {
  // Static DatabaseReference initialization
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Static method to fetch course names
  static Future<List<String>> fetchCourse(String Address, String Type) async {
    List<String> stringList = []; // Initialize the list inside the method
    DataSnapshot snapshot = await _dbRef.child(Address).get();
    if (snapshot.exists) {
      List<dynamic> courses = snapshot.value as List<dynamic>;
      for (var course in courses) {
        if (course != null && course is Map<dynamic, dynamic>) {
          String? name = course[Type];
          if (name != null) {
            stringList.add(name);
          }
        }
      }
    }
    return stringList;
  }
  static Future<List<int>> getList (String Address, String Type) async {
    List<int> dataList = []; // Initialize the list inside the method
    DataSnapshot snapshot = await _dbRef.child(Address).get();
    if (snapshot.exists) {
      List<dynamic> courses = snapshot.value as List<dynamic>;
      for (var course in courses) {
        if (course != null && course is Map<dynamic, dynamic>) {
          int? name = course[Type];
          if (name != null) {
            dataList.add(name);
          }
        }
      }
    }
    return dataList;
  }
}
