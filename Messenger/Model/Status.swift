//
//  Status.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 19/3/23.
//

import Foundation

enum Status: String {
    case Available = "Available"
    case Busy = "Busy"
    case AtSchool = "At School"
    case AtTheMovies = "At The Movies"
    case BatteryAboutToDie = "Battery About to Die "
    case CantTalk = "Can't Talk"
    case InAMeeting = "In A Meeting"
    case AtTheGym = "At the Gym"
    case Sleeping = "Sleeping"
    case UrgentCallsOnly = "Urgent Calls Only"
    
    static var array: [Status] {
        var a: [Status] = []
        
        switch Status.Available {
        case .Available:
            a.append(.Available); fallthrough
        case .Busy:
            a.append(.Busy); fallthrough
        case .AtSchool:
            a.append(.AtSchool); fallthrough
        case .AtTheMovies:
            a.append(.AtTheMovies); fallthrough
        case .BatteryAboutToDie:
            a.append(.BatteryAboutToDie); fallthrough
        case .CantTalk:
            a.append(.CantTalk); fallthrough
        case .InAMeeting:
            a.append(.InAMeeting); fallthrough
        case .AtTheGym:
            a.append(.AtTheGym); fallthrough
        case .Sleeping:
            a.append(.Sleeping); fallthrough
        case .UrgentCallsOnly:
            a.append(.UrgentCallsOnly)
        
        return a
        }
    }
}
