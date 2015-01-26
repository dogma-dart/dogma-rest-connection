// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ResponseType] enumeration.
library dogma.rest_connection.src.response_type;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Enumeration for the requested response type.
///
/// When making a [HttpRequest] the expected type for the response can be
/// specified. The [Request] will then respond back with the type corresponding
/// to the enumeration.
enum ResponseType {
  /// Request that the data is a [String].
  Text,
  /// Request that the data is an [ByteBuffer].
  ByteBuffer,
  /// Request that the data is a [Map].
  Json
}
