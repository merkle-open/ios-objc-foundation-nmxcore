//
//  NMXCore.swift
//  NMXCore
//
//  Created by Tobias Baube on 17.10.17.
//

func NMXLog(_ format: String, args: Any...) -> String? {
    if let _args = args as? [CVarArg] {
        return withVaList(_args) { (pointer: CVaListPointer) -> String? in
            return NMXLogWithPrefixAndArguments(.none, nil, format, pointer)
            }!
    }
    return nil
}

func NMXLog(_ logLevel:NMXLogLevelType, _ format: String, args: Any...) -> String? {
    if let _args = args as? [CVarArg] {
        return withVaList(_args) { (pointer: CVaListPointer) -> String? in
            return NMXLogWithPrefixAndArguments(logLevel, nil, format, pointer)
            }!
    }
    return nil
}

func NMXLog(_ logLevel:NMXLogLevelType, _ logPrefix: String?, _ format: String, args: Any...) -> String? {
    if let _args = args as? [CVarArg] {
        return withVaList(_args) { (pointer: CVaListPointer) -> String? in
            return NMXLogWithPrefixAndArguments(logLevel, logPrefix, format, pointer)
            }!
    }
    return nil
}
