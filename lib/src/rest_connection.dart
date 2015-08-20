// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RestConnection] class.
library dogma.rest_connection.src.rest_connection;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_connection/connection.dart';
import 'package:uri/uri.dart';

import 'client.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A connection to a RESTful API.
///
/// An instance of [RestConnection] requires a [Client] which is used to make
/// the HTTP requests, and a mapping of routes.
///
///     var routes = new Map<String, UriTemplate>();
///
///     routes['resources'] = new UriTemplate('http://example.com/resources/');
///     routes['item'] = new UriTemplate('http://example.com/resources/{id}');
///
///     var connection = new RestConnection(new ClientHtml(), routes);
///
///     var resourceQuery = new Query.select('resources');
///
///     connection.execute(resourceQuery).then((value) {
///       // Calls http://example.com/resources/ and returns JSON data
///     });
///
///     var itemQuery = new Query.select('item');
///
///     itemQuery.where('id', '42');
///
///     connection.execute(itemQuery).then((value) {
///       // Calls http://example.com/resources/42/ and returns JSON data
///     });
class RestConnection implements Connection {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [Client] to use to connect to the REST api.
  final Client _client;
  /// The routes within the REST api.
  final Map<String, UriTemplate> _routes;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a
  RestConnection(this._client, this._routes);

  //---------------------------------------------------------------------
  // Connection
  //---------------------------------------------------------------------

  @override
  Future<dynamic> open(Credentials credentials) async {

  }

  @override
  Future<dynamic> query(Query query) async {

  }

  @override
  Future<dynamic> execute(Command command) async {

  }
}
