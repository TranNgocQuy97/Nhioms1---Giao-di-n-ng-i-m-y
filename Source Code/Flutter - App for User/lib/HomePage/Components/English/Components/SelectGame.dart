import 'package:flutter/material.dart';

class SelectGame extends StatefulWidget {
  const SelectGame({super.key});

  @override
  State<SelectGame> createState() => _SelectGameState();
}

class _SelectGameState extends State<SelectGame> {
  List<String> words = ['Apple', 'Dog', 'Car', 'House'];
  List<String> meanings = ['Xe hơi', 'Nhà', 'Táo', 'Chó'];
  final Map<String, String> correctMatches = {
    'Apple': 'Táo',
    'Dog': 'Chó',
    'Car': 'Xe hơi',
    'House': 'Nhà',
  };
  final Map<String, String> userMatches = {};

  void _checkMatch(String word, String meaning) {
    setState(() {
      userMatches[word] = meaning;
    });

    if (correctMatches[word] == meaning) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct! $word means $meaning.'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        words.remove(word);
        meanings.remove(meaning);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect! Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Learning Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Match the English words with their meanings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: words.map((word) {
                      return Draggable<String>(
                        data: word,
                        child: WordCard(word: word),
                        feedback: WordCard(word: word, isDragging: true),
                        childWhenDragging: WordCard(word: word, isDragging: true),
                      );
                    }).toList(),
                  ),
                  Column(
                    children: meanings.map((meaning) {
                      return DragTarget<String>(
                        builder: (context, candidateData, rejectedData) {
                          return MeaningCard(meaning: meaning);
                        },
                        onAccept: (word) {
                          _checkMatch(word, meaning);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final String word;
  final bool isDragging;

  const WordCard({Key? key, required this.word, this.isDragging = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDragging ? Colors.grey : Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          word,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class MeaningCard extends StatelessWidget {
  final String meaning;

  const MeaningCard({Key? key, required this.meaning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          meaning,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}