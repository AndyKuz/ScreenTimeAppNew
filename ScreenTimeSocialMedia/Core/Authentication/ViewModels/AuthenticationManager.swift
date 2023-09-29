// Make sure we have
// FirebaseAnalytics
// FirebaseAnalyticsSwift
// FirebaseAuth

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?

    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}

    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func deleteUser() {
        let currentUser = Auth.auth().currentUser
        currentUser?.delete{ error in
            if let _ = error {
                print("Error Deleting Account")
            } else {
                print("Account Successfully Deleted")
            }
        }
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }

    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let _ = error {
                print("Error Reseting Password")
            } else {
                print("Password Reset")
            }
        }
    }
    
    func setUsername(username: String) {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username // set display name to username
            changeRequest.commitChanges { error in
                if let error = error {
                    // Handle the error
                    print("Error clearing display name: \(error.localizedDescription)")
                } else {
                    // Display name cleared successfully
                    print("Display name cleared.")
                }
            }
        }

    }

}
