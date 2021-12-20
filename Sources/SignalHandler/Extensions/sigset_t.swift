//
//  sigset_t.swift
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

extension sigset_t {
    /// Create an empty `sigset_t` that has been properly initialized.
    @usableFromInline
    @inline(__always)
    static func emptySet() -> Self {
        var sigset = Self()
        sigemptyset(&sigset)
        return sigset
    }
}
