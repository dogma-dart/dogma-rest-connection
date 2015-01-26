// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Request] class.
library dogma.rest_connection.src.request;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request_method.dart';
import 'response_type.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'request_method.dart';
export 'response_type.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Performs a HTTP request.
///
/// The [Request] class provides a common interface for making HTTP requests
/// running on the client [dart:html] and on the server [dart:io]. The actual
/// mechanics of making the actual request are handled by the subclass
/// implementation.
abstract class Request {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The URL being requested.
  final String url;
  /// The method for the HTTP Request.
  final RequestMethod method;
  /// The type of data being requested.
  final ResponseType responseType;
  /// The headers to use when sending the request.
  ///
  /// Since the request maybe be resent the headers need to be stored for
  /// subsequent calls.
  final Map<String, String> headers = new Map<String, String>();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a [RequestHtml] for the given [url] using the specified [method] and [responseType].
  Request(this.url, this.method, this.responseType);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Sends the request with the given [data] payload.
  Future<dynamic> send([dynamic data]);
}
