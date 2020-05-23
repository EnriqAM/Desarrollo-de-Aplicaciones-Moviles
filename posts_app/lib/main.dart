import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posts_app/main_posts.dart';

void main(){
  runApp(MaterialApp(
    title: "Posts App", //Este es el titulo de la app
    theme: ThemeData(
      primarySwatch: Colors.blue,

      textTheme: TextTheme( //Creamos un tema para el texto
        bodyText2: GoogleFonts.sourceSansPro(fontSize: 15.0) //Declaramos que todo el texto tendrá este tipo de letra
      )
    ),
    home: MainPostsData(),
    //home: PostsList(),
    debugShowCheckedModeBanner: false,
  ));
}
