//
//  KeychainFunctions.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/7/23.
//

import AuthenticationServices

func saveData(_ data: Data, service: String, account: String) {
    let query = [
        kSecValueData: data,
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary

    let status = SecItemAdd(query, nil)

    if status != errSecSuccess {
        print("Error: \(status)")
    }
}

func updateData(_ data: Data, service: String, account: String) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary

    let updatedData = [kSecValueData: data] as CFDictionary
    SecItemUpdate(query, updatedData)
}

func readData(service: String, account: String) -> Data? {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecReturnData: true
    ] as CFDictionary

    var result: AnyObject?
    SecItemCopyMattching(query, &result)
    return result as? Data
}

func deleteData(service: String, account: String) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary

    SecItemDelete(query)
}
// random comment