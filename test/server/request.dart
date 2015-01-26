// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains responses for testing [Request]s.
library dogma.rest_connection.test.server.request;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:shelf/shelf.dart' as shelf;

import '../shared/response.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

shelf.Response okResponseJson(shelf.Request request) {
  return new shelf.Response.ok(jsonSuccessReply);
}

shelf.Response okResponseText(shelf.Request request) {
  return new shelf.Response.ok(textSuccessReply);
}

shelf.Response okResponseBinary(shelf.Request request) {
  var values = new Int32List.fromList(binarySuccessReply);
  return new shelf.Response.ok(new Stream.fromIterable(binarySuccessReply));
}
