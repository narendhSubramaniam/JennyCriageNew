
import UIKit
import Combine
import Amplify

enum AuthenticationState {
  case startingSignUp
  case startingSignIn
  case awaitingConfirmation(String, String)
  case signedIn
  case errored(Error)
}

public final class AuthenticationService {
  let userSession: UserSession
  var logger = Logger()
  var cancellable: AnyCancellable?

  init(userSession: UserSession) {
    self.userSession = userSession
  }

  // MARK: Public API

  func signIn(as username: String, identifiedBy password: String) -> Future<AuthenticationState, Error> {
    return Future { promise in
      // 1
      _ = Amplify.Auth.signIn(username: username, password: password) { [self] result in
        switch result {
        // 2
        case .failure(let error):
          logger.logError(error.localizedDescription)
          promise(.failure(error))
        // 3
        case .success:
          guard let authUser = Amplify.Auth.getCurrentUser() else {
            let authError = JCDebugError.unexpctedAuthResponse
            logger.logError(authError)
            signOut()
            promise(.failure(authError))
            return
          }
          // 4
          cancellable = fetchUserModel(id: authUser.userId)
            .sink(receiveCompletion: { completion in
              switch completion {
              case .failure(let error):
                signOut()
                promise(.failure(error))
              case .finished:
                break
              }
            }, receiveValue: { user in
              setUserSessionData(user)
              promise(.success(.signedIn))
            })
        }
      }
    }
  }

  func signUp(as username: String, identifiedBy password: String, with email: String) -> Future<AuthenticationState, Error> {
    return Future { promise in
      // 1
      let userAttributes = [AuthUserAttribute(.email, value: email)]
      let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
      // 2
      _ = Amplify.Auth.signUp(username: username, password: password, options: options) { [self] result in
        DispatchQueue.main.async {
          switch result {
          case .failure(let error):
            logger.logError(error.localizedDescription)
            promise(.failure(error))
          case .success(let amplifyResult):
            // 3
            if case .confirmUser = amplifyResult.nextStep {
              promise(.success(.awaitingConfirmation(username, password)))
            } else {
              let error = JCDebugError.unexpctedAuthResponse
              logger.logError(error.localizedDescription)
              promise(.failure(error))
            }
          }
        }
      }
    }
  }

  func confirmSignUp(for username: String, with password: String, confirmedBy confirmationCode: String) -> Future<AuthenticationState, Error> {
    return Future { promise in
      // 1
      _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { [self] result in
        switch result {
        case .failure(let error):
          logger.logError(error.localizedDescription)
          promise(.failure(error))
        case .success:
          // 2
          _ = Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .failure(let error):
              logger.logError(error.localizedDescription)
              promise(.failure(error))
            case .success:
              // 3
              // 1
              guard let authUser = Amplify.Auth.getCurrentUser() else {
                let authError = JCDebugError.unexpctedAuthResponse
                logger.logError(authError)
                promise(.failure(JCDebugError.unexpctedAuthResponse))
                signOut()
                return
              }
              // 2
              let sub = authUser.userId
              let user = User(
                id: sub,
                username: username,
                sub: sub,
                postcode: nil,
                createdAt: Temporal.DateTime.now()
              )
              // 3
//              _ = Amplify.API.mutate(request: .create(user)) { event in
//                switch event {
//                // 4
//                case .failure(let error):
//                  signOut()
//                  promise(.failure(error))
//                case .success(let result):
//                  switch result {
//                  case .failure(let error):
//                    signOut()
//                    promise(.failure(error))
//                  case .success(let user):
//                    // 5
//                    setUserSessionData(user)
//                    promise(.success(.signedIn))
//                  }
//                }
//              }
                
            }
          }
        }
      }
    }
  }

  func signOut() {
    setUserSessionData(nil)
    _ = Amplify.Auth.signOut { [self] result in
      switch result {
      case .failure(let error):
        logger.logError(error)
      default:
        break
      }
    }
  }

  func checkAuthSession() {
    // 1
    _ = Amplify.Auth.fetchAuthSession { [self] result in
      switch result {
      // 2
      case .failure(let error):
        logger.logError(error)
        signOut()

      // 3
      case .success(let session):
        if !session.isSignedIn {
          setUserSessionData(nil)
          return
        }

        // 4
        guard let authUser = Amplify.Auth.getCurrentUser() else {
          let authError = JCDebugError.unexpctedAuthResponse
          logger.logError(authError)
          signOut()
          return
        }
        let sub = authUser.userId
        cancellable = fetchUserModel(id: sub)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              logger.logError(error)
              signOut()
            case .finished: ()
            }
          }, receiveValue: { user in
            setUserSessionData(user)
          })
      }
    }
  }

  // MARK: Private

  private func setUserSessionData(_ user: User?) {
    DispatchQueue.main.async {
      if let user = user {
        self.userSession.loggedInUser = user
      } else {
        self.userSession.loggedInUser = nil
      }
    }
  }

  private func fetchUserModel(id: String) -> Future<User, Error> {
    // 1
    return Future { promise in
      // 2
//      _ = Amplify.API.query(request: .get(User.self, byId: id)) { [self] event in
//        // 3
//        switch event {
//        case .failure(let error):
//          logger.logError(error.localizedDescription)
//          promise(.failure(error))
//          return
//        case .success(let result):
//          // 4
//          switch result {
//          case .failure(let resultError):
//            logger.logError(resultError.localizedDescription)
//            promise(.failure(resultError))
//            return
//          case .success(let user):
//            // 5
//            guard let user = user else {
//              let error = IsolationNationError.unexpectedGraphQLData
//              logger.logError(error.localizedDescription)
//              promise(.failure(error))
//              return
//            }
//            promise(.success(user))
//          }
//        }
//      }
    }
  }
}
