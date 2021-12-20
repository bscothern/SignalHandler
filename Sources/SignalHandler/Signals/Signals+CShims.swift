//
//  Signals+CShims.swift
//  SignalHandler
//
//  Created by Braden Scothern on 12/19/21.
//  Copyright © 2021 Braden Scothern. All rights reserved.
//

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

@usableFromInline
let __raise = raise

extension Signals {
    /// A binding to C land `signal(3)` so that it can be used while naming parameters `signal` where appropriate.
    ///
    /// Without this helper extra shims are needed in order to make public interfaces nice elsewhere.
    @_transparent
    @usableFromInline
    @inline(__always)
    @discardableResult
    static func _signal(_ sig: Int32, _ f: (@convention(c) (Int32) -> Void)?) -> (@convention(c) (Int32) -> Void)? {
        signal(sig, f)
    }
}
