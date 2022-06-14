import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';

import '../models/handyman_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFribaseUser;
ClientModel? clientModelCurrentinfo;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
