import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ExerciseHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch Sử Làm Bài'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("users").orderByChild('courseStart/timestamp').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text('Không có dữ liệu'));
          }

          Map<dynamic, dynamic> historyData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<MapEntry<dynamic, dynamic>> entries = historyData.entries.toList();

          entries = entries.where((entry) {
            var courseStart = entry.value['courseStart'];
            return courseStart != null && courseStart['timestamp'] != null;
          }).toList();

          entries.sort((a, b) {
            var timestampA = a.value['courseStart']['timestamp'];
            var timestampB = b.value['courseStart']['timestamp'];
            return timestampB.compareTo(timestampA);
          });

          if (entries.isEmpty) {
            return Center(child: Text('Không có lịch sử nào'));
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              var entry = entries[index];
              var courseStart = entry.value['courseStart'];

              if (courseStart == null) {
                return ListTile(
                  title: Text('Dữ liệu không hợp lệ'),
                  subtitle: Text('Không có thông tin về khóa học.'),
                );
              }

              String language = courseStart['language'] ?? 'Unknown';
              String timestamp = courseStart['timestamp'] ?? 'Unknown';
              String name = entry.value['name'] ?? 'Unknown';

              DateTime dateTime = DateTime.parse(timestamp);
              String formattedTime = DateFormat('HH:mm / dd-MM-yyyy').format(dateTime);

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  title: Text(
                    'Ngôn ngữ: $language',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Thời gian: $formattedTime\nTên: $name'),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 