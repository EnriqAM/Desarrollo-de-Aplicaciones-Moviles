import 'package:flutter/material.dart';
import 'package:posts_app/comments.dart';
import 'package:posts_app/posts.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MainComments extends StatelessWidget {
  MainComments({this.list, this.list2});

  List<Comments> list2 = List();
  final Posts list;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( //Declaramos la barra de la aplicacion que estara hasta arriba
          centerTitle: true,  //Este metodo sirve para Centrar el texto que esta en la AppBar
          title: Text("Comments", style: GoogleFonts.fredokaOne(fontSize: 30.0)), //Agregamos el texto del titulo con un tipo de letra y tamaño diferentes
          backgroundColor: Colors.blueAccent, //Le agregamos color a la AppBar
        ),
        body: list2 == null
            ? Center(
          child: CircularProgressIndicator(), //Si la lista es nula muestra el tipico simbolo del circulo para indicar que se estan cargando los datos
        )
        :Column( //Declaramos el Column para poder mostrar tanto el post como los comentarios
          children: <Widget>[
            Card( //Inicializamos el metodo Card para mostrar el post de la publicacion original en una tarjeta
              margin: EdgeInsets.all(5.00), //Le agregamos un margen de 5 pixeles a la tarjeta
              child: ListTile( //Agregamos como child un ListTile para mostrar el contenido del Post
                leading: CircleAvatar(  //Este parametro indica que al principio de cada elemento va a haber un Avatar circular
                  backgroundImage: AssetImage("assets/images/Profile1.png"), //Le damos una imagen de la carpeta assets a ese avatar
                ),
                contentPadding: EdgeInsets.all(15.0),
                title: Text(list.title), //Agregamos el titulo del post
                subtitle: Text(list.body), //Agregamos el cuerpo del post
              ),
            ),
            Expanded(
                child: ListView.builder( //Declaramos el listView para mostrar los comentarios del post
              itemCount: list2.length,  //Declaramos cuantas veces sera llamado el metodo itemBuilder, en este caso el mismo numero de longitud de la lista
              itemBuilder: (BuildContext context, int index){
                return list2[index].postId == list.id //Regresamos una lista filtrada al itemBuilder donde solo va a a tomar los elementos que coincidan con el Id del post
                    ? ListTile( //Creamos el ListTile
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/Profile2.png"),
                    ),
                  contentPadding: EdgeInsets.all(20.0),
                  title: Text(list2[index].name), //Agregamos el titulo del comentario segun el indice del mismo
                  subtitle: Text('Email:' + //Como subtitulo agregamos un conjunto de elementos de la lista Creada con el JSON como una sola string
                  list2[index].email +  //Ponemos el elemento del email al texto
                  '\n' +
                  list2[index].body //Ponemos el cuerpo del comentario en el texto
                  ),
                trailing: Icon( //Agregamos un icono que indique al usuario que es un comentario
                  Icons.insert_comment,
                  color: Colors.blueAccent, // le agregamos color al icono
                  ),
                )
                : Center();
              },
              )
            )
          ]
        ),
    );
  }
}