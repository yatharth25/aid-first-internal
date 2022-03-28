import 'package:aid_first/screens/patient/diagnose_yourself/disease_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultCard extends StatelessWidget {
  final dynamic id;
  final String name;
  final dynamic accuracy;

  const ResultCard({
    required this.id,
    required this.name,
    required this.accuracy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DiseaseInfo(issueId: id, name: name),
          ),
        )
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        height: 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/doctor.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Name: ',
                      style: GoogleFonts.prociono(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.prociono(
                        color: Colors.blue[800],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Acccuracy: ',
                      style: GoogleFonts.prociono(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      double.parse(accuracy.toString()).floor().toString() +
                          '%',
                      style: GoogleFonts.prociono(
                        color: Colors.blue[800],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
