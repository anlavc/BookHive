//
//  UserNickName + Singleton.swift
//  BookHive
//
//  Created by Anıl AVCI on 7.05.2023.
//

import Foundation
class UserNickName {
    static let shared = UserNickName()
    var userName: String = ""
    private init() {}
}
