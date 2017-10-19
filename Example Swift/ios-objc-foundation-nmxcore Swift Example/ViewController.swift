//
//  ViewController.swift
//  ios-objc-foundation-nmxcore Swift Example
//
//  Created by Tobias Baube on 16.10.17.
//  Copyright © 2017 Tobias Baube. All rights reserved.
//

import UIKit

// Import NMXCore, after you have created a bridging header: see ios-objc-foundation-nmxcore_Swift_Example-Bridging-Header.h
import NMXCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Now you can use common library functions
        print(NSNumber(value: 123).isPositive)
        
        // Logging - as VaLists are pretty uncool in swift :-(
        // https://stackoverflow.com/a/28641066/464016
        var _ = withVaList(["abc", "def"]) { (pointer: CVaListPointer) in
            return NMXLogWithPrefixAndArguments(.none, nil, "HALLO %@ %@", pointer)
        }
        
        // We got a wrapping Swift Header for this purpose 👍 - see NMXCore.swift
        NMXLog("abcdef %@ %@", args: "Hallo", NSNumber(value: 1))
    }
}

