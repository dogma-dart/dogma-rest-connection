// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.server.server;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';

import 'request.dart';
import '../shared/routes.dart';

//---------------------------------------------------------------------
// Call logs
//---------------------------------------------------------------------

/// The number of calls a particular API has received.
///
/// Outputted by the /api/call_logs API.
final callLogs = new Map<String, int>();

shelf.Response _apiCallLogging(shelf.Request request) {
  var api = toServerRoute(request.url.path);

  callLogs.putIfAbsent(api, () => 0);
  callLogs[api]++;

  return null;
}

shelf.Middleware _logApiCalls = shelf.createMiddleware(requestHandler: _apiCallLogging);

shelf.Response _callLogs(shelf.Request request) {
  var encoded = JSON.encode(callLogs);

  callLogs.clear();

  return new shelf.Response.ok(encoded);
}

//---------------------------------------------------------------------
// Application
//---------------------------------------------------------------------

void main(List<String> args) {
  var appRouter = router()
                   // Request the API routes
                   ..get(apiRoute, _apiRoutes)
                   // Request the calls
                   ..get(callLogRoute, _callLogs)
                   // Request JSON test routes
                   ..get(getRouteJson, okResponseJson)
                   ..post(postRouteJson, okResponseJson)
                   ..put(putRouteJson, okResponseJson)
                   ..delete(deleteRouteJson, okResponseJson)
                   // Request text test routes
                   ..get(getRouteText, okResponseText)
                   ..post(postRouteText, okResponseText)
                   ..put(putRouteText, okResponseText)
                   ..delete(deleteRouteText, okResponseText)
                   // Request binary test routes
                   ..get(getRouteBinary, okResponseBinary)
                   ..post(postRouteBinary, okResponseBinary)
                   ..put(putRouteBinary, okResponseBinary)
                   ..delete(deleteRouteBinary, okResponseBinary);

  var handler = const shelf.Pipeline()
      .addMiddleware(_logApiCalls)
      .addMiddleware(shelf.logRequests())
      .addHandler(appRouter.handler);

  io.serve(handler, 'localhost', port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

shelf.Response _apiRoutes(shelf.Request request) {
  return new shelf.Response.ok(JSON.encode(routes));
}
