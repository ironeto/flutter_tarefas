import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../models/task_model.dart';

class TaskShowScreen extends StatelessWidget {
  const TaskShowScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final TaskModel task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    final TextEditingController nameController = TextEditingController(text: task.name);
    final TextEditingController effortHoursController = TextEditingController(text: task.effortHours.toString());
    LatLng _position = LatLng(0, 0);

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
      _position = position;
    }
    _addMarker(LatLng(task.latitude, task.longitude));

    void _save(String name, String effort) {
      Provider.of<TasksProvider>(context, listen: false).save(task, nameController.text, int.parse(effortHoursController.text), _position.latitude, _position.longitude);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, _) {
          return Stack(
            children: [
              Image.network(
                "https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg",
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
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: effortHoursController,
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
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ElevatedButton(
                  onPressed: () {
                    _save(nameController.text, effortHoursController.text);
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
