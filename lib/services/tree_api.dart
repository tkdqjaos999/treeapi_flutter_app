const String urlPrefix = 'http://openAPI.seoul.go.kr:8088/';
const String userKey = '676f754674746b6434324a43714878';
const String urlSuffix = '/json/GeoInfoRoadsideTree/1/10/';
const String defaultStation = '중구';

const int STATUS_OK = 200;

String buildUrl(String station) {
  StringBuffer sb = StringBuffer();
  sb.write(urlPrefix);
  sb.write(userKey);
  sb.write(urlSuffix);
  sb.write(station);
  return sb.toString();
}