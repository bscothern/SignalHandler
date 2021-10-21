//
//  Signals.stack.swift
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

// TODO: Support this stuff it is kind of janky...
#if false
extension Signals {
    public struct Stack {
        #if canImport(Darwin)
        public typealias StackSize = __darwin_size_t
        #else
        public typealias StackSize = size_t
        #endif

        public enum Error: Swift.Error {
            case cannotDisableActiveStack
        }

        public struct Flags: OptionSet, RawRepresentable {
            public let rawValue: CInt

            @inlinable
            public init(rawValue: CInt) {
                self.rawValue = rawValue
            }

            public static let disabled = Self(rawValue: SS_DISABLE)
            public static let onStack = Self(rawValue: SS_ONSTACK)
        }

        public var stackPointer: UnsafeMutableRawPointer?
        public var stackSize: StackSize
        public var flags: Flags

        @usableFromInline
        var stack: stack_t {
            .init(
                ss_sp: stackPointer,
                ss_size: stackSize,
                ss_flags: flags.rawValue
            )
        }

        @usableFromInline
        init(stack: stack_t) {
            self.stackPointer = stack.ss_sp
            self.stackSize = stack.ss_size
            self.flags = .init(rawValue: stack.ss_flags)
        }

        @inlinable
        public init?(
            stackPointer: UnsafeMutableRawPointer?,
            stackSize: StackSize,
            flags: Flags
        ) {
            guard stackSize >= StackSize(MINSIGSTKSZ) else {
                return nil
            }
            self.stackPointer = stackPointer
            self.stackSize = stackSize
            self.flags = flags
        }

        @inlinable
        public init?(
            stack: UnsafeMutableRawBufferPointer,
            flags: Flags
        ) {
            self.init(
                stackPointer: stack.baseAddress,
                stackSize: .init(stack.count),
                flags: flags
            )
        }
    }

    @inlinable
    public var stack: Stack {
        get {
            var stack = stack_t()
            sigaltstack(nil, &stack)
            return .init(stack: stack)
        }
        set {
            var stack = newValue.stack
            sigaltstack(&stack, nil)
        }
    }

    @inlinable
    public var signalStackEnabled: Bool {
        var stack = stack_t()
        sigaltstack(nil, &stack)
        return stack.ss_flags & SS_DISABLE == 0
    }

    @inlinable
    @discardableResult
    public func disableSignalStack() throws -> Stack {
        var stack = stack_t(
            ss_sp: nil,
            ss_size: 0,
            ss_flags: SS_DISABLE
        )
        var oldStack = stack_t()

        let oldErrno = errno
        errno = 0
        defer { errno = oldErrno }

        guard sigaltstack(&stack, &oldStack) == 0 else {
            throw Stack.Error.cannotDisableActiveStack
        }
        return .init(stack: oldStack)
    }
}
#endif
