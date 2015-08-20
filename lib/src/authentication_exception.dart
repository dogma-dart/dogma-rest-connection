// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [AuthenticationException] class.
library dogma.rest_connection.src.authentication_exception;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request_exception.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An [AuthenticationException] occurs when the [Client] is not authorized to access a RESTful API.
///
/// When interacting with a RESTful API this exception will be transmitted
/// whenever the HTTP code received indicates a failure due to authentication.
/// The application should attempt to recover from this error if possible
/// otherwise the connection to the RESTful API will be terminated.
///
/// An [AuthenticationException] will occur when a 401, or 403 status code is
/// received from a [Request].
class AuthenticationException extends RequestException {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [AuthenticationException] class.
  ///
  /// The status [code] of the request for the given [url] can be queried for
  /// more information on why the failure occured.
  const AuthenticationException(int code, String url)
      : super(code, url);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the exception can be recovered from.
  ///
  /// The HTTP specification indicates that a 401 status code can be recovered
  /// from. The client can repeat the request, assuming that the credentials
  /// were not already rejected.
  ///
  /// The other status code that indicates an authentication error, 403, should
  /// not be repeated.
  ///
  /// See [http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html] for more
  /// details on the behavior of 4xx status codes.
  bool get canRetry => code == 401;
}
