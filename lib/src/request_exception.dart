// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RequestException] class.
library dogma.rest_connection.src.request_exception;

class RequestException implements Exception {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The status code received from the exception.
  final int code;
  /// The url being requested.
  final String url;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [RequestException] class.
  ///
  /// The status [code] of the request for the given [url] can be queried for
  /// more information on why the failure occured.
  const RequestException(this.code, this.url);

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  String toString() => '[$code] $url';
}
