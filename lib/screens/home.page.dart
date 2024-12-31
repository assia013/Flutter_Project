import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    // Obtenir l'utilisateur actuel
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName ?? "Utilisateur";
    String userEmail = user?.email ?? "Email inconnu";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "HomePage",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar.png"),
                    radius: 30,
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Covid Tracker'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.green[900],
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Emsi Chatbot'),
              onTap: () {},
            ),
            Divider(
              color: Colors.green[900],
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {},
            ),
            Divider(
              color: Colors.green[900],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.green[900],
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            Divider(
              color: Colors.green[900],
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to the home Page",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, color: Colors.green),
        ),
      ),
    );
  }
}
