import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/screens/mainScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_reno/all/all.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class IdentifyDocmuentScreen extends StatefulWidget {
  const IdentifyDocmuentScreen({Key? key}) : super(key: key);

  @override
  State<IdentifyDocmuentScreen> createState() => _IdentifyDocmuentScreenState();
}

class _IdentifyDocmuentScreenState extends State<IdentifyDocmuentScreen> {
  List<String> documementTypeList = [
    "Passeport",
    "ID Card",
    "Auto licenceCard"
  ];

  String? selecteddocumentType;
  TextEditingController numberdocumenttextEditingController =
      TextEditingController();

  saveHandyInfoDocument() {
    Map handyInfoDocument = {
      "DocumentType": selecteddocumentType,
      "NumberDocument": numberdocumenttextEditingController.text.trim()
    };

    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_document")
        .set(handyInfoDocument);
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => const IdentifyDocmuentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Document",
                  style: kHeadline2,
                ),
                const SizedBox(height: kBigSpacing),
                Text("Valid identity documents", style: kBodyText2),
                const SizedBox(height: kBigSpacing * 2),
                DropdownButton(
                    iconSize: 30,
                    value: selecteddocumentType,
                    hint: const Text(
                      "Passeport",
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selecteddocumentType = newValue.toString();
                      });
                    },
                    items: documementTypeList.map((job) {
                      return DropdownMenuItem(
                        // ignore: sort_child_properties_last
                        child: Text(
                          job,
                          style: const TextStyle(color: Colors.black),
                        ),
                        value: job,
                      );
                    }).toList()),
                TextField(
                    controller: numberdocumenttextEditingController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: "Number of document",
                      hintText: "Number of document",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
              ],
            ),
            UserInfo(),
            ModifyImage(),
            BigButton(
                title: "Finish",
                buttonColor: kColorBlack,
                function: () {
                  saveHandyInfoDocument();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorklistScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ImagePicture(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ModifyImage extends StatefulWidget {
  const ModifyImage({Key? key}) : super(key: key);
  @override
  _ModifyImageState createState() => _ModifyImageState();
}

class _ModifyImageState extends State<ModifyImage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    Reference storageRef =
        storage.ref('handyman').child(currentFribaseUser!.uid + ".png");
    UploadTask uploadTask = storageRef.putFile(_image!);
    await uploadTask.whenComplete(() {
      print('Photo de profil mise à jour');
      refreshPage(context);
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  getCamera();
                },
                leading: const Icon(Icons.photo_camera),
                title: const Text("Caméra"),
              ),
              ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    getImage();
                  },
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Bibliothèque photo"))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: const Text('Modify picture'),
            onPressed: () => _showOptions(context),
          ),
          _image == null
              ? const Text('Choose image')
              : Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(_image!),
                  ),
                ),
          _image == null
              ? const Text('Load it')
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kColorBlack,
                  ),
                  child: const Text('Finish'),
                  onPressed: () {
                    uploadFile();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorklistScreen(),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}

class ImagePicture extends StatefulWidget {
  const ImagePicture({Key? key}) : super(key: key);
  @override
  _ImagePictureState createState() => _ImagePictureState();
}

class _ImagePictureState extends State<ImagePicture> {
  String? userPhotoUrl;
  String defaultUrl =
      'https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg';

  @override
  void initState() {
    super.initState();
    getProfilImage();
  }

  getProfilImage() {
    Reference ref =
        storage.ref('handyman').child(currentFribaseUser!.uid + ".png");
    ref.getDownloadURL().then((downloadUrl) {
      setState(() {
        userPhotoUrl = downloadUrl.toString();
      });
    }).catchError((e) {
      setState(() {
        print('Un problème est survenu: ${e.error}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(75),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: userPhotoUrl == null
              ? NetworkImage(defaultUrl)
              : NetworkImage(userPhotoUrl!),
        ),
      ),
    );
  }
}

class GetUserData extends StatelessWidget {
  final String fieldName;
  final TextStyle fieldStyle;
  const GetUserData({
    Key? key,
    required this.fieldName,
    required this.fieldStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('handyman');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentFribaseUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Un problème est survenu',
            style: fieldStyle,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data[fieldName],
            style: fieldStyle,
          );
        }
        return Text(
          'En cours de chargement',
          style: fieldStyle,
        );
      },
    );
  }
}

refreshPage(context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => IdentifyDocmuentScreen(),
      transitionDuration: Duration(seconds: 0),
    ),
  );
}
