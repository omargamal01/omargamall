class LocationModel2 {
  double? lat;
  double? lon;
  String ? title;

  LocationModel2(
      this.lat,
      this.lon,
      this.title
      );

  LocationModel2.fromJson({required Map<String, dynamic> json}) {
    lat = json['lat'];
    lon = json['lon'];
    title = json['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "lon": lon,
      "title": title,
    };
  }
}
