import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/main_comments.dart';
import 'package:posts_app/posts.dart';
import 'package:posts_app/comments.dart';
import 'package:http/http.dart' as http;

class MainPostsData extends StatefulWidget {
  @override
  _MainPostsDataState createState() => _MainPostsDataState();
}

class _MainPostsDataState extends State<MainPostsData> {
  List<Posts> list = List(); //Declaramos la Lista de los Posts
  List<Comments> list2 = List(); //Declaramos la lista de los Comments

  @override
  void initState() { //Inicializamos los metodos
    super.initState();
    fetchData();
    fetchComments();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blueAccent, ));
  }

  void fetchData() async { //Este metodo sirve para poder tomar tomar los datos del archivo JSON alojado en la web
    final response = await http.get(
        "https://raw.githubusercontent.com/EnriqAM/Desarrollo-de-Aplicaciones-Moviles/master/posts.json"); //Con el metodo http.get tomamos los datos del link ingresado
    list = (json.decode(response.body) as List)                                   //Los datos se almacenan en una lista
        .map((data) => new Posts.fromJson(data))
        .toList();
    setState(() {});
  }

  void fetchComments() async { //Este metodo sirve para poder tomar tomar los datos del archivo JSON alojado en la web
    final response = await http.get(
        "https://raw.githubusercontent.com/EnriqAM/Desarrollo-de-Aplicaciones-Moviles/master/comments.json"); //Con el metodo http.get tomamos los datos del link ingresado
    list2 = (json.decode(response.body) as List)                                     //Los datos se almacenan en una lista
        .map((data) => new Comments.fromJson(data))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( //Declaramos la barra de la aplicacion que estara hasta arriba
          title: Row(   //El titulo lo declaramos como un Row para poder incluir mas elementos que solo texto
            mainAxisAlignment: MainAxisAlignment.center, //Centramos los elementos en la barra
            children: [
              Image.asset(   // Tomamos la imagen del logo desde la carpeta de assets
                'assets/images/Logo.png',
                fit: BoxFit.contain, //Declaramos que la imagen se adapte al tamaño del espacio
                height: 32,
              ),
              Container( //Declaramos un container que tendra el texto, con su tipo de letra, para con el nombre de la app a un lado del logotipo
                  padding: const EdgeInsets.all(8.0), child: Text('Posts App', style: GoogleFonts.fredokaOne(fontSize: 30.0),))
            ],

          ),
          backgroundColor: Colors.blueAccent, //Le agregamos color a la App Bar

        ),
        body: list == null
            ? Center(
          child: CircularProgressIndicator(), //Si la lista es nula muestra el tipico simbolo del circulo para indicar que se estan cargando los datos
        )
            : ListView.separated( //Declaramos una ListView.separated para mostrar los elementos separados cada uno
              separatorBuilder: (context, index) => Divider(  //Declaramos el separador
                color: Colors.black,  //Le agregamos parametros al separador, en este caso el color del mismo
              ),
            itemCount: list.length,  //Declaramos cuantas veces sera llamado el metodo itemBuilder, en este caso el mismo numero de longitud de la lista
            itemBuilder: (BuildContext context, int index) { //Declaramos el ItemBuilder
              return ListTile(  //Regresamos un ListTile al itemBuilder para que se construya la lista
                leading: CircleAvatar(  //Este parametro indica que al principio de cada elemento va a haber un Avatar circular
                  backgroundImage: AssetImage("assets/images/Profile1.png"),  //Le agregamos una foto de la carpeta de assets al avatar circular
                ),
                contentPadding: EdgeInsets.all(20.0), //Le agregamos un margen de 20 pixeles a cada direccion del contenido de la lista
                title: Text(list[index].title), //Declaramos el titulo del elemento como texto y segun el indice de la lista creada con el JSON anteriormente
                onTap:() {  //El metodo OnTap sirve para agregarle una accion cada que toquemos el elemento
                  Navigator.push(context,   //Declaramos que cada toque nos lleve a otro widget donde estaran los comentarios de los Posts
                  MaterialPageRoute(builder: (context) => MainComments(list:list[index], list2:list2)));  //Agregamos la Ruta del segundo Widget y le damos por parametros las 2 listas creadas
                },
                subtitle: Text(list[index].body), //Agregamos el cuerpo del Post como texto y segun el indice de la lista creada con el JSON anteriormente
                trailing: Icon(
                  Icons.keyboard_arrow_down, //Le agregamos un icono al elemento para hacerlo mas intuitivo y dar a entender que se puede presionar
                  color: Colors.blue, //Le damos un color al Icono
                ),
              );
            }
            )
    );
  }
}