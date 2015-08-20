// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RestCredentials] class.
library dogma.rest_connection.src.rest_credentials;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_connection/connection.dart';

import 'request.dart';

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

export 'request.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a way to set [Credentials] for a REST api.
///
/// By default the [RestCredentials] do not contain any authentication. An
/// instance of [RestCredentials] should be used directly if the API is open
/// to annonymous connections.
///
/// If authentication is required for the REST API then this class should be
/// inherited from and its methods overriden.
class RestCredentials implements Credentials {
  /// Attempts to authenticate with the given credentials.
  ///
  /// The [Client] will invoke this method when the open method is called. This
  /// allows the [Client] to send any access credentials before requests are
  /// made on the API.
  ///
  /// This should be overriden by subclasses that require communication with
  /// the server before a connection will be accessible.
  Future authenticate() {
    return new Future.value();
  }

  /// Allows the credentials to modify the [request] before its sent.
  ///
  /// The [Client] will invoke this method before invoking the send method on
  /// the request. This allows an implementation to append any additional data
  /// to the request before its sent, such as modifying the headers.
  ///
  /// This should be overriden by subclasses that wish to add additional headers
  /// to the request before sending.
  void onRequest(Request request) {
    // Do nothing
  }

  /// Allows the credentials to respond to an authentication error.
  ///
  /// When the [Client] receives a status code indicating that the
  /// authentication credentials are not valid this method is called.
  /// This allows the instance to respond to authentication errors with the
  /// server.
  ///
  /// This should be overriden by subclasses where it is possible to recover
  /// automatically from an authentication error. As an example if OAuth is
  /// being used and the token expires then this method should be overriden
  /// and the reacquisition of the token handled within.
  Future onAuthenticationError() {
    // By default there's no way to recover so error
    return new Future.error(new Error());
  }
}
