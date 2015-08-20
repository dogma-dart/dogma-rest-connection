// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.rest_connection_html;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:uri/uri.dart';

import 'rest_connection.dart';
import 'src/client.dart';
import 'src/request_factory_html.dart';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

export 'package:uri/uri.dart';

export 'rest_connection.dart';
export 'src/request_factory_html.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Creates a [Connection] and opens it.
///
/// This is a helper method to open a connection. If no [credentials] are
/// provided the connection is opened with annonymous credentials.
Future<RestConnection> openConnection(Map<String, UriTemplate> routes, [RestCredentials credentials]) {
  // Initialize the requests library
  initializeRequests();

  // Assign default credentials if necessary
  if (credentials == null) {
    credentials = new RestCredentials();
  }

  // Create the connection
  var connection = new RestConnection(new Client(credentials), routes);

  return connection.open(credentials);
}
