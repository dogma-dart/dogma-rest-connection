// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Initializes the [createRequest] function to construct instances of [RequestHtml].
library dogma.rest_connection.src.request_factory_html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request_factory.dart';
import 'request_html.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'request_factory.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Factory constructor for [RequestHtml].
Request _createRequest(String url, RequestMethod method, ResponseType responseType)
    => new RequestHtml(url, method: method, responseType: responseType);

/// Initializes the [createRequest] function to construct instances of [RequestHtml].
///
/// Returns a boolean indicating whether the setting was successful. The only
/// reason why the initialization will fail is if the value of createRequest
/// was already set and differs from the factory function within the library.
///
/// This function should only be called once but successive calls will not
/// result in an unsuccessful response.
bool initializeRequests() {
  if (createRequest == null) {
    createRequest = _createRequest;

    return true;
  } else {
    return createRequest == _createRequest;
  }
}
