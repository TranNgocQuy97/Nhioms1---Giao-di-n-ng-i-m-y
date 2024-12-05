import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SelectExercise extends StatefulWidget {
  const SelectExercise({super.key});

  @override
  State<SelectExercise> createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {
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
      'question': "Why is Paris considered one of the most popular tourist destinations in the world?",
      'answers': [
        "A. Paris is famous for its rich history, iconic landmarks like the Eiffel Tower, and cultural attractions such as the Louvre Museum, which houses the Mona Lisa.",
        "B. It is known for its culinary excellence, offering a wide variety of French dishes and desserts that attract food enthusiasts from around the globe.",
        "C. Paris is often referred to as the City of Love, attracting couples for romantic experiences, including cruises along the Seine River",
        "D. All of the above."
      ],
      'correctAnswer': 'D'
    },
    {
      'question': "What is the capital of Japan?",
      'answers': [
        "A. Beijing",
        "B. Seoul",
        "C. Tokyo",
        "D. Bangkok"
      ],
      'correctAnswer': 'C'
    },
    {
      'question': "Which planet is known as the Red Planet?",
      'answers': [
        "A. Earth",
        "B. Mars",
        "C. Jupiter",
        "D. Venus"
      ],
      'correctAnswer': 'B'
    },
    {
      'question': "What is the largest ocean on Earth?",
      'answers': [
        "A. Atlantic Ocean",
        "B. Indian Ocean",
        "C. Arctic Ocean",
        "D. Pacific Ocean"
      ],
      'correctAnswer': 'D'
    }
  ];

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      print('Firebase initialized');
    }).catchError((error) {
      print('Firebase initialization error: $error');
    });
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });

    if (answer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
      _showCongratulatoryDialog();
    } else {
      score--;
      _showIncorrectDialog();
    }

    _pushExerciseDataToFirebase();
  }

  void _pushExerciseDataToFirebase() {
    String userId = "WcoW2RK73XPim6CpIjqXs7cVy5Z2"; // Thay thế bằng ID người dùng thực tế
    String language = "ENGLISH";
    String timestamp = DateTime.now().toIso8601String();

    _database.child('users/$userId/courseStart').set({
      'exerciseId': currentQuestionIndex,
      'language': language,
      'timestamp': timestamp,
    }).then((_) {
      print('Dữ liệu đã được đẩy lên Firebase thành công.');
    }).catchError((error) {
      print('Có lỗi xảy ra: $error');
    });
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
          content: Text('Bạn đã chọn sai. Điểm của bạn là $score.'),
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
                                "https://i.pinimg.com/474x/a6/da/73/a6da735b32f6b3a89f3c06584b63dcb9.jpg",
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
                        questions[currentQuestionIndex]['question'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "Các đp án:",
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
                                        (iCol == 0 && iRow == 0)
                                            ? border2
                                            : (iCol == 0 && iRow == 1)
                                                ? border1
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