// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.tests.request;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';
import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:unittest/unittest.dart';
import 'package:dogma_rest_connection/src/request_factory.dart';

import '../shared/response.dart';
import '../shared/routes.dart';
import '../shared/runner.dart';

//---------------------------------------------------------------------
// Helpers
//---------------------------------------------------------------------

typedef void TestFunction();

/// Creates the test function.
TestFunction _testRequest(String url,
                          RequestMethod requestMethod,
                          ResponseType responseType,
                          String data,
                          dynamic expectedResult)
{
  return () {
    var result;
    var callLog;

    var callback = expectAsync(() {
      // Url should have been requested once
      expect(callLog[url], 1);

      // Payload should match
      expect(result, expectedResult);
    });

    var apiRequest = createRequest(url, requestMethod, responseType);

    apiRequest.send().then((apiValue) {
      result = (apiValue is ByteBuffer)
          ? apiValue.asInt32List()
          : apiValue;

      // Check that the right endpoint was invoked
      var callLogRequest = requestCallLog().then((callLogValue) {
        callLog = callLogValue;

        callback();
      });
    });
  };
}

/// Creates a group of requests for each method.
TestFunction _testRequestGroup(String name,
                               ResponseType responseType,
                               dynamic send,
                               dynamic receive,
                               String getRoute,
                               String putRoute,
                               String deleteRoute,
                               String postRoute)
{
  return () {
    group(name, () {
      test('GET', _testRequest(getRoute, RequestMethod.Get, responseType, send, receive));
      test('PUT', _testRequest(putRoute, RequestMethod.Put, responseType, send, receive));
      test('DELETE', _testRequest(deleteRoute, RequestMethod.Delete, responseType, send, receive));
      test('POST', _testRequest(postRoute, RequestMethod.Post, responseType, send, receive));
    });
  };
}

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

/// Group of text tests.
void _textTests() {
  _testRequestGroup(
      'Text',
      ResponseType.Text,
      '',
      textSuccessReply,
      routes['getRouteText'],
      routes['putRouteText'],
      routes['deleteRouteText'],
      routes['postRouteText']
  )();
}

/// Group of JSON tests.
void _jsonTests() {
  _testRequestGroup(
      'JSON',
      ResponseType.Json,
      '',
      JSON.decode(jsonSuccessReply),
      routes['getRouteJson'],
      routes['putRouteJson'],
      routes['deleteRouteJson'],
      routes['postRouteJson']
  )();
}

/// Group of binary tests.
void _binaryTests() {
  _testRequestGroup(
      'Binary',
      ResponseType.ByteBuffer,
      '',
      binarySuccessReply,
      routes['getRouteBinary'],
      routes['putRouteBinary'],
      routes['deleteRouteBinary'],
      routes['postRouteBinary']
  )();
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

/// Entry point for the tests.
void main() {
  group('Request', () {
    _textTests();
    _jsonTests();
    //_binaryTests();
  });
}
