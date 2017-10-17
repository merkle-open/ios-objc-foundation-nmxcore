//
//  NMXCore.swift
//  NMXCore
//
//  Created by Tobias Baube on 17.10.17.
//

import NMXCore

func NMXLog(_ format: String, args: Any...) {
    if let _args = args as? [CVarArg] {
        withVaList(_args) { (pointer: CVaListPointer) in
            NMXLogWithPrefixAndArguments(.none, nil, format, pointer)
        }
    }
}

func NMXLog(_ logLevel:NMXLogLevelType, _ format: String, args: Any...) {
    if let _args = args as? [CVarArg] {
        withVaList(_args) { (pointer: CVaListPointer) in
            NMXLogWithPrefixAndArguments(logLevel, nil, format, pointer)
            }
    }
}

func NMXLog(_ logLevel:NMXLogLevelType, _ logPrefix: String?, _ format: String, args: Any...) {
    if let _args = args as? [CVarArg] {
        withVaList(_args) { (pointer: CVaListPointer) in
            NMXLogWithPrefixAndArguments(logLevel, logPrefix, format, pointer)
            }
    }
}
