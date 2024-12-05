import 'package:firebase_database/firebase_database.dart';

class FireBaseRealTimeDataBase {
  // Static DatabaseReference initialization
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  static Future<List<String>> fetchCourseNames(String Address) async {
    List<String> courseNames = []; // Initialize the list inside the method
    DataSnapshot snapshot = await _dbRef.child(Address).get();
    if (snapshot.exists) {
      List<dynamic> courses = snapshot.value as List<dynamic>;
      for (var course in courses) {
        if (course != null && course is Map<dynamic, dynamic>) {
          String? name = course['name'];
          if (name != null) {
            courseNames.add(name);
          }
        }
      }
    }
    return courseNames;
  }
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
  static Future<List<List<String>>> getOptions(String path, String childName) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    DataSnapshot snapshot = await ref.get();

    List<List<String>> optionsList = [];
    if (snapshot.exists) {
      for (var question in snapshot.children) {
        List<String> options = [];
        DataSnapshot optionsSnapshot = question.child(childName);
        if (optionsSnapshot.exists) {
          for (var option in optionsSnapshot.children) {
            options.add(option.value.toString());
          }
        }
        optionsList.add(options);
      }
    }
    return optionsList;
  }
}
