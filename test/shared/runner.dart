// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.shared.runner;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_rest_connection/src/request_factory.dart';

import 'routes.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Requests the call log
Future requestCallLog() {
  var request = createRequest(toServerRoute(callLogRoute), RequestMethod.Get, ResponseType.Json);

  return request.send();
}

/// Tests the server connection before beginning the tests.
Future testServerConnection() {
  var completer = new Completer();
  var request = createRequest(toServerRoute(apiRoute), RequestMethod.Get, ResponseType.Json);

  request.send().then((value) {
    // This is just a hack to avoid comparing each key value pair
    var valueString = JSON.encode(value);
    var routeString = JSON.encode(routes);

    if (valueString == routeString) {
      completer.complete();
    } else {
      completer.completeError(new Error());
    }
  });

  return completer.future;
}
