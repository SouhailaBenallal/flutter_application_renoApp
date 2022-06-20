import 'dart:async';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/models/handyman_data.dart';
import 'package:geolocator/geolocator.dart';

import '../models/clientRequest_information.dart';
import '../models/handyman_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFribaseUser;
ClientModel? clientModelCurrentinfo;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
Position? clientCurrentPosition;
HandymanData onlineHandymanData = HandymanData();
String? handymanTaskJob = "";
ClientHandymanRequestInformation? clientHandymanRequestDetails;
String titleStartsRating = "Good";
bool isHandymanActive = false;
String statusText = "Now Offline";
Color buttonColor = Colors.grey;
