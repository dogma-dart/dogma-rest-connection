// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RestConnection] class.
library dogma_rest_connection.src.rest_connection;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_connection/connection.dart';
import 'package:dogma_connection/expression.dart';
import 'package:dogma_rest_client/rest_client.dart';
import 'package:uri/uri.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A connection to a RESTful API.
///
/// An instance of [RestConnection] requires a [RestClient] which is used to
/// make the HTTP requests, and a mapping of routes.
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

  /// The [RestClient] to use to connect to the REST api.
  final RestClient _client;
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

  RestClient get client => _client;

  @override
  Future<dynamic> query(Query query) {
    var uri = _getRoute(query.table, query.where);

    return (uri != null)
        ? _client.open(uri, 'GET')
        : new Future<Null>.value();
  }

  @override
  Stream<dynamic> queryAll(Query query) async* {
    var uri = _getRoute(query.table, query.where);

    if (uri != null) {
      var values = await _client.open(uri, 'GET');

      if (values is List) {
        for (var value in values) {
          yield value;
        }
      } else {
        yield values;
      }
    }
  }

  @override
  Future<dynamic> execute(Command command) {
    var uri = _getRoute(command.table, command.where);

    return (uri != null)
        ? _client.open(uri, 'POST')
        : new Future<Null>.value();
  }

  Uri _getRoute(String table, Expression where) {
    var template = _routes[table];

    if (template != null) {
      var variables = <String, String>{};

      if (where != null) {
        _mapClauses(where, variables);
      }

      return Uri.parse(template.expand(variables));
    }

    return null;
  }

  void _mapClauses(Expression expression, Map<String, String> whereClauses) {
    var nodeType = expression.nodeType;

    if (expression is BinaryExpression) {
      if (nodeType == ExpressionType.and) {
        _mapClauses(expression.left, whereClauses);
        _mapClauses(expression.right, whereClauses);
      } else if (nodeType == ExpressionType.equal) {
        var key = expression.left.name;
        var current = whereClauses[key];
        var right = expression.right.value.toString();
        var value;

        if (current != null) {
          value = current + ',' + right;
        } else {
          value = right;
        }

        whereClauses[key] = value;
      }
    }
  }
}
