//
//  GlobalFunctions.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 18/3/23.
//

import Foundation

func fileNameFrom(fileUrl: String) -> String {
    let name = (fileUrl.components(separatedBy: "_").last?.components(separatedBy: "?").first!)?.components(separatedBy: ".").first!
    
    return name!
}
