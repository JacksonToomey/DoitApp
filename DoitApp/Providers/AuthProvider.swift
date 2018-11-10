//
//  AuthProvider.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/30/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit


final class AuthProvider {
    //MARK: Types
    struct LoginData {
        var email: String
        var password: String
    }
    
    static func hasUser() -> Bool {
        if getUser() == nil {
            return false
        }
        
        return true
    }
    
    static func getUser() -> LoginData? {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: "api.doit.jtoid.com",
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound {
            return nil
        }
        guard let existing = item as? [String: Any],
            let passwordData = existing[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existing[kSecAttrAccount as String] as? String
            else {
                return nil
        }
        return LoginData(email: account, password: password)
    }
    
    private static func getNetlifyRequest(_ loginData: LoginData) -> URLRequest {
        let url = URL(string: "https://app.doit.jtoid.com/.netlify/identity/token")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = "grant_type=password&username=\(loginData.email)&password=\(loginData.password)".data(using: .utf8)
        return request
    }
    
    private static func getApiLoginRequest(_ token: String) -> URLRequest {
        let url = URL(string: "https://api.doit.jtoid.com/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let jsonData = ["token": token]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        } catch {
            
        }
        return request
    }
    
    static func loginUser(_ loginData: LoginData, completion: @escaping (_ userToken: String) -> Void) {
        let request = getNetlifyRequest(loginData)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                    let identToken = json["access_token"] as? String
                    if identToken == nil {
                        return
                    }
                    let loginRequest = getApiLoginRequest(identToken!)
                    let apiTask = URLSession.shared.dataTask(with: loginRequest) { data, response, error in
                        do {
                            if let apiJson = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                                let apiToken = apiJson["token"] as? String
                                
                                CurrentUser.shared.token = apiToken!
                                storeUserLogin(loginData)
                                DispatchQueue.main.async {
                                    completion(apiToken!)
                                }
                            }
                        } catch {
                            
                        }
                    }
                    apiTask.resume()
                }
            } catch {
                //
            }
        }
        task.resume()
    }
    
    static func storeUserLogin(_ loginData: LoginData) {
        if hasUser() {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: loginData.email,
            kSecAttrServer as String: "api.doit.jtoid.com",
            kSecValueData as String: loginData.password.data(using: .utf8)
        ]
       SecItemAdd(query as CFDictionary, nil)
    }
}
