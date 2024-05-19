class LocationModel {
  double? lat;
  double? lon;

  LocationModel(
    this.lat,
    this.lon,
  );

  LocationModel.fromJson({required Map<String, dynamic> json}) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "lon": lon,
    };
  }
}
