// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RequestIO] class.
library dogma.rest_connection.src.request_io;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request.dart';
import 'status_codes.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An implementation of [Request] using the dart:io library.
class RequestIO extends Request {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  static HttpClient _httpClient = new HttpClient();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a [RequestIO] for the given [url] using the specified [method] and [responseType].
  ///
  /// If [method] is not specified it is assumed to be [RequestMethod.Get]. If
  /// the [responseType] is not specified it is assumed to be
  /// [ResponseType.Json].
  RequestIO(String url, {RequestMethod method: RequestMethod.Get, ResponseType responseType: ResponseType.Json})
      : super(url, method, responseType);

  //---------------------------------------------------------------------
  // Request
  //---------------------------------------------------------------------

  @override
  Future<dynamic> send([dynamic data]) {
    var completer = new Completer<dynamic>();
    var methodString = requestMethodToString(method);

    _httpClient.openUrl(methodString, Uri.parse(url)).then((request) {
      // Set the headers
      var requestHeaders = request.headers;

      headers.forEach((header, value) {
        requestHeaders.set(header, value);
      });

      requestHeaders.contentType = ContentType.TEXT;

      // See if any data is being sent
      if (data != null) {
        // Deteremine the content type
        var contentType = ContentType.TEXT;

        if (data is TypedData) {
          contentType = ContentType.BINARY;
        } else if ((data is Map) || (data is List)) {
          contentType = ContentType.JSON;

          data = JSON.encode(data);
        }

        // Set the body
        request.write(data);
      }

      return request.close();
    })
    .then((response) {
      response.transform(UTF8.decoder).listen((contents) {
        var responseBody;

        if (responseType == ResponseType.Json) {
          responseBody = JSON.decode(contents);
        } else {
          responseBody = contents;
        }

        completer.complete(responseBody);
      });
    });

    return completer.future;
  }
}
