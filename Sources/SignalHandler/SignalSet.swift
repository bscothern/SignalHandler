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

/// A nicer version of `sigset_t` which is used to work with multiple ``Signal``s at the same time.
public struct SignalSet: Hashable {
    @usableFromInline
    var sigset: sigset_t
}

extension SignalSet {
    @usableFromInline
    init() {
        sigset = .emptySet()
    }

    /// Create a `SignalSet` from a `sigset_t`.
    ///
    /// - Parameter sigset: The `sigset_t` that matches the desired `SignalSet`.
    @inlinable
    public init(_ sigset: __owned sigset_t) {
        // This uses __owned so that the compiler more strictly moves values into the SignalSet being constructed.
        // This is important to reduce the chance of non-stack allocations during signal handler execution.
        self.sigset = sigset
    }

    /// Create a `SignalSet` from input `Signal`s.
    ///
    /// - Parameter signals: The `Signal`s to put in the `SignalSet`.
    @inlinable
    public init(signals: Signal...) {
        self.init(signals: signals)
    }

    /// Create a `SignalSet` from `Signal`s.
    ///
    /// - Parameter signals: The `Signal`s to put in the `SignalSet`.
    @inlinable
    @_specialize(where S == [Signal])
    public init<S>(signals: S) where S: Sequence, S.Element == Signal {
        var sigset = sigset_t.emptySet()
        for signal in signals {
            sigaddset(&sigset, signal.rawValue)
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
        let value = Signal(rawValue: .init(maskedValue.trailingZeroBitCount + 1))!
        assert(
            withUnsafePointer(to: sigset) { sigset in
                sigismember(sigset, value.rawValue) == 1
            },
            "sigset_t offset values don't match signal values on this platform."
        )
        return value
    }
}
