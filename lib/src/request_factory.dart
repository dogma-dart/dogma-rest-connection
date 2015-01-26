// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Specifies the factory function to use when creating [Request]s.
library dogma.rest_connection.src.request_factory;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'request.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A factory function for creating a [Request].
typedef Request RequestFactory(String url, RequestMethod method, ResponseType responseType);

/// The factory function for creating a [Request].
///
/// To handle applications running on both the client [dart:html] and the
/// server [dart:io] the instantiation of [Request]s are delegated to this
/// function. It is expected that during the initialization of the application
/// this value will be set.
RequestFactory createRequest;
