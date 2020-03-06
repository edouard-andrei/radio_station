class Station {
  final String logoPath;
  final String name;
  final String url;

  Station(this.logoPath, this.name, this.url);

  @override
  String toString() {
    return 'Station{logoPath: $logoPath, name: $name, url: $url}';
  }
}
