//
//  SwiftUtility.swift
//  GreatSports
//
//  Created by Russel Dev on 28/07/23.
//

import Foundation

struct SwiftUtility {
    static func loadJson(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let dataObj = try Data(contentsOf: url)
                return dataObj
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
}
