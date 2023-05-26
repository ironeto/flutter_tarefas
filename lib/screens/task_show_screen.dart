import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../models/task_model.dart';

class TaskShowScreen extends StatefulWidget {
  const TaskShowScreen({Key? key});

  @override
  _TaskShowScreenState createState() => _TaskShowScreenState();
}

class _TaskShowScreenState extends State<TaskShowScreen> {
  TaskModel? task;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController effortHoursController = TextEditingController();
  LatLng _position = LatLng(0, 0);

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  bool _validateName = false;
  bool _validateEffortHours = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      task = ModalRoute.of(context)?.settings.arguments as TaskModel;
      nameController.text = task?.name ?? '';
      effortHoursController.text = task?.effortHours.toString() ?? '';
      _addMarker(LatLng(task!.latitude, task!.longitude));
    });
  }

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

  void _save() {
    final String name = nameController.text;
    final String effort = effortHoursController.text;
    final int effortHours = int.tryParse(effort) ?? 0;

    setState(() {
      _validateName = name.isEmpty;
      _validateEffortHours = effort.isEmpty;
    });

    if (!_validateName && !_validateEffortHours) {
      Provider.of<TasksProvider>(context, listen: false).save(
        task!,
        name,
        effortHours,
        _position.latitude,
        _position.longitude,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task?.name ?? ''),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, _) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        errorText: _validateName ? 'Name is required' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Effort Hours:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: effortHoursController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorText: _validateEffortHours ? 'Effort is required' : null,
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
                          target: LatLng(task?.latitude ?? 0, task?.longitude ?? 0),
                          zoom: 15.0,
                        ),
                        onTap: (position) {
                          _addMarker(position);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _save,
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
