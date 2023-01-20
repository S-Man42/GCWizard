import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

 import '../../../lib/widgets/main_menu/deep_link.dart';
import '../../../lib/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gcw_server/Controller.dart';
//http://localhost:4044/?sortIndex=2&sortAsc=0&offset=100&pageSize=50


Future main() async {
  var handler =
  const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  var server = await shelf_io.serve(handler, 'localhost', 4044);


  // Enable content compression
  server.autoCompress = true;


  print('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request _request) {
  var arguments = parseUrl(_request.handlerPath);

  request(arguments['title'],arguments);
  // var gcwTool = findGCWTool(arguments);

  return Response.ok('Request for "${_request.url}"  ' + DateTime.now().toString());
}
Map<String, dynamic> parseUrl(String url, {settings}) {

  var uri = Uri.parse(url);
  var title = uri.pathSegments[0];

  // MultiDecoder?input=Test%20String
  //Morse?input=Test%20String&modeencode=true
  //Morse?input=...%20---%20...
  //Morse?input=test&modeencode=true
  //alphabetvalues?input=Test
  //alphabetvalues?input=Test&modeencode=true&result=json
  //alphabetvalues?input=Test12&modeencode=true
  //alphabetvalues?input=1%202%203%204&modeencode=true
  //coords_formatconverter?fromformat=coords_utm
  //coords_formatconverter?fromformat=coords_utm?toformat=coords_utm ->Error
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&result=json     N48°23.123 E9°12.456
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_utm&result=json
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_all&result=json
  //rotation_general?input=test&parameter1=4&result=json

  // toolname?parameter1=xxx&parameter2=xxx
  return {'title': title, 'arguments': uri.queryParameters, 'settings': settings};
  // }
}


