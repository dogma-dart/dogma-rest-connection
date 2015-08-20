// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [OAuthTokenCredentials] class.
library dogma.rest_connection.oauth_token_credentials;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_rest_connection/src/rest_credentials.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Credentials for an OAuth token that has already been obtained.
///
/// The [OAuthTokenCredentials] does not attempt to make a connection to an
/// OAuth server. Instead it just uses the token that was already obtained from
/// the negotiations between the OAuth server. This is useful for scenarios
/// where the OAuth token does not expire and can be stored securely. If at
/// any point the token becomes invalid then all further requests will fail
/// and the connection will not be able to be re-established.
class OAuthTokenCredentials extends RestCredentials {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The OAuth token to use.
  ///
  /// This value is added to the header of the request. The header will look as
  /// follows where <token> is replaced by the value.
  ///
  ///     Authorization: Bearer <token>
  final String token;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of OAuthTokenCredentials with the given [token].
  OAuthTokenCredentials(this.token);

  //---------------------------------------------------------------------
  // RestCredentials
  //---------------------------------------------------------------------

  @override
  void onRequest(Request request) {
    // Add the header
    request.headers['Authorization'] = 'Bearer $token';
  }
}
