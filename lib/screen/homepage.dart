import 'package:flutter/material.dart';

/* void main() {
  runApp(MyApp());
} */

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
} */

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LINGUA MASTER', style: TextStyle(color: const Color.fromARGB(255, 90, 148, 4))),
        // backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: () {
              // Hành động khi nhấn nút Sign In
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue, // Màu nền nút
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7), // Khoảng cách bên trong nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bo tròn các góc
              ),
            ),
            child: Text(
              'SIGN IN',
              style: TextStyle(color: Colors.white, fontSize: 12), // Màu và kích thước chữ
            ),
          ),
           SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // Hành động khi nhấn nút Sign In 
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange, // Màu nền nút
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7), // Khoảng cách bên trong nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bo tròn các góc
              ),
            ),
            child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.white, fontSize: 12), // Màu và kích thước chữ
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset('assets/icons/banner.png'), // Thay banner.png bằng banner bạn có
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
          // Handle navigation tap
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
            fit: BoxFit.contain,  // Giữ tỷ lệ hình ảnh và làm cho nó vừa với container
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