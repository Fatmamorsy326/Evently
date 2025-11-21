import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerMap extends StatefulWidget {
  final LatLng? initialLocation;

  const LocationPickerMap({Key? key, this.initialLocation}) : super(key: key);

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  GoogleMapController? mapController;
  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  bool _isLoadingLocation = true;
  bool _isMapCreated = false;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _handleLocationError('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _handleLocationError('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _handleLocationError('Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;

        if (_selectedLocation == null) {
          _selectedLocation = _currentLocation;
        }

        _updateMarkers();

        if (_isMapCreated && mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
          );
        }
      });

    } catch (e) {
      _handleLocationError('Error getting location: $e');
    }
  }

  void _handleLocationError(String error) {
    print(error);
    setState(() {
      _isLoadingLocation = false;
      _currentLocation = LatLng(31.098899, 29.768523);
      if (_selectedLocation == null) {
        _selectedLocation = _currentLocation;
      }
      _updateMarkers();
    });
  }

  void _updateMarkers() {
    _markers.clear();
    if (_currentLocation != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'My Current Location'),
        ),
      );
    }

    if (_selectedLocation != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: _selectedLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Selected Event Location',
            snippet: '${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}',
          ),
        ),
      );
    }
  }

  void _addMarker(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _updateMarkers();
    });
  }

  void _moveToCurrentLocation() async {
    if (_currentLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
      );
    } else {
      await _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Event Location'),
        actions: [
          if (_selectedLocation != null)
            IconButton(
              icon: Icon(Icons.check, color: ColorsManager.blue),
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLocation ??
                  _selectedLocation ??
                  LatLng(31.098899, 29.768523),
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
                _isMapCreated = true;
              });

              if (_currentLocation != null) {
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
                );
              }
            },
            onTap: (LatLng location) {
              _addMarker(location);
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            zoomControlsEnabled: true,
          ),

          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              onPressed: _moveToCurrentLocation,
              backgroundColor: ColorsManager.blue,
              mini: true,
              child: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),

          if (_isLoadingLocation)
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Getting your location...'),
                  ],
                ),
              ),
            ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Event Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (_currentLocation != null)
                    Text(
                      '📍 Your current location is shown in blue',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  SizedBox(height: 4),
                  Text(
                    _selectedLocation != null
                        ? 'Selected: Lat: ${_selectedLocation!.latitude.toStringAsFixed(4)}, Lng: ${_selectedLocation!.longitude.toStringAsFixed(4)}'
                        : 'Tap on the map to select location',
                    style: TextStyle(fontSize: 14),
                  ),
                  if (_selectedLocation != null)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _selectedLocation);
                      },
                      child: Text('Confirm Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}