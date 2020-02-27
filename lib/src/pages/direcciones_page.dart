import 'package:flutter/material.dart';
import 'package:qreader/src/bloc/scan_bloc.dart';
import 'package:qreader/src/models/scan_model.dart';
import 'package:qreader/src/utils/utils.dart' as util;

class DireccionesPage extends StatelessWidget {

  final scanBloc = new ScanBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.streamScan ,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(child: Text('No hay información'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.redAccent,),
            onDismissed: (direction) => scanBloc.deleteScanById(scans[i].id), 
            child: ListTile(
              title: Text(scans[i].value),
              subtitle: Text('ID: ${scans[i].id}'),
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => util.openScan(context, scans[i]),
            )
          )
        );
      },
    );
  }
}