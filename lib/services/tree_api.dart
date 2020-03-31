const String urlPrefix = 'http://openAPI.seoul.go.kr:8088/';
const String userKey = '65747a4f50746b6435355856614150';
const String urlSuffix = '/json/GeoInfoOfRoadsideTreeW/';
const String defaultStation = '중구';

const int STATUS_OK = 200;

String buildUrl(String station, int start, int end) {
  StringBuffer sb = StringBuffer();
  sb.write(urlPrefix);
  sb.write(userKey);
  sb.write(urlSuffix);
  sb.write('$start/$end/');
  sb.write(station);
  return sb.toString();
}
