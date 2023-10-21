// Make sure we have
// FirebaseAnalytics
// FirebaseAnalyticsSwift
// FirebaseAuth

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }

    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // TODO: neeed to implement properly
    func deleteUser() {
        let currentUser = Auth.auth().currentUser
        currentUser?.delete{ error in
            if let _ = error {
                print("deleteUser(): Error Deleting Account")
            } else {
                print("deleteUser(): Account Successfully Deleted")
            }
        }
    }
    
    // TODO: neeed to implement properly
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let _ = error {
                print("resetPassword(): Error Reseting Password")
            } else {
                print("resetPassword(): Password Reset")
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
                    print("setUsername(): Error clearing display name: \(error.localizedDescription)")
                } else {
                    // Display name cleared successfully
                    print("setUsername(): Display name cleared.")
                }
            }
        }

    }

}
