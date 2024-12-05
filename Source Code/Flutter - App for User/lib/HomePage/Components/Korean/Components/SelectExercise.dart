import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:athena/HomePage/Components/FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';
import 'package:athena/LoginAndSignup/FirebaseAuthenticationFunctions/FirebaseAuthenticationFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FeedbackScreen.dart';
class SelectExercise extends StatefulWidget {
  const SelectExercise({super.key});

  @override
  State<SelectExercise> createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {
   String userName = ''; // Add a variable to store the user's name

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Fetch the user's name when the widget is initialized
    _fetchFeedbacks(); // Call the method to fetch feedbacks from Firebase
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      String userId = user.uid;
      print("User ID: $userId");
      DatabaseReference userRef = FirebaseDatabase.instance.ref("users/$userId");
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        // Use Map<dynamic, dynamic> and convert it safely
        print("Snapshot value: ${snapshot.value}");
        Map<dynamic, dynamic> userData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          userName = userData['name'] ?? 'Unknown';
          print("User Name: $userName"); // Update the userName state
        });
      } else {
        print("User name not found.");
      }
    } else {
      print("User is not logged in.");
    }
  }

  Future<void> _fetchFeedbacks() async {
    // Placeholder for fetching feedbacks from Firebase
    print("Fetching feedbacks...");
  }

  Color topColor = Colors.white;
  Color bottomColor = const Color.fromRGBO(28, 50, 91, 1);
  double share = 0.75;
  double border1 = 80;
  double border2 = 30;
  double border3 = 10;
  double border4 = 30;
  String selectedAnswer = '';
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'image': "https://trungtamtienghan.edu.vn/uploads/blog/2019_07/cach-noi-qua-tao-bang-tieng-han_1.jpg", // Replace with actual image URL
      'answers': [
        "A. 사과", // Apple in Korean
        "B. 바나나", // Banana in Korean
        "C. 오렌지", // Orange in Korean
        "D. 포도"  // Grape in Korean
      ],
      'correctAnswer': 'A'
    },
    {
      'image': "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2022/12/26/chuoi-xanh-16720694145571732285870.jpg", // Replace with actual image URL
      'answers': [
        "A. 사과", // Apple in Korean
        "B. 바나나", // Banana in Korean
        "C. 오렌지", // Orange in Korean
        "D. 포도"  // Grape in Korean
      ],
      'correctAnswer': 'B'
    },
    {
      'image': "https://suckhoedoisong.qltns.mediacdn.vn/Images/thanhloan/2016/06/05/tac-dung-cua-qua-cam-2.jpg", // Replace with actual image URL
      'answers': [
        "A. 사과", // Apple in Korean
        "B. 바나나", // Banana in Korean
        "C. 오렌지", // Orange in Korean
        "D. 포도"  // Grape in Korean
      ],
      'correctAnswer': 'C'
    },
    {
      'image': "https://suckhoedoisong.qltns.mediacdn.vn/jBt252BAaPNqKQdORF9knP7zcccccc/Image/2013/02/nho-662eb.jpg", // Replace with actual image URL
      'answers': [
        "A. 사과", // Apple in Korean
        "B. 바나나", // Banana in Korean
        "C. 오렌지", // Orange in Korean
        "D. 포도"  // Grape in Korean
      ],
      'correctAnswer': 'D'
    },
    {
      'image': "https://suckhoedoisong.qltns.mediacdn.vn/Images/bichvan/2017/08/15/dieu_thu_vi_ve_dau_tay_2.jpg", // Replace with actual image URL
      'answers': [
        "A. 복숭아", // Strawberry in Korean
        "B. 수박", // Watermelon in Korean
        "C. 체리", // Cherry in Korean
        "D. 딸기"  // Peach in Korean
      ],
      'correctAnswer': 'D'
    },
  ];

Future<void> saveScore(int score) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;
    DatabaseReference userRef = FirebaseDatabase.instance.ref("users/$userId");
    DataSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> userData = snapshot.value as Map<dynamic, dynamic>;
      String userName = userData['name'] ?? 'Unknown';
      
      print("Attempting to save score for user: $userName with score: $score");
      
      DatabaseReference ref = FirebaseDatabase.instance.ref("leaderboard/$userId");
      await ref.set({
        'name': userName,
        'score': score,
        'timestamp': ServerValue.timestamp,
      }).then((_) {
        print("Score saved successfully.");
      }).catchError((error) {
        print("Failed to save score: $error");
      });
    } else {
      print("User name not found.");
    }
  } else {
    print("User is not logged in.");
  }
}

Future<void> updateScore(int score) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("leaderboard/$userId");

    await ref.set({
      'name': userName, // Sử dụng biến userName đã có
      'score': score,
      'timestamp': ServerValue.timestamp,
    }).then((_) {
      print("Score updated successfully.");
    }).catchError((error) {
      print("Failed to update score: $error");
    });
  } else {
    print("User is not logged in.");
  }
}

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });

    if (answer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
      _showCongratulatoryDialog();
    } else {
      if (score > 0) {
        score--;
      }
      _showIncorrectDialog();
    }
  }

  void _showCongratulatoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chúc mừng!'),
          content: Text('Bạn đã chọn đúng. Điểm của bạn là $score.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextQuestion();
              },
              child: const Text('Câu hỏi tiếp theo'),
            ),
          ],
        );
      },
    );
  }

  void _showIncorrectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sai rồi!'),
          content: Text('Bạn đã chọn sai. Điểm của bn là $score.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextQuestion();
              },
              child: const Text('Câu hỏi tiếp theo'),
            ),
          ],
        );
      },
    );
  }

  void _showFinalScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.celebration, color: Colors.orange),
              const SizedBox(width: 10),
              const Text('Chúc mừng!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/icons/jumping_dog.json',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              Text('Bạn đã hoàn thành tất cả các câu hỏi. Tổng điểm của bạn là $score.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                updateScore(score); // Cập nhật điểm số lên Firebase
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  selectedAnswer = '';
                });
              },
              child: const Text('Bắt đầu lại'),
            ),
          ],
        );
      },
    );
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswer = '';
      } else {
        _showFinalScoreDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building widget with userName: $userName");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.5,
                  color: topColor,
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.5,
                  color: bottomColor,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                  height: screenHeight * share,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: topColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 26,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 330,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(60),
                              color: bottomColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                questions[currentQuestionIndex]['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                       ],
                      ),
                      const Text(
                        "Câu hỏi:",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(28, 50, 91, 1),
                        ),
                      ),
                      Text(
                        "Câu ${currentQuestionIndex + 1}:",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(28, 50, 91, 1),
                        ),
                      ),
                      const Text(
                        "Các đáp án:",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(28, 50, 91, 1),
                        ),
                      ),
                      ...questions[currentQuestionIndex]['answers'].map<Widget>((answer) {
                        return Text(
                          answer,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      Text(
                        'Điểm hiện tại: $score',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.feedback, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * (1 - share),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: bottomColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (iCol) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          2,
                          (iRow) {
                            String answer = (iCol == 0 && iRow == 0)
                                ? "A"
                                : (iCol == 0 && iRow == 1)
                                    ? "B"
                                    : (iCol == 1 && iRow == 0)
                                        ? "C"
                                        : "D";
                            return GestureDetector(
                              onTap: () => _selectAnswer(answer),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minHeight: 78,
                                ),
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: 160,
                                decoration: BoxDecoration(
                                  color: selectedAnswer == answer
                                      ? (answer == questions[currentQuestionIndex]['correctAnswer']
                                          ? Colors.green
                                          : Colors.red)
                                      : (iCol == 0 && iRow == 0)
                                          ? Colors.orange
                                          : (iCol == 0 && iRow == 1)
                                              ? Colors.blue
                                              : (iCol == 1 && iRow == 0)
                                                  ? Colors.yellow
                                                  : Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        (iCol == 0 && iRow == 0)
                                            ? border1
                                            : (iCol == 0 && iRow == 1)
                                                ? border2
                                                : (iCol == 1 && iRow == 0)
                                                    ? border4
                                                    : border3),
                                    topRight: Radius.circular(
                                        (iCol == 0 && iRow == 1)
                                            ? border1
                                            : (iCol == 0 && iRow == 0)
                                                ? border2
                                                : (iCol == 1 && iRow == 0)
                                                    ? border3
                                                    : border2),
                                    bottomRight: Radius.circular(
                                        (iCol == 0 && iRow == 0)
                                            ? border3
                                            : (iCol == 0 && iRow == 1)
                                                ? border4
                                                : (iCol == 1 && iRow == 0)
                                                    ? border2
                                                    : border1),
                                    bottomLeft: Radius.circular(
                                        (iCol == 0 && iRow == 0)
                                            ? border4
                                            : (iCol == 0 && iRow == 1)
                                                ? border3
                                                : (iCol == 1 && iRow == 0)
                                                    ? border1
                                                    : border4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    answer,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: bottomColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 