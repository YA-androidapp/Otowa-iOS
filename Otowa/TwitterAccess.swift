//
//  TwitterAccess.swift
//  Otowa
//
//  Created by Yu on 2022/05/14.
//

import Foundation
import TwitterAPIKit

class TwitterAccess: NSObject, ObservableObject {
    @Published var client: TwitterAPIKit?
    
    override init() {
        super.init()
        
        checkCredentials()
    }
    
    func checkCredentials() {
        if(
            UserDefaults.standard.string(forKey: "ck_preference") != "" &&
            UserDefaults.standard.string(forKey: "cs_preference") != "" &&
            UserDefaults.standard.string(forKey: "ot_preference") != "" &&
            UserDefaults.standard.string(forKey: "os_preference") != ""
        ) {
            client = TwitterAPIKit(
                .oauth(
                    consumerKey: UserDefaults.standard.string(forKey: "ck_preference") ?? "",
                    consumerSecret: UserDefaults.standard.string(forKey: "cs_preference") ?? "",
                    oauthToken: UserDefaults.standard.string(forKey: "ot_preference") ?? "",
                    oauthTokenSecret: UserDefaults.standard.string(forKey: "os_preference") ?? ""
                )
            )
            
            client?.v1.getAccountSetting(.init())
                .responseObject() {
                    response in
                    UserDefaults.standard.set(!response.isError, forKey: "authorized")
                    
                    print(UserDefaults.standard.bool(forKey: "authorized"))
                }
        }
    }
}

