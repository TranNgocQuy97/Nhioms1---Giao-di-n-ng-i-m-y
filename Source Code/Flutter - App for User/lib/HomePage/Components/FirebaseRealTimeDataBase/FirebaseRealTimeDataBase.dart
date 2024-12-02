import 'package:firebase_database/firebase_database.dart';

class FireBaseRealTimeDataBase {
  // Static DatabaseReference initialization
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Static method to fetch course names
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
}
