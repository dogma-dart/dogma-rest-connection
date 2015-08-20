// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains functions for determining the meaning of a HTTP status code.
library dogma.rest_connection.src.status_codes;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Determines if a HTTP request was successful.
///
/// Requests in the 2xx range indicate a successful request.
bool requestSuccessful(int code)
    => (code >= 200) && (code < 300);

/// Determines if a HTTP request failed due to the client.
///
/// Requests in the 4xx range indicate a client error.
bool clientError(int code)
    => (code >= 400) && (code < 500);

/// Determines if a HTTP request failed due to authentication.
bool authenticationError(int code)
    => (code == 401) || (code == 403);

/// Determines if a HTTP request failed due to the server.
///
/// Requests in the 5xx range indicate a server error.
bool serverError(int code)
    => (code >= 500) && (code < 600);
