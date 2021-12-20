import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key? key,
    required this.lienImg,
    required this.year,
    required this.titre,
    required this.plot,
    required this.note,
    required this.genre,
  }) : super(key: key);
  final String lienImg;
  final String year;
  final String titre;
  final String plot;
  final String note;
  final String genre;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      // color: Colors.black.withAlpha(100),
      decoration: BoxDecoration(
        // color: Colors.grey,
        color: Color.fromRGBO(42, 43, 43, 100),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 120.0,
                right: 120.0,
                bottom: 15,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 7,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  lienImg,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titre,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            plot,
                            maxLines: 4,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                year.toString(),
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              Text(
                                note.toString(),
                                style: GoogleFonts.montserrat(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  genre.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {},
                label: Text(
                  'Lecture',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
