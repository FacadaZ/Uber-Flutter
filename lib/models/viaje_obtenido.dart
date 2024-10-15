// To parse this JSON data, do
//
//     final viajeObtenido = viajeObtenidoFromJson(jsonString);

import 'dart:convert';

ViajeObtenido viajeObtenidoFromJson(String str) =>
    ViajeObtenido.fromJson(json.decode(str));

String viajeObtenidoToJson(ViajeObtenido data) => json.encode(data.toJson());

class ViajeObtenido {
  int id;
  String name;
  String latOrigin;
  String lngOrigin;
  String latDestination;
  String lngDestination;
  DateTime date;
  String startTime;
  int price;
  int status;
  int driverId;
  double? distanceDestination;
  Driver driver;
  List<Stop> stops;
  List<dynamic> passengers;

  ViajeObtenido({
    required this.id,
    required this.name,
    required this.latOrigin,
    required this.lngOrigin,
    required this.latDestination,
    required this.lngDestination,
    required this.date,
    required this.startTime,
    required this.price,
    required this.status,
    required this.driverId,
    required this.distanceDestination,
    required this.driver,
    required this.stops,
    required this.passengers,
  });

  factory ViajeObtenido.fromJson(Map<String, dynamic> json) => ViajeObtenido(
        id: json["id"],
        name: json["name"],
        latOrigin: json["latOrigin"],
        lngOrigin: json["lngOrigin"],
        latDestination: json["latDestination"],
        lngDestination: json["lngDestination"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"].trim(),
        price: json["price"],
        status: json["status"],
        driverId: json["driverId"],
        distanceDestination: json["distanceDestination"]?.toDouble(),
        driver: Driver.fromJson(json["driver"]),
        stops:
            List<Stop>.from((json["stops"] ?? []).map((x) => Stop.fromJson(x))),
        passengers: List<dynamic>.from(json["passengers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latOrigin": latOrigin,
        "lngOrigin": lngOrigin,
        "latDestination": latDestination,
        "lngDestination": lngDestination,
        "date": date.toIso8601String(),
        "startTime": startTime,
        "price": price,
        "status": status,
        "driverId": driverId,
        "distanceDestination": distanceDestination,
        "driver": driver.toJson(),
        "stops": List<dynamic>.from(stops.map((x) => x.toJson())),
        "passengers": List<dynamic>.from(passengers.map((x) => x)),
      };
}

class Driver {
  int id;
  String fullname;
  String email;
  int type;
  DateTime createdAt;
  DateTime updatedAt;

  Driver({
    required this.id,
    required this.fullname,
    required this.email,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Stop {
  int id;
  String lat;
  String lng;
  DateTime time;
  int visited;
  int tripId;
  int passengerQty;
  DateTime createdAt;
  DateTime updatedAt;

  Stop({
    required this.id,
    required this.lat,
    required this.lng,
    required this.time,
    required this.visited,
    required this.tripId,
    required this.passengerQty,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
        id: json["id"],
        lat: json["lat"],
        lng: json["lng"],
        time: DateTime.parse(json["time"]),
        visited: json["visited"],
        tripId: json["tripId"],
        passengerQty: json["passengerQty"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "time": time.toIso8601String(),
        "visited": visited,
        "tripId": tripId,
        "passengerQty": passengerQty,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
