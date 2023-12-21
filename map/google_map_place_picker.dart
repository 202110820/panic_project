import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_maps_place_picker.dart';
import 'place_provider.dart';
import 'animated_pin.dart';
import 'floating_card.dart';
import 'place_picker.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact2/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SelectedPlaceWidgetBuilder = Widget Function(
    BuildContext context,
    PickResult? selectedPlace,
    SearchingState state,
    bool isSearchBarFocused,
    );

typedef PinBuilder = Widget Function(
    BuildContext context,
    PinState state,
    );

final _markers = <Marker>{};
class GoogleMapPlacePicker extends StatelessWidget {

  String? email; // email 저장할 변수
  List<Map<String, dynamic>> latlngList = []; // 위도 경도 저장할 리스트
  //final _markers = <Marker>{};
  // 로그인된 사용자의 이메일을 가져오는 함수

  Future<void> getEmail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool('isLogin') ?? false;
      _markers.clear();
      //getLocations();
      if (isLogin) {
        String? userEmail = prefs.getString('email'); // 'email' 키로 저장된 값을 불러옴
        if (userEmail != null) {
          email = userEmail;
        } else {
          null;
          // 로그인이 되어 있지만 이메일 정보가 없는 경우의 처리
          print('No documents found for the given email.');
        }
      }
      else {
        print('No documents found for the given email.');
      }
    }
    catch (e) {
      print('오류 발생: $e');
    }
  }

  Future<void> getLocations() async {
    try {
      await getEmail();
      print('사용자 이메일: ${email}');
      _markers.clear();
      //getLocations();
      // Firebase에서 위치 데이터 가져오기
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance.collection('Mymap').where("email", isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        // documents가 비어있지 않은 경우에만 처리
        latlngList = snapshot.docs.map<Map<String, dynamic>>((
            DocumentSnapshot<Map<String, dynamic>> document) {
          // 'lat' 및 'lng' 필드의 존재 여부 확인 후 값 읽어오기
          String address = document.data()!['address'] ?? '';
          double lat = document.data()!['lat'] ?? 0.0;
          double lng = document.data()!['lng'] ?? 0.0;
          return {'address': address, 'lat': lat, 'lng': lng};
        }).toList();
        _markers.clear();
        _markers.addAll(
            latlngList.map(
                    (e) => Marker(
                  markerId: MarkerId(e['address'] as String),
                  infoWindow: InfoWindow(title: e['address'] as String),
                  alpha: 0.5,

                  position: LatLng(
                    e['lat'] as double,
                    e['lng'] as double,
                  ),
                ),
            ),
        );
        //print('위도 경도 리스트: ${latlngList}');
        print('!!!!!!!!!!!!!!!!!!!!!: ${_markers}');
        latlngList = latlngList;
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  GoogleMapPlacePicker({

    Key? key,
    required this.initialTarget,
    required this.appBarKey,
    this.selectedPlaceWidgetBuilder,
    this.pinBuilder,
    this.onSearchFailed,
    this.onMoveStart,
    this.onMapCreated,
    this.debounceMilliseconds,
    this.enableMapTypeButton,
    this.enableMyLocationButton,
    this.onToggleMapType,
    this.onMyLocation,
    this.onPlacePicked,
    this.usePinPointingSearch,
    this.usePlaceDetailSearch,
    this.selectInitialPosition,
    this.language,
    this.forceSearchOnZoomChanged,
    this.hidePlaceDetailsWhenDraggingPin,
  }) : super(key: key);

  final LatLng initialTarget;
  final GlobalKey appBarKey;

  final SelectedPlaceWidgetBuilder? selectedPlaceWidgetBuilder;
  final PinBuilder? pinBuilder;

  final ValueChanged<String>? onSearchFailed;
  final VoidCallback? onMoveStart;
  final MapCreatedCallback? onMapCreated;
  final VoidCallback? onToggleMapType;
  final VoidCallback? onMyLocation;
  final ValueChanged<PickResult>? onPlacePicked;

  final int? debounceMilliseconds;
  final bool? enableMapTypeButton;
  final bool? enableMyLocationButton;

  final bool? usePinPointingSearch;
  final bool? usePlaceDetailSearch;

  final bool? selectInitialPosition;

  final String? language;

  final bool? forceSearchOnZoomChanged;
  final bool? hidePlaceDetailsWhenDraggingPin;


  _searchByCameraLocation(PlaceProvider provider) async {
    // We don't want to search location again if camera location is changed by zooming in/out.
    if (forceSearchOnZoomChanged == false && provider.prevCameraPosition != null && provider.prevCameraPosition!.target.latitude == provider.cameraPosition!.target.latitude && provider.prevCameraPosition!.target.longitude == provider.cameraPosition!.target.longitude) {
      provider.placeSearchingState = SearchingState.Idle;
      return;
    }

    provider.placeSearchingState = SearchingState.Searching;

    final GeocodingResponse response = await provider.geocoding.searchByLocation(
      Location(lat: provider.cameraPosition!.target.latitude, lng: provider.cameraPosition!.target.longitude),
      language: language,
    );

    if (response.errorMessage?.isNotEmpty == true || response.status == "REQUEST_DENIED") {
      print("Camera Location Search Error: " + response.errorMessage!);
      if (onSearchFailed != null) {
        onSearchFailed!(response.status);
      }
      provider.placeSearchingState = SearchingState.Idle;
      return;
    }

    if (usePlaceDetailSearch!) {
      final PlacesDetailsResponse detailResponse = await provider.places.getDetailsByPlaceId(
        response.results[0].placeId,
        language: language,
      );

      if (detailResponse.errorMessage?.isNotEmpty == true || detailResponse.status == "REQUEST_DENIED") {
        print("Fetching details by placeId Error: " + detailResponse.errorMessage!);
        if (onSearchFailed != null) {
          onSearchFailed!(detailResponse.status);
        }
        provider.placeSearchingState = SearchingState.Idle;
        return;
      }

      provider.selectedPlace = PickResult.fromPlaceDetailResult(detailResponse.result);
    } else {
      provider.selectedPlace = PickResult.fromGeocodingResult(response.results[0]);
    }

    provider.placeSearchingState = SearchingState.Idle;
  }


  @override
  Widget build(BuildContext context) {
    //_markers.clear();

    getLocations();
    return Stack(
      children: <Widget>[
        _buildGoogleMap(context,),
        _buildPin(),
        _buildFloatingCard(),
        _buildMapIcons(context),
      ],
    );
  }


  Widget _buildGoogleMap(BuildContext context) {
    return Selector<PlaceProvider, MapType>(

        selector: (_, provider) => provider.mapType,
        builder: (_, data, __) {

          PlaceProvider provider = PlaceProvider.of(context, listen: false);
          CameraPosition initialCameraPosition = CameraPosition(target: initialTarget, zoom: 15);
          //_markers.clear();
          getLocations();
          //getLocations();
          print('!!!!!!!!!!!!!!!!!!!!!: ${_markers}');

          return GoogleMap(

            markers: _markers,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: initialCameraPosition,
            mapType: data,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              provider.mapController = controller;
              provider.setCameraPosition(null);
              provider.pinState = PinState.Idle;

              // When select initialPosition set to true.
              if (selectInitialPosition!) {
                provider.setCameraPosition(initialCameraPosition);
                _searchByCameraLocation(provider);
              }
            },

            onCameraIdle: () {
              if (provider.isAutoCompleteSearching) {
                provider.isAutoCompleteSearching = false;
                provider.pinState = PinState.Idle;
                provider.placeSearchingState = SearchingState.Idle;
                return;
              }

              // Perform search only if the setting is to true.
              if (usePinPointingSearch!) {
                // Search current camera location only if camera has moved (dragged) before.
                if (provider.pinState == PinState.Dragging) {
                  // Cancel previous timer.
                  if (provider.debounceTimer?.isActive ?? false) {
                    provider.debounceTimer!.cancel();
                  }
                  provider.debounceTimer = Timer(Duration(milliseconds: debounceMilliseconds!), () {
                    _searchByCameraLocation(provider);
                  });
                }
              }

              provider.pinState = PinState.Idle;
            },
            onCameraMoveStarted: () {
              provider.setPrevCameraPosition(provider.cameraPosition);

              // Cancel any other timer.
              provider.debounceTimer?.cancel();

              // Update state, dismiss keyboard and clear text.
              provider.pinState = PinState.Dragging;

              // Begins the search state if the hide details is enabled
              if (this.hidePlaceDetailsWhenDraggingPin!) {
                provider.placeSearchingState = SearchingState.Searching;
              }

              onMoveStart!();
            },
            onCameraMove: (CameraPosition position) {
              provider.setCameraPosition(position);
            },
            // gestureRecognizers make it possible to navigate the map when it's a
            // child in a scroll view e.g ListView, SingleChildScrollView...
            gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
          );
        });
  }

  Widget _buildPin() {
    return Center(
      child: Selector<PlaceProvider, PinState>(
        selector: (_, provider) => provider.pinState,
        builder: (context, state, __) {
          if (pinBuilder == null) {
            return _defaultPinBuilder(context, state);
          } else {
            return Builder(builder: (builderContext) => pinBuilder!(builderContext, state));
          }
        },
      ),
    );
  }

  Widget _defaultPinBuilder(BuildContext context, PinState state) {
    if (state == PinState.Preparing) {
      return Container();
    } else if (state == PinState.Idle) {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.place, size: 36, color: Color(0xFF62B6B6)),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedPin(child: Icon(Icons.place, size: 36, color: Color(0xFF62B6B6))),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFloatingCard() {
    return Selector<PlaceProvider, Tuple4<PickResult?, SearchingState, bool, PinState>>(
      selector: (_, provider) => Tuple4(provider.selectedPlace, provider.placeSearchingState, provider.isSearchBarFocused, provider.pinState),
      builder: (context, data, __) {
        if ((data.item1 == null && data.item2 == SearchingState.Idle) || data.item3 == true || data.item4 == PinState.Dragging && this.hidePlaceDetailsWhenDraggingPin!) {
          return Container();
        } else {
          if (selectedPlaceWidgetBuilder == null) {
            return _defaultPlaceWidgetBuilder(context, data.item1, data.item2);
          } else {
            return Builder(builder: (builderContext) => selectedPlaceWidgetBuilder!(builderContext, data.item1, data.item2, data.item3));
          }
        }
      },
    );
  }

  Widget _defaultPlaceWidgetBuilder(BuildContext context, PickResult? data, SearchingState state) {
    return FloatingCard(
      bottomPosition: MediaQuery.of(context).size.height * 0.05,
      leftPosition: MediaQuery.of(context).size.width * 0.025,
      rightPosition: MediaQuery.of(context).size.width * 0.025,
      width: MediaQuery.of(context).size.width * 0.9,
      borderRadius: BorderRadius.circular(12.0),
      elevation: 4.0,
      color: Theme.of(context).cardColor,
      child: state == SearchingState.Searching ? _buildLoadingIndicator() : _buildSelectionDetails(context, data!),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 48,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  //밑 card 위젯
  Widget _buildSelectionDetails(BuildContext context, PickResult result) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            result.formattedAddress!,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xFF62B6B6),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Select here",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),

            onPressed: () {
              onPlacePicked!(result);

            },
          ),
        ],
      ),
    );
  }


  //현재 위치로 갈 수 있는 버튼
  Widget _buildMapIcons(BuildContext context) {
    final RenderBox appBarRenderBox = appBarKey.currentContext!.findRenderObject() as RenderBox;

    return Positioned(
      top: appBarRenderBox.size.height,
      right: 15,
      child: Column(
        children: <Widget>[
          enableMapTypeButton!
              ? Container(
            width: 35,
            height: 35,
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white,
              elevation: 8.0,
              onPressed: onToggleMapType,
              child: Icon(Icons.layers),
            ),
          )
              : Container(),
          SizedBox(height: 10),
          enableMyLocationButton!
              ? Container(
            width: 35,
            height: 35,
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white,
              elevation: 8.0,
              onPressed: onMyLocation,
              child: Icon(Icons.my_location),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
