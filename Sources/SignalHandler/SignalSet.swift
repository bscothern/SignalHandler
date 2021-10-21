//
//  SignalSet.swift
//  SignalHandler
//
//  Created by Braden Scothern on 9/22/21.
//  Copyright © 2021 Braden Scothern. All rights reserved.
//

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

public struct SignalSet {
    @usableFromInline
    var sigset: sigset_t
}

extension SignalSet {
    @inlinable
    public init(_ sigset: sigset_t) {
        self.sigset = sigset
    }

    @inlinable
    public init(signals: Signal...) {
        self.init(signals: signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public init<S>(signals: S) where S: Sequence, S.Element == Signal {
        var sigset = sigset_t()
        for signal in signals {
            sigset |= UInt32(bitPattern: signal.rawValue)
        }
        self.init(sigset)
    }
}

extension SignalSet: Collection {
    public struct Index: Comparable {
        @usableFromInline
        var offset: Int

        @usableFromInline
        init(_ offset: Int) {
            self.offset = offset
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.offset < rhs.offset
        }
    }

    @inlinable
    public var startIndex: Index {
        .init(sigset.trailingZeroBitCount)
    }

    @inlinable
    public var endIndex: Index {
        let leadingZeroBitCount = sigset.leadingZeroBitCount
        if leadingZeroBitCount == sigset.bitWidth {
            return startIndex
        } else {
            return .init(sigset.bitWidth - leadingZeroBitCount + 1)
        }
    }

    public func index(after i: Index) -> Index {
        let offsetToNext = (sigset >> (i.offset)).trailingZeroBitCount + 1
        return .init(offsetToNext)
    }

    public subscript(position: Index) -> Signal {
        let value: CInt = 1 << position.offset
        return Signal(rawValue: value)!
    }
}
