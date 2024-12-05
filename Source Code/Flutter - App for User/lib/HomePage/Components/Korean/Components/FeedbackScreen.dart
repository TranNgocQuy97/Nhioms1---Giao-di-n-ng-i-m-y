import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:athena/HomePage/Components/FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';
import 'package:athena/LoginAndSignup/FirebaseAuthenticationFunctions/FirebaseAuthenticationFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final DatabaseReference _feedbackRef = FirebaseDatabase.instance.ref().child('feedbacks');

  void _sendFeedback() {
    if (_controller.text.isNotEmpty) {
      _feedbackRef.push().set({
        'name': 'ngocquy', 
        'message': _controller.text,
        'uid': FirebaseAuth.instance.currentUser?.uid ?? 'unknown',
        'status': 'pending', 
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Nhập phản hồi của bạn',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _sendFeedback,
                  child: Text('Gửi'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _feedbackRef.onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<dynamic, dynamic> feedbacks = Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as Map);
                List<MapEntry<dynamic, dynamic>> feedbackList = feedbacks.entries.toList();
                return ListView.builder(
                  itemCount: feedbackList.length,
                  itemBuilder: (context, index) {
                    var feedback = feedbackList[index].value;
                    return SizedBox(
                      height: 100,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            
                          },
                          child: ListTile(
                            leading: Icon(Icons.feedback),
                            title: Text(feedback['name']),
                            subtitle: Text(feedback['message']),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 