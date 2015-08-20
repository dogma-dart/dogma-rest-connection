// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RequestMethod] enumeration.
library dogma.rest_connection.src.request_method;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Enumeration for the HTTP methods used by a RESTful service.
///
/// The documentation for the different enumeration assumes the most common
/// usage of the method. There is no guarantee that an implementor will follow
/// the methods exactly. As an example Twitter's API only uses [Get] and [Post]
/// so updates and deletions use the [Post] method.
enum RequestMethod {
  /// Retrieves a representation of a resource.
  ///
  /// Used to read data and not change it.
  Get,
  /// Creates a new resource.
  Post,
  /// Used to update the state of a resource.
  Put,
  /// Deletes a resource.
  Delete
}

/// Transforms a [RequestMethod] into the HTTP verb used in the request headers.
String requestMethodToString(RequestMethod method) {
  switch (method) {
    case RequestMethod.Get: return 'GET';
    case RequestMethod.Post: return 'POST';
    case RequestMethod.Put: return 'PUT';
    default: return 'DELETE';
  }
}
