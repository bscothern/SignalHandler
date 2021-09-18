//
//  Signal.swift
//  SignalHandler
//
//  Created by Braden Scothern on 9/17/21.
//  Copyright © 2021 Braden Scothern. All rights reserved.
//

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Namespace of functions for working with signals.
public enum Signals {}

// MARK: - Typealiases
extension Signals {
#if canImport(Darwin)
    @usableFromInline
    static let _raise: (Int32) -> Int32 = Darwin.raise
#elseif canImport(Glibc)
    @usableFromInline
    static let _raise: (Int32) -> Int32 = Glibc.raise
#endif
}

// MARK: - Handle
extension Signals {
    public typealias SignalHandler = (Signal) -> Void

    @usableFromInline
    static var handlers: [Signal: SignalHandler] = [:]

    @usableFromInline
    static func handle(
        signal: Signal,
        flags: SignalHandlerFlag,
        mask: sigset_t,
        action: SignalHandler?
    ) {
        guard signal.canBeCaught else {
            return
        }

        guard let action = action else {
            defaultAction(for: signal)
            return
        }

        handlers[signal] = action
#if canImport(Darwin)
        let sa_handler = __sigaction_u(__sa_handler: {
            guard let signal = Signal(rawValue: $0) else {
                return
            }
            Signals.handlers[signal]?(signal)
        })
#elseif canImport(Glibc)
        #error("TODO SUPPORT LINUX")
#endif

        var actionHandler = sigaction(
            __sigaction_u: sa_handler,
            sa_mask: mask,
            sa_flags: flags.rawValue
        )
        sigaction(signal.rawValue, &actionHandler, nil)
    }

    @inlinable
    public static func handle(
        signal: Signal,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) {
        handle(
            signal: signal,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    @inlinable
    @_specialize(where Mask == [Signal])
    public static func handle<Mask>(
        signal: Signal,
        flags: SignalHandlerFlag = .init(),
        mask: Mask,
        _ action: SignalHandler?
    ) where Mask: Sequence, Mask.Element == Signal {
        handle(
            signal: signal,
            flags: flags,
            mask: mask.sigset,
            action: action
        )
    }

    @inlinable
    public static func handle(
        signals: Signal...,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) {
        handle(
            signals: signals,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    @inlinable
    public static func handle<S>(
        signals: S,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) where S: Sequence, S.Element == Signal {
        handle(
            signals: signals,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    @inlinable
    @_specialize(where Mask == [Signal])
    public static func handle<Mask>(
        signals: Signal...,
        flags: SignalHandlerFlag = .init(),
        mask: Mask,
        _ action: SignalHandler?
    ) where Mask: Sequence, Mask.Element == Signal {
        handle(
            signals: signals,
            flags: flags,
            mask: mask,
            action
        )
    }

    @inlinable
    @_specialize(where S == [Signal], Mask == [Signal])
    public static func handle<S, Mask>(
        signals: S,
        flags: SignalHandlerFlag = .init(),
        mask: Mask,
        _ action: SignalHandler?
    ) where S: Sequence, S.Element == Signal, Mask: Sequence, Mask.Element == Signal {
        for signal in signals {
            handle(
                signal: signal,
                flags: flags,
                mask: mask.sigset,
                action: action
            )
        }
    }
}

// MARK: - Default Action
extension Signals {
    @inlinable
    public static func defaultAction(for _signal: Signal) {
        guard _signal.canBeIgnored && _signal.canBeCaught else {
            return
        }
        signal(_signal.rawValue, SIG_DFL)
        handlers.removeValue(forKey: _signal)
    }

    @inlinable
    public static func defaultAction(for signals: Signal...) {
        ignore(signals: signals)
    }

    @inlinable
    public static func defaultAction<S>(for signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal: signal)
        }
    }
}

// MARK: - Ignore
extension Signals {
    @inlinable
    public static func ignore(signal _signal: Signal) {
        guard _signal.canBeIgnored else {
            return
        }
        signal(Int32(_signal.rawValue), SIG_IGN)
    }

    @inlinable
    public static func ignore(signals: Signal...) {
        ignore(signals: signals)
    }

    @inlinable
    public static func ignore<S>(signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal: signal)
        }
    }
}

// MARK: - Block
extension Signals {
    @inlinable
    public var currentBlockedSignals: Set<Signal> {
        var blockedSignals = sigset_t()
        sigprocmask(0, nil, &blockedSignals)
        return Signal.parse(mask: blockedSignals)
    }

    @usableFromInline
    @inline(__always)
    static func block(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_BLOCK, sigset, nil)
    }

    @inlinable
    public static func block(signal: Signal) {
        var setToBlock = sigset_t(signal.rawValue)
        block(sigset: &setToBlock)
    }

    @inlinable
    @_transparent
    public static func block(signals: Signal...) {
        block(signals: signals)
    }

    @inlinable
    public static func block<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        block(sigset: &setToBlock)
    }
}

// MARK: - Unblock
extension Signals {
    @inlinable
    public static func unblockAll() {
        var emptySigset = sigset_t()
        unblock(sigset: &emptySigset)
    }

    @usableFromInline
    @inline(__always)
    static func unblock(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_UNBLOCK, sigset, nil)
    }

    @inlinable
    public static func unblock(signal: Signal) {
        var setToUnblock = sigset_t(signal.rawValue)
        unblock(sigset: &setToUnblock)
    }

    @inlinable
    @_transparent
    public static func unblock(signals: Signal...) {
        unblock(signals: signals)
    }

    @inlinable
    public static func unblock<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToUnblock = signals.sigset
        unblock(sigset: &setToUnblock)
    }
}

// MARK: - Set Mask
extension Signals {
    @usableFromInline
    @inline(__always)
    static func mask(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_SETMASK, sigset, nil)
    }

    @inlinable
    public static func mask(signal: Signal) {
        var sigset = sigset_t(signal.rawValue)
        mask(sigset: &sigset)
    }

    @inlinable
    public static func mask(signals: Signal...) {
        mask(signals: signals)
    }

    @inlinable
    public static func mask<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        mask(sigset: &setToBlock)
    }
}

// MARK: - Raise
extension Signals {
    @inlinable
    public static func raise(signal: Signal) {
        _ = _raise(signal.rawValue)
    }
}
