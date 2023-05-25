import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskShowScreen extends StatelessWidget {
  const TaskShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var arg =
    TaskModel task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    GoogleMapController? _mapController;
    Set<Marker> _markers = {};

    void _addMarker(LatLng position) {
      _markers.clear(); // Clear previous markers
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
      Provider.of<TasksProvider>(context, listen: false)
          .setLocation(task, position.latitude, position.longitude);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TasksProvider(),
        child: Consumer<TasksProvider>(
          builder: (context, tasksProvider, _) {
            return Stack(
              children: [
                Image.network(
                  task.imageUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Tarefa: ${task.name}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Esforço (Hs): ${task.effortHours.toString()}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          markers: _markers,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(task.latitude, task.longitude),
                            zoom: 15.0,
                          ),
                          onTap: (position) {
                            _addMarker(position);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
