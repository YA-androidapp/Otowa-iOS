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
    
    struct UserInfo: Decodable {
        let data: Data
        
        struct Data: Decodable {
            let id: String
            let username: String
            let name: String
            let profile_image_url: String
        }
    }
    
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
            
//            client?.v1.getAccountSetting(.init())
//                .responseObject() {
//                    response in
//                    UserDefaults.standard.set(!response.isError, forKey: "authorized")
//
//                    print(UserDefaults.standard.bool(forKey: "authorized"))
//                }
            
            var userInfo: UserInfo?
            client?.v2.user.getMe(.init(expansions: .none, tweetFields: .none, userFields: [.profileImageUrl])).responseObject { response in
                UserDefaults.standard.set(!response.isError, forKey: "authorized")
                
                if !response.isError {
                    do {
                        userInfo = try JSONDecoder().decode(UserInfo.self, from: response.data!)
                        print(userInfo!)
                    } catch {
                        print(error)
                        userInfo = nil
                    }
                } else {
                    print("Error", String(describing: response.error))
                    userInfo = nil
                }
            }
        }
    }
}

