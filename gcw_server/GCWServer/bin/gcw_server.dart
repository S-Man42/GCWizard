import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../../GCWizard/lib/logic/tools/crypto_and_encodings/reverse.dart';

//http://localhost:4044/?sortIndex=2&sortAsc=0&offset=100&pageSize=50


Future main() async {
  var handler =
  const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  var server = await shelf_io.serve(handler, 'localhost', 4044);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request request) {
  return Response.ok('Request for "${request.url}"  ' + DateTime.now().toString());
}



