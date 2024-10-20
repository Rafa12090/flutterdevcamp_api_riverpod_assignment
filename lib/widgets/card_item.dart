import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required Map<String, dynamic>? card,
  }) : _card = card;

  final Map<String, dynamic>? _card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber.shade700, width: 3), 
          borderRadius: BorderRadius.circular(12), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), 
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
          gradient: LinearGradient( 
            colors: [
              Colors.black87,
              Colors.deepPurple.shade900,
              Colors.redAccent.shade700,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  _card!['card_images'][0]['image_url'],
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                  
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber.shade700, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: child,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _card['name'],
                style: GoogleFonts.cinzel( 
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                  shadows: [
                    const Shadow(
                      blurRadius: 4.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _card['type'],
                style: GoogleFonts.pirataOne(
                  fontSize: 18,
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(height: 10),
              if (_card['atk'] != null && _card['def'] != null)
                Text(
                  'ATK: ${_card['atk']} / DEF: ${_card['def']}',
                  style: GoogleFonts.cinzel(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 10),
              if (_card['level'] != null)
                Text(
                  'Level: ${_card['level']}',
                  style: GoogleFonts.cinzel(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 10),
              if (_card['attribute'] != null)
                Text(
                  'Attribute: ${_card['attribute']}',
                  style: GoogleFonts.cinzel(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                _card['desc'],
                style: GoogleFonts.pirataOne(
                  fontSize: 16,
                  color: Colors.grey.shade300,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
