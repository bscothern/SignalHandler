//
//  Signals.handle.swift
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

import Foundation

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
            restoreDefaultAction(for: signal)
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
        guard sigaction(signal.rawValue, &actionHandler, nil) == 0 else {
            return
        }
    }

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signal: The `Signal` the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    public static func handle(
        _ signal: Signal,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) {
        handle(
            signal,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signal: The `Signal` the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - mask: The signal mask to apply for the scope of the handler.
    ///     See `Signals.mask` functions for more information.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    @_specialize(where Mask == [Signal])
    public static func handle<Mask>(
        _ signal: Signal,
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

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signals: The `Signal`s the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    public static func handle(
        _ signals: Signal...,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) {
        handle(
            signals,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signals: The `Signal`s the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    public static func handle<S>(
        _ signals: S,
        flags: SignalHandlerFlag = .init(),
        _ action: SignalHandler?
    ) where S: Sequence, S.Element == Signal {
        handle(
            signals,
            flags: flags,
            mask: [Signal](),
            action
        )
    }

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signals: The `Signal`s the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - mask: The signal mask to apply for the scope of the handler.
    ///     See `Signals.mask` functions for more information.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    @_specialize(where Mask == [Signal])
    public static func handle<Mask>(
        _ signals: Signal...,
        flags: SignalHandlerFlag = .init(),
        mask: Mask,
        _ action: SignalHandler?
    ) where Mask: Sequence, Mask.Element == Signal {
        handle(
            signals,
            flags: flags,
            mask: mask,
            action
        )
    }

    /// Registers a signal handler.
    ///
    /// - Important: You **must** not allocate any heap memory in your action or your executable will become corrupted.
    ///     This means you cannot safely create any class, actor, or indirect enum instance because there is no way to ensure the compiler promotes them to being stack allocated.
    ///     You also cannot safely create any struct that contains a class, actor, or indirect enum as part of it.
    ///     This cannot be resolved by dropping to `Unsafe[Mutable]Pointer` allocation and management as their unerlying implimentation uses the same memory allocation mechanism as normal swift objects.
    ///
    /// - Note: This uses the C function `sigaction`.
    ///
    /// - Parameters:
    ///   - signals: The `Signal`s the handler is for.
    ///   - flags: Any flags to set on the handler.
    ///   - mask: The signal mask to apply for the scope of the handler.
    ///     See `Signals.mask` functions for more information.
    ///   - action: The action to perform when the `signal` is raised.
    @inlinable
    @_specialize(where S == [Signal], Mask == [Signal])
    public static func handle<S, Mask>(
        _ signals: S,
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
