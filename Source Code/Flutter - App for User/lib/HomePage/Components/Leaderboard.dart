import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bảng Xếp Hạng'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("leaderboard").orderByChild('score').limitToLast(10).onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text('No data available'));
          }

          Map<dynamic, dynamic> leaderboardData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<MapEntry<dynamic, dynamic>> entries = leaderboardData.entries.toList();
          entries.sort((a, b) => b.value['score'].compareTo(a.value['score']));

          if (entries.isEmpty) {
            return Center(child: Text('No entries found'));
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              var entry = entries[index];
              String userName = entry.value['name'] ?? 'Unknown';
              int score = entry.value['score'] ?? 0;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: Colors.blueAccent,
                  ),
                  title: Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Score: $score'),
                  trailing: Icon(Icons.star, color: Colors.amber),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to update leaderboard
  void updateLeaderboard(String userId, String userName, int score) {
    DatabaseReference leaderboardRef = FirebaseDatabase.instance.ref("leaderboard/$userId");
    leaderboardRef.set({
      'name': userName,
      'score': score,
    }).then((_) {
      print("Leaderboard updated successfully.");
    }).catchError((error) {
      print("Failed to update leaderboard: $error");
    });
  }
} 