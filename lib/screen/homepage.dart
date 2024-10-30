import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LINGUA MASTER', style: TextStyle(color: const Color.fromARGB(255, 90, 148, 4))),           
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset('assets/icons/banner.png'), 
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildCategoryCard('assets/icons/english.png','ENGLISH'),
                _buildCategoryCard('assets/icons/chinese.png','CHINESE'),
                _buildCategoryCard('assets/icons/japanese.png','JAPANESE'),
                _buildCategoryCard('assets/icons/english.png','KOREAN'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Process',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
        
        },
      ),
    );
  }

 Widget _buildCategoryCard(String imagePath, String language) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,  
          ),
        ),
        SizedBox(height: 10),
        Text(
          language,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
}
