import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryBackground = Color.fromARGB(255, 241, 244, 248);
const secondaryBackground = Color.fromARGB(255, 255, 255, 255);
const primaryText = Color.fromARGB(255, 16, 18, 19);
const secondaryText = Color.fromARGB(255, 87, 99, 108);
const alternate = Color.fromARGB(255, 255, 89, 99);
const primary = Color.fromARGB(255, 75, 57, 239);

InputDecoration inputDecor = InputDecoration(
  labelText: 'Link',
  labelStyle: GoogleFonts.carterOne(
    color: Color(0xFF57636C),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
  hintText: 'Enter link here...',
  hintStyle: TextStyle(
    color: Color(0xFF57636C),
    fontSize: 10,
    fontWeight: FontWeight.normal,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey[700]!,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(5),
  ),
  filled: true,
  fillColor: secondaryBackground,
  contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
);

List<String> Videos = [
  'https://www.youtube.com/watch?v=mB5kuXNi0xs&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM',
  'https://www.youtube.com/watch?v=p5nemzWv2pg&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=2',
  'https://www.youtube.com/watch?v=VYw3XqvLU6w&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=3',
  'https://www.youtube.com/watch?v=iaoTQTWF940&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=4',
  'https://www.youtube.com/watch?v=EdRcKb2541o&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=5',
  'https://www.youtube.com/watch?v=-GVlwruv7Tg&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=6',
  'https://www.youtube.com/watch?v=WxMgSg_BpPI&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=7',
  'https://www.youtube.com/watch?v=azSErrdqgbU&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=8',
  'https://www.youtube.com/watch?v=tR1mLfs2Xqo&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=9',
  'https://www.youtube.com/watch?v=eT3tW-vXnUU&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=10',
  'https://www.youtube.com/watch?v=-pYCFSEQTFo&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=11',
  'https://www.youtube.com/watch?v=kByAtHlrjQ4&list=PLSAVyiM48squPeE66k8p4ZELG7I7wF9bM&index=12',
];

List<String> Names = [
  'METASTARTUP Episode 1: My Story',
  "METASTARTUP Episode 2: Why you SHOULDN'T startup",
  'STARTUPS VS STABLE JOBS - YOUR JOB IS NOT SECURE | METASTARTUP #3',
  'HOW MUCH CAPITAL DO YOU NEED TO STARTUP | METASTARTUP #4',
  'HOW TO NAME YOUR STARTUP | METASTARTUP #5',
  'HOW TO REGISTER A COMPANY IN INDIA? | METASTARTUP #6',
  'OPENING A CORPORATE BANK ACCOUNT, CREDIT CARDS, FIRST BOARD MEETING & MORE | METASTARTUP #7',
  'REGISTERING A COMPANY IN SINGAPORE, USA OR ESTONIA | METASTARTUP #8',
  'HOW TO RAISE A SEED ROUND FOR A STARTUP IN INDIA? | METASTARTUP #9',
  'HOW TO RAISE A SERIES A IN INDIA | METASTARTUP #10',
  'HOW TO DO AN INITIAL PUBLIC OFFERING | METASTARTUP #11',
  'BANKRUPTCY AND LIQUIDATION | METASTARTUP #12'
];
