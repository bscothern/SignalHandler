//
//  SignalActionFlag.swift
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

// TODO: update these docs as things get fully put together
public struct SignalActionFlag: OptionSet, RawRepresentable, CaseIterable {
    public let rawValue: CInt

    public init(rawValue: CInt) {
        self.rawValue = rawValue
    }

    /// If this bit is set when installing a catching function for the `Signal.childStatusChanged (SIGCHLD)` signal, the `Signal.childStatusChanged (SIGCHLD)` signal will be generated only when a child process exits, not when a child process stops.
    public static let noChildStop = Self(rawValue: SA_NOCLDSTOP)

    /// If this bit is set when calling sigaction() for the `Signal.childStatusChanged (SIGCHLD)` signal, the system will not create zombie processes when children of the calling process exit.
    /// If the calling process subsequently issues a wait(2) (or equivalent), it blocks until all of the calling process's child processes terminate, and then returns a value of -1 with errno set to ECHILD.
    public static let noChildWait = Self(rawValue: SA_NOCLDWAIT)

    /// If this bit is set, the system will deliver the signal to the process on a signal stack, specified with sigaltstack(2).
    public static let onStack = Self(rawValue: SA_ONSTACK)

    /// If this bit is set, further occurrences of the delivered signal are not masked during the execution of the handler.
    public static let noDefer = Self(rawValue: SA_NODEFER)

    /// If this bit is set, the handler is reset back to SIG_DFL at the moment the signal is delivered.
    public static let resetHandler = Self(rawValue: SA_RESETHAND)

    /// If this bit is set, the handler function is assumed to be pointed to by the sa_sigaction member of struct sigaction and should match the prototype shown above or as below in EXAMPLES.
    /// This bit should not be set when assigning SIG_DFL or SIG_IGN.
    public static let restart = Self(rawValue: SA_RESTART)

    /// If this bit is set, the handler function is assumed to be pointed to by the sa_sigaction member of struct sigaction and should match the prototype shown above or as below in EXAMPLES.
    /// This bit should not be set when assigning SIG_DFL or SIG_IGN.
    public static let info = Self(rawValue: SA_SIGINFO)

    public static let allCases: [Self] = [
        noChildStop,
        noChildWait,
        onStack,
        noDefer,
        resetHandler,
        restart,
        info,
    ]
}
