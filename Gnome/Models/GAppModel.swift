//
//  GAppModel.swift
//  Gnome
//
//  Created by Joe Barbour on 4/19/24.
//

import Foundation
import Cocoa
import SwiftUI

public enum AppSoundEffects:String {
    case reveal = "reveal"
    case complete = "complete"
    case added = "added"

    public func play(_ force:Bool = false) {
        if SettingsManager.shared.enabledSoundEffects == true || force == true {
            NSSound(named: self.rawValue)?.play()

        }
                
    }
        
}

enum AppDefaultsKeys: String {
    case userEmail = "g_user_email"
    case userInstalled = "g_user_installed"
        
    case enabledAnalytics = "g_settings_analytics"
    case enabledLogin = "g_settings_login"
    case enabledSoundEffects = "g_settings_sfx"
    case enabledArchive = "g_settings_archive"
    case enabledPinned = "g_settings_pinned"
    case enabledDockIcon = "g_settings_dock"
    
    case sectionSnoozed = "g_section_snoozed"
    case sectionHidden = "g_section_hidden"

    case windowPosition = "g_settings_position"
    case windowTheme = "g_settings_theme"

    case onboardingStep = "g_onboarding_step"
    case onboardingComplete = "g_onboarding_updated"

    case licensePayload = "g_license_payload"
    case licenseKey = "g_license_key"

    var purgable:Bool {
        switch self {
            case .userInstalled : return false
            case .userEmail : return false
            default : return true

        }
        
    }
    
}

enum AppDropdownType:Int {
    case taskHide
    case taskShow
    case taskActive
    case taskInactive
    case openRoot
    case openInline
    case snoozeTomorrow
    case snoozeWeek
    case snoozeRemove
    case divider
    
    func label(_ task:TaskObject?) -> String {
        switch self {
            case .taskHide : return "Hide"
            case .taskActive : return "Move to 'In Progress'"
            case .taskInactive : return "Remove from 'In Progress'"
            case .taskShow : return "Undo Hide"
            case .openRoot : return "Open \(task?.project.name ?? "") Folder"
            case .openInline : return "Open at Line #\(task?.line ?? 0)"
            case .snoozeTomorrow : return "Snooze Until \(Date.now.snooze.formatted)"
            case .snoozeWeek : return "Snooze For 1 Week"
            case .snoozeRemove : return "Add to Todo"
            case .divider : return ""

        }
        
    }
    
}

enum AppDropdownActionType {
    case left
    case right
    case optional
    
}

enum AppTimestampCompare {
    case past
    case future
    
}

struct AppSnoozeObject {
    var countdown:Int
    var weekday:Int
    var formatted:String
    
    init(_ countdown: Int, weekday: Int) {
        self.countdown = countdown
        self.weekday = weekday
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        guard let date = Calendar.current.date(byAdding: .day, value: countdown, to: Date.now) else {
            self.formatted = ""
            return
            
        }

        switch countdown {
            case 0 : self.formatted = "Today"
            case 1 : self.formatted = "Tomorrow"
            default : self.formatted =  formatter.string(from: date)
            
        }
      
    }
    
}

enum AppLinks {
    case stripe
    case github
    
    func launch() {
        var url:URL?
        switch self {
            case .stripe : url = URL(string: "https://buy.stripe.com/bIYg2R6HF9TM6WY6oD")
            case .github : url = URL(string: "https://github.com/thebarbican19/CodeGnoma-MacOS")
            
        }
        
        guard let url = url else {
            return
            
        }
        
        NSWorkspace.shared.open(url)
        
    }
    
}

enum AppMaskPosition {
    case top
    case bottom
    
}

enum AppShortcutKeys:String {
    case command = "⌘"
    case option = "⌥"
    case leftBracket = "["
    case rightBracket = "]"
    
    var system:Bool {
        switch self {
            case .command : return true
            case .option : return true
            default : return false
            
        }
        
    }
    
    var name:String? {
        switch self {
            case .command : return "command"
            case .option : return "option"
            default : return nil
            
        }
        
    }

}

enum AppButtonType {
    case standard
    case processing
    case disabled
    
}

struct AppButtonObject {
    var type:AppButtonType
    var value:LocalizedStringKey
    var icon:String?

    init(_ type: AppButtonType, value: LocalizedStringKey, icon:String? = nil) {
        self.type = type
        self.value = value
        self.icon = icon
        
    }
    
}
