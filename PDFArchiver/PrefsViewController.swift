//
//  PrefsViewController.swift
//  PDF Archiver
//
//  Created by Julian Kahnert on 21.01.18.
//  Copyright © 2018 Julian Kahnert. All rights reserved.
//

import Cocoa

protocol PrefsViewControllerDelegate: class {
    func savePreferences(prefs: Preferences)
    
}

class PrefsViewController: NSViewController {
    var prefs: Preferences?
    weak var delegate: PrefsViewControllerDelegate?

    @IBOutlet weak var archivePathTextField: NSTextField!
    @IBAction func changeArchivePathButton(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.title = "Choose an archive folder"
        openPanel.showsResizeIndicator = false
        openPanel.showsHiddenFiles = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.beginSheetModal(for: NSApplication.shared.mainWindow!) { response in
            guard response == NSApplication.ModalResponse.OK else {
                return
            }
            self.prefs?.archivePath = openPanel.url!
            self.archivePathTextField.stringValue = openPanel.url!.path
        }
    }
    
    @IBAction func okButton(_ sender: Any) {
        view.window?.close()
        self.prefs!.save()
//        delegate?.savePreferences(prefs: self.prefs!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prefs = Preferences()
        self.prefs!.load()
        
        // update path field
        if let archivePath = self.prefs?.archivePath {
            self.archivePathTextField.stringValue = archivePath.path
        }
        
    }
    

    
}
