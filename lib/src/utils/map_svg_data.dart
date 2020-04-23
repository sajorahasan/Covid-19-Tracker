class MapData {
  static String getIndiaMapData() {
    return Uri.dataFromString('', mimeType: 'text/html').toString();
  }
}
