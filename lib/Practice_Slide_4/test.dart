import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ROOT APP
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

// HOME PAGE
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: Text("My Mobile App", style: TextStyle(color: Colors.white)),

        centerTitle: true,

        backgroundColor: Colors.lightBlue,

        leading: Icon(Icons.menu),

        actions: [Icon(Icons.notifications), SizedBox(width: 12)],
      ),

      //  BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // PROFILE CARD
              ProfileCard(),

              SizedBox(height: 24),

              // QUICK ACTION TITLE
              SectionTitle(title: "Quick Actions"),

              SizedBox(height: 16),

              // ACTION BUTTONS
              ActionSection(),

              SizedBox(height: 24),

              //PRODUCT TITLE
              SectionTitle(title: "Popular Products"),

              SizedBox(height: 16),

              // PRODUCT LIST
              ProductCard(
                title: "iPhone 15",
                price: "\$1200",
                icon: Icons.phone_iphone,
              ),

              SizedBox(height: 16),

              ProductCard(
                title: "MacBook Pro",
                price: "\$2500",
                icon: Icons.laptop_mac,
              ),

              SizedBox(height: 16),

              ProductCard(
                title: "AirPods",
                price: "\$299",
                icon: Icons.headphones,
              ),
            ],
          ),
        ),
      ),

      // FLOAT BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        backgroundColor: Colors.blue,

        child: Icon(Icons.add),
      ),

      // BOTTOM NAV
      bottomNavigationBar: CustomBottomNav(),

      //  DRAWER
      drawer: CustomDrawer(),
    );
  }
}

// PROFILE CARD WIDGET
class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: EdgeInsets.all(16),

        child: Row(
          children: [
            CircleAvatar(
              radius: 35,

              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),

            SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Kirito",

                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 4),

                Text("Flutter Developer", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// SECTION TITLE WIDGET
class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

// ACTION SECTION WIDGET
class ActionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        ActionButton(icon: Icons.home, text: "Home", color: Colors.blue),

        ActionButton(
          icon: Icons.shopping_cart,
          text: "Cart",
          color: Colors.orange,
        ),

        ActionButton(icon: Icons.favorite, text: "Like", color: Colors.red),

        ActionButton(icon: Icons.person, text: "Profile", color: Colors.green),
      ],
    );
  }
}

// ACTION BUTTON WIDGET
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  ActionButton({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Icon(icon, color: Colors.white, size: 32),
        ),

        SizedBox(height: 8),

        Text(text),
      ],
    );
  }
}

// PRODUCT CARD WIDGET
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;

  ProductCard({required this.title, required this.price, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: EdgeInsets.all(16),

        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color: Colors.blue.shade100,

                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(icon, size: 40, color: Colors.blue),
            ),

            SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 6),

                  Text(
                    price,

                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ],
              ),
            ),

            ElevatedButton(onPressed: () {}, child: Text("Buy")),
          ],
        ),
      ),
    );
  }
}

// CUSTOM BOTTOM NAV

class CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,

      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),

        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

// CUSTOM DRAWER
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CircleAvatar(
                  radius: 30,

                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                ),

                SizedBox(height: 12),

                Text(
                  "Kirito",

                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),

                Text(
                  "kirito@gmail.com",

                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          ListTile(leading: Icon(Icons.home), title: Text("Home")),

          ListTile(leading: Icon(Icons.settings), title: Text("Settings")),

          ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
        ],
      ),
    );
  }
}
