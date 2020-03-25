import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                    BlocProvider.of<ApuntesBloc>(context).add(RemoveDataEvent(index: widget.index));
                    _showAlertDialog();
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                    BlocProvider.of<ApuntesBloc>(context).add(SaveDataEvent(
                      imageUrl: widget.imageUrl,
                      materia: widget.materia,
                      descripcion: widget.descripcion
                  ));  
                },
              )
            ],
          ),
          Container(
            child: Text(
              "${widget.materia}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.grey,
              child: Image.network(
                widget.imageUrl ?? "https://via.placeholder.com/150",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.yellow[300],
            child: Text("${widget.descripcion}",
            style: TextStyle(fontSize: 18),),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }


  void _showAlertDialog(){
    showDialog(
      context: context,
      builder: (buildcontext){
        return AlertDialog(
          title:Text("Confirmación"),
          content: Text("¿Seguro que desea eliminar?"),
          actions: <Widget>[
            RaisedButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: (){
                final snackBar = SnackBar(
                  content: Text("Se ha eliminado"),
                );
              },
            )
          ],
        );
      }
    );
  }
}