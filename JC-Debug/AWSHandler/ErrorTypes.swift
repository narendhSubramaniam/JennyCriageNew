
import Foundation

enum JCDebugError: Error {
  case appSyncClientNotInitialized
  case invalidPostcode
  case noRecordReturnedFromAPI
  case unexpectedGraphQLData
  case unexpctedAuthResponse
  case notImplemented
}
