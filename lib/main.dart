import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/conotrollers/MenuController.dart';
import 'package:ecommerce_admin/pages/MainScreen.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


// code to show images from firebase 
// link -> https://stackoverflow.com/questions/65653801/flutter-web-cant-load-network-image-from-another-domain
// <script type="text/javascript">
//   window.flutterWebRenderer = "html";
// </script>

// firabase configuration 
// {
//     apiKey: "AIzaSyASjUY-FANBlTQ-vxigXB0wTKr7umDaSIw",
//     authDomain: "ecommerce-flutter-df4d5.firebaseapp.com",
//     projectId: "ecommerce-flutter-df4d5",
//     storageBucket: "ecommerce-flutter-df4d5.appspot.com",
//     messagingSenderId: "804026732908",
//     appId: "1:804026732908:web:4e2ac440f88fe27db76349",
//     measurementId: "G-4CBSEEXQ9W"
//   }

// tututorial conectarse Firebase -> https://www.youtube.com/watch?v=yL5_NHq-QMY&t=106s
// Link Firebase -> https://firebase.flutter.dev/docs/firestore/usage/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyASjUY-FANBlTQ-vxigXB0wTKr7umDaSIw",
          authDomain: "ecommerce-flutter-df4d5.firebaseapp.com", // // this has to be to upload images(I am not sure) 
          projectId: "ecommerce-flutter-df4d5",
          storageBucket: "ecommerce-flutter-df4d5.appspot.com", // thsi has to be to upload images
          messagingSenderId: "804026732908",
          appId: "1:804026732908:web:4e2ac440f88fe27db76349",
          measurementId: "G-4CBSEEXQ9W"));
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUsers();
  }

  void getUsers() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");

    QuerySnapshot users = await collectionReference.get();

    if (users.docs.length != 0) {
      for (var doc in users.docs) {
        print(doc.data());
      }
    } else {
      print('We could not get the data from FIRABASE');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor, // color del fondo
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white), // color de las letras
        canvasColor:
            secondaryColor, // color por defecto de los elementos que no estan en el fondo, amenos que se cambien
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
