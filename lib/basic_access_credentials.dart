// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [BasicAccessCredentials] class.
library dogma.rest_connection.basic_access_credentials;

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:crypto/crypto.dart';
import 'package:dogma_rest_connection/src/rest_credentials.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Credentials for the HTTP Basic Access authentication scheme.
///
/// Basic authentication is the simplest form of authentication and does not
/// require any handshake from the server. The [BasicAccessCredentials] just
/// modify the header of the request to include the access credentials.
///
/// The Authorization header is constructed by doing the following.
/// 1. Combine username and password "username:password".
/// 2. Base64 encode the previous step.
///
/// If there is an error with the credentials there is no way to recover.
class BasicAccessCredentials extends RestCredentials {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The credentials for the resource.
  final String token;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [BasicAccessCredentials] with the given [username] and [password].
  ///
  /// The [username] and [password] are not stored internally and cannot be
  /// accessed by the application.
  factory BasicAccessCredentials(String username, String password) {
    var bytes = UTF8.encode('$username:$password');
    var base64 = CryptoUtils.bytesToBase64(bytes);

    return new BasicAccessCredentials._internal(base64);
  }

  /// Creates an instance of OAuthTokenCredentials with the given [token].
  BasicAccessCredentials._internal(this.token);

  //---------------------------------------------------------------------
  // RestCredentials
  //---------------------------------------------------------------------

  @override
  void onRequest(Request request) {
    // Add the header
    request.headers['Authorization'] = 'Basic $token';
  }
}
