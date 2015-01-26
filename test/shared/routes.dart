// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.shared.routes;

//---------------------------------------------------------------------
// Server
//---------------------------------------------------------------------

const port = 3030;

//---------------------------------------------------------------------
// Api routes
//---------------------------------------------------------------------

const apiRoute = '/api';
const callLogRoute = '/api/calls';

//---------------------------------------------------------------------
// Request routes
//---------------------------------------------------------------------

const getRouteJson    = '/api/rest_test/json/get';
const postRouteJson   = '/api/rest_test/json/post';
const putRouteJson    = '/api/rest_test/json/put';
const deleteRouteJson = '/api/rest_test/json/delete';

const getRouteText    = '/api/rest_test/text/get';
const postRouteText   = '/api/rest_test/text/post';
const putRouteText    = '/api/rest_test/text/put';
const deleteRouteText = '/api/rest_test/text/delete';

const getRouteBinary    = '/api/rest_test/binary/get';
const postRouteBinary   = '/api/rest_test/binary/post';
const putRouteBinary    = '/api/rest_test/binary/put';
const deleteRouteBinary = '/api/rest_test/binary/delete';

//---------------------------------------------------------------------
// Rotuing api response
//---------------------------------------------------------------------

String toServerRoute(String route) => 'http://localhost:${port}${route}';

var routes = {
  'getRouteJson'   : toServerRoute(getRouteJson),
  'postRouteJson'  : toServerRoute(postRouteJson),
  'putRouteJson'   : toServerRoute(putRouteJson),
  'deleteRouteJson': toServerRoute(deleteRouteJson),

  'getRouteText'   : toServerRoute(getRouteText),
  'postRouteText'  : toServerRoute(postRouteText),
  'putRouteText'   : toServerRoute(putRouteText),
  'deleteRouteText': toServerRoute(deleteRouteText),

  'getRouteBinary'   : toServerRoute(getRouteBinary),
  'postRouteBinary'  : toServerRoute(postRouteBinary),
  'putRouteBinary'   : toServerRoute(putRouteBinary),
  'deleteRouteBinary': toServerRoute(deleteRouteBinary),
};
