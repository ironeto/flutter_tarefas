import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../providers/task_provider.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  double _effortHours = 0;
  LatLng _position = LatLng(0, 0);

  bool _validateName = false;

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _position = LatLng(position.latitude, position.longitude);
        _addMarker(_position);
      });
    } catch (e) {
      print('Error retrieving current location: $e');
      // Default position (e.g., a specific location or your desired fallback)
      LatLng defaultPosition = LatLng(37.7749, -122.4194);
      setState(() {
        _position = defaultPosition;
        _addMarker(_position);
      });
    }
  }

  void _createTask(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final String name = _nameController.text;

    tasksProvider.addTask(name, _effortHours.toInt(), _position.latitude, _position.longitude);

    Navigator.of(context).pop(); // Navigate back to the task list screen
  }

  bool _validateFields() {
    bool isValid = true;

    if (_nameController.text.isEmpty) {
      setState(() {
        _validateName = true;
      });
      isValid = false;
    } else {
      setState(() {
        _validateName = false;
      });
    }

    return isValid;
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear(); // Clear previous markers
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Criar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  errorText: _validateName ? 'O campo Nome é obrigatório' : null,
                ),
              ),
              SizedBox(height: 16.0),
              SpinBox(
                value: _effortHours,
                min: 0,
                max: 24,
                onChanged: (value) {
                  setState(() {
                    _effortHours = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Esforço (Hs)',
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: _position,
                      zoom: 2.0,
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
                    onPressed: () {
                      if (_validateFields()) {
                        _createTask(context);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
