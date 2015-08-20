// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains responses for testing [Request]s.
library dogma.rest_connection.test.server.basic_access_credentials;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:shelf/shelf.dart' as shelf;

import '../shared/response.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

shelf.Response basicAccessUsernamePassword(shelf.Request request) {
  if (request.headers['Authorization'] == 'Basic $tokenUsernamePassword') {
    return new shelf.Response.ok(jsonSuccessReply);
  } else {
    return new shelf.Response.forbidden('ERROR');
  }
}
