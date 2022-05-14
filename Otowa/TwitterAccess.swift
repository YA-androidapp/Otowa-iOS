//
//  TwitterAccess.swift
//  Otowa
//
//  Created by Yu on 2022/05/14.
//

import Foundation
import TwitterAPIKit

func getClient() -> TwitterAPIKit? {
    var client :TwitterAPIKit? = nil
    
    if(
        UserDefaults.standard.string(forKey: "ck_preference") != "" &&
        UserDefaults.standard.string(forKey: "cs_preference") != "" &&
        UserDefaults.standard.string(forKey: "ot_preference") != "" &&
        UserDefaults.standard.string(forKey: "os_preference") != ""
    ) {
        do {
            client = try TwitterAPIKit(
                .oauth(
                    consumerKey: UserDefaults.standard.string(forKey: "ck_preference") ?? "",
                    consumerSecret: UserDefaults.standard.string(forKey: "cs_preference") ?? "",
                    oauthToken: UserDefaults.standard.string(forKey: "ot_preference") ?? "",
                    oauthTokenSecret: UserDefaults.standard.string(forKey: "os_preference") ?? ""
                )
            )
            return client
        } catch {
            return nil
        }
    } else {
        return nil
    }
}
