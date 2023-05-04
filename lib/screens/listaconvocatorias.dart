import 'package:flutter/material.dart';

class listaConvocatoria extends StatelessWidget {

  final List<String> items = [    'Item 1',    'Item 2',    'Item 3',    'Item 4',    'Item 5'  , 'Item 1',    'Item 2',    'Item 3',    'Item 4',    'Item 5' ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
  title: TextField(
    decoration: InputDecoration(
      hintText: 'Buscar',
      border: InputBorder.none,
      prefixIcon: Icon(Icons.search),
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Opción 1'),
              ),
              PopupMenuItem(
                child: Text('Opción 2'),
              ),
              PopupMenuItem(
                child: Text('Opción 3'),
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    ),
  ),
),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Lista de convocatorias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    // Acción al hacer tap en el elemento
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          ],
        ),
      ),
    );

  }
}
