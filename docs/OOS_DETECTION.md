# Out-of-stock (OOS) detection

When fulfillment fails (e.g. `placeOrder` throws), the app may set the order to `failedOutOfStock` and cancel on the marketplace. Whether we treat an error as OOS is decided by `FulfillmentService.isLikelyOutOfStock`.

## Source-specific (confident)

| Source   | How we detect OOS | Codes / notes |
|----------|-------------------|----------------|
| **CJ Dropshipping** | `ApiError` with `statusCode` in known list; or CJ response body `code` (int) in same list | 1602002 (product removed from shelves), 1602003 (variant removed from shelves), 1603102 (inventory deduction fail). See [CJ Global Error Codes](https://developers.cjdropshipping.com/en/api/api2/standard/ps-code.html). |

Other sources (e.g. API2Cart) do not expose OOS-specific codes here; they rely on heuristics below.

## Heuristics (may false-positive or false-negative)

- **Message text:** We treat errors as OOS if the message (or `ApiError.detail`, or response body `message`/`msg`/`error`) contains phrases like: `out of stock`, `insufficient stock`, `product unavailable`, `sold out`, or `inventory` + `0`, etc. See `_messageIndicatesOOS` in `lib/services/fulfillment_service.dart`.
- **Response body code:** For non-`ApiError` (e.g. raw Dio response), we also check body `code`/`errorCode` for substrings `stock` or `inventory`, or run the message heuristic on the body message.

## Strict mode

`isLikelyOutOfStock(error, stackTrace, strictMode: true)` returns `true` only for **known source-specific codes** (currently CJ codes above). Message heuristics are ignored in strict mode. Use strict mode when you want to avoid cancelling on the marketplace for errors that might not be OOS (e.g. generic "order create fail" or network issues). Default is `strictMode: false` so current behaviour is unchanged.

## Extending

To add another source (e.g. API2Cart): if that source returns a structured error with an OOS code, add a constant set of codes and check it in `isLikelyOutOfStock` (e.g. when `error` is a custom error type or when response body identifies the source). Document the source and codes in this file.
