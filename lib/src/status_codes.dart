// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains functions for determining the meaning of a HTTP status code.
library dogma.rest_connection.src.status_codes;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Determines if a http request was successful.
///
/// Requests in the 2xx range indicate a successful request.
bool requestSuccessful(int code)
    => (code >= 200) && (code < 300);
