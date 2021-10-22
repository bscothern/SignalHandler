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

public struct SignalSet: Hashable {
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
            sigset |= .init(1 << (signal.rawValue - 1))
        }
        self.init(sigset)
    }
}

extension SignalSet: ExpressibleByArrayLiteral {
    @inlinable
    public init(arrayLiteral elements: Signal...) {
        self.init(signals: elements)
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

        @inlinable
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
            return .init(sigset.bitWidth - leadingZeroBitCount)
        }
    }

    public func index(after i: Index) -> Index {
        let shiftOutPreviousValues = sigset >> (i.offset + 1)
        guard shiftOutPreviousValues != 0 else {
            return endIndex
        }
        let offsetToNext = shiftOutPreviousValues.trailingZeroBitCount + 1
        return .init(offsetToNext + i.offset)
    }

    public subscript(position: Index) -> Signal {
        let maskedValue = sigset & (1 << position.offset)
        precondition(maskedValue != 0, "Invalid index used with SignalSet. It points to a value not in this instance.")
        return Signal(rawValue: .init(maskedValue.trailingZeroBitCount + 1))!
    }
}
