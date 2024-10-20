import 'package:assignment_flutter_devcamp_api_riverpod/screens/card_search_screen.dart';
import 'package:assignment_flutter_devcamp_api_riverpod/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black87,
                  Colors.deepPurple.shade900,
                  Colors.purple.shade600,
                  Colors.redAccent.shade700,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/cards_background.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Image.asset(
                'assets/images/yu_gi_oh_logo.png',
                width: 250,
                height: 180,
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(
                    child: Text(
                      'Welcome Duelist!',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: GoogleFonts.cinzel().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  const SizedBox(
                    child: Text(
                      'Enter the World of Duel Monsters!',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  CustomButton(
                    buttonText: 'Start Your Duel',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CardSearchScreen(name: ''),));
                    },
                    buttonColor: Colors.redAccent.shade700,
                    borderRadius: 20.0,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Let the duel begin!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}