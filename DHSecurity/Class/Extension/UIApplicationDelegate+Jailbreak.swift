//
//  UIAppDelegate+Jailbreak.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/8/31.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

extension UIApplicationDelegate {
    public func isJailbreak() -> Bool {
        guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return false }
        if UIApplication.shared.canOpenURL(cydiaUrlScheme as URL) {
            return true
        }
        
        let paths: [String] = ["/Applications/Cydia.app",
                               "/Applications/FakeCarrier.app",
                               "/Applications/Icy.app",
                               "/Applications/IntelliScreen.app",
                               "/Applications/MxTube.app",
                               "/Applications/RockApp.app",
                               "/Applications/SBSettings.app",
                               "/Applications/WinterBoard.app",
                               "/Applications/blackra1n.app",
                               "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                               "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                               "/Library/MobileSubstrate/MobileSubstrate.dylib",
                               "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                               "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                               "/bin/bash",
                               "/bin/sh",
                               "/etc/apt",
                               "/etc/ssh/sshd_config",
                               "/private/var/lib/apt",
                               "/private/var/lib/cydia",
                               "/private/var/mobile/Library/SBSettings/Themes",
                               "/private/var/stash",
                               "/private/var/tmp/cydia.log",
                               "/usr/bin/sshd",
                               "/usr/libexec/sftp-server",
                               "/usr/libexec/ssh-keysign",
                               "/usr/sbin/sshd",
                               "/var/cache/apt",
                               "/var/lib/apt",
                               "/var/lib/cydia",
                               "/usr/sbin/frida-server",
                               "/usr/bin/cycript",
                               "/usr/local/bin/cycript",
                               "/usr/lib/libcycript.dylib"]
        
        let fileManager = FileManager.default
        for path in paths {
            if fileManager.fileExists(atPath: path) {
                debugPrint("\(path) file exists")
                return true
            }
            
            if self.canOpen(path: path) {
                debugPrint("\(path) can open")
                return true
            }
        }
        
        let path = "/private/" + NSUUID().uuidString
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {}
        
        return false
    }
    
    private func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }
}
