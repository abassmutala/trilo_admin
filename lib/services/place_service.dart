import 'dart:convert';

import 'package:http/http.dart' as http;

class PlaceService {
  // final String sessionToken;

  // PlaceService(this.sessionToken);

  Future convertCoordinatesToAddress(double lat, double lng) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDI0LaXHJA3ZwjmwgS-FKXyK6xGkai-kuY";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status'] == 'OK') {
        dynamic result = request['results'][0]['formatted_address'];
        return result;
      }
      //     throw Exception(result['error_message']);
      //   } else {
      //     throw Exception('Failed to fetch suggestion');
      //   }
    }
  }

// class Place {
//   String streetNumber;
//   String street;
//   String city;
//   String zipCode;

//   Place({
//     this.streetNumber,
//     this.street,
//     this.city,
//     this.zipCode,
//   });

//   @override
//   String toString() {
//     return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
//   }
}

class PlaceApiProvider {
  final client = http.Client();

  PlaceApiProvider(this.sessionToken);

  final String sessionToken;

  // Future<Place> getPlaceDetailFromId(String placeId) async {
  //   final request =
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
  //   final response = await client.get(Uri.parse(request));
  //   if (response.statusCode == 200) {
  //     final result = json.decode(response.body);
  //     if (result['status'] == 'OK') {
  //       final components =
  //           result['result']['address_components'] as List<dynamic>;
  //       // build result
  //       final place = Place();
  //       components.forEach((c) {
  //         final List type = c['types'];
  //         if (type.contains('street_number')) {
  //           place.streetNumber = c['long_name'];
  //         }
  //         if (type.contains('route')) {
  //           place.street = c['long_name'];
  //         }
  //         if (type.contains('locality')) {
  //           place.city = c['long_name'];
  //         }
  //         if (type.contains('postal_code')) {
  //           place.zipCode = c['long_name'];
  //         }
  //       });
  //       return place;
  //     }
  //     throw Exception(result['error_message']);
  //   } else {
  //     throw Exception('Failed to fetch suggestion');
  //   }
  // }
}
