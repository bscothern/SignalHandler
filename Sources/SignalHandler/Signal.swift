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

/// Signal values defined in the C header `signal.h`.
public enum Signal: Hashable, CaseIterable {
    /// Terminal line hangup (SIGHUP)
    ///
    /// Default Action: Terminate process
    case hangUp

    /// Terminal line hangup (SIGHUP)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "hangUp")
    public static var hup: Self { .hangUp }

    /// Interrupt program (SIGINT)
    ///
    /// Default Action: Terminate process
    case interrupt

    /// Interrupt program (SIGINT)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "interrupt")
    public static var int: Self { .interrupt }

    /// Quit program (SIGQUIT)
    ///
    /// Default Action: Create core image
    case quit

    /// Illegal Instruction (SIGILL)
    ///
    /// Default Action: Create core image
    case illegalInstruction

    /// Illegal Instruction (SIGILL)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "illegalInstruction")
    public static var ill: Self { .illegalInstruction }

    /// Trace trap (SIGTRAP)
    ///
    /// Defualt Action: Create core image
    case trap

    /// Abort program (SIGABRT)
    ///
    /// - Note: Formerly `SIGIOT`
    ///
    /// Default Action: Create core image
    case abort

    /// Abort program (SIGABRT)
    ///
    /// - Note: Formerly `SIGIOT`
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "abort")
    public static var abrt: Self { .abort }

    /// Abort program (SIGABRT)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "abort")
    public static var iot: Self { .abort }

    /// Emulate instruction executed (SIGEMT)
    ///
    /// Default Action: Create core image
    case emulateInstructionExecuted

    /// Emulate instruction executed (SIGEMT)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "emulateInstructionExecuted")
    public static var emt: Self { .emulateInstructionExecuted }

    /// Floating-point exception (SIGFPE)
    ///
    /// Default Action: Create core image
    case floatingPointException

    /// Floating-point exception (SIGFPE)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "floatingPointException")
    public static var fpe: Self { .floatingPointException }

    /// Kill program (SIGKILL)
    ///
    /// Default Action: Terminate process
    case kill

    /// Bus error (SIGBUS)
    ///
    /// Default Action: Create core image
    case busError

    /// Bus error (SIGBUS)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "busError")
    public static var bus: Self { .busError }

    /// Segmentation violation (SIGSEGV)
    ///
    /// Default Action: Create core image
    case segmentationViolation

    /// Segmentation violation (SIGSEGV)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "segmentationViolation")
    public static var segv: Self { .segmentationViolation }

    /// Non-existent system call invoked (SIGSYS)
    ///
    /// Default Action: Create core image
    case nonExistentSystemCallInvoked

    /// Non-existent system call invoked (SIGSYS)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "nonExistentSystemCallInvoked")
    public static var sys: Self { .nonExistentSystemCallInvoked }

    /// Write on a pipe with no reader (SIGPIPE)
    ///
    /// Default Action: Terminate process
    case writeOnPipeWithNoReader

    /// Write on a pipe with no reader (SIGPIPE)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "writeOnPipeWithNoReader")
    public static var pipe: Self { .writeOnPipeWithNoReader }

    /// Real-time timer expired (SIGALRM)
    ///
    /// Default Action: Terminate process
    case realtimeTimerExpired

    /// Real-time timer expired (SIGALRM)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "writeOnPipeWithNoReader")
    public static var alrm: Self { .realtimeTimerExpired }

    /// Software termination signal (SIGTERM)
    ///
    /// Default Action: Terminate process
    case termination

    /// Software termination signal (SIGTERM)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "termination")
    public static var term: Self { .termination }

    /// Urgent condition present on socket (SIGURG)
    ///
    /// Default Action: Discard signal
    case urgentConditionPresentOnSocket

    /// Urgent condition present on socket (SIGURG)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "urgentConditionPresentOnSocket")
    public static var urg: Self { .urgentConditionPresentOnSocket }

    /// Stop (SIGSTOP)
    ///
    /// Default Action: Stop process
    ///
    /// - Important: Cannot be caught or ignored
    case stop

    /// Stop signal generated from keyboard (SIGTSTP)
    ///
    /// Default Action: Stop process
    case stopFromKeyboard

    /// Stop signal generated from keyboard (SIGTSTP)
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "stopFromKeyboard")
    public static var tstp: Self { .stopFromKeyboard }

    /// Continue after stop (SIGCONT)
    ///
    /// Default Action: Discard signal
    case continueAfterStop

    /// Continue after stop (SIGCONT)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "continueAfterStop")
    public static var cont: Self { .continueAfterStop }

    /// Child status has changed (SIGCHLD)
    ///
    /// Default Action: Discard signal
    case childStatusChanged

    /// Child status has changed (SIGCHLD)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "childStatusChanged")
    public static var chld: Self { .childStatusChanged }

    /// Background read attempted from control terminal (SIGTTOU)
    ///
    /// Default Action: Stop process
    case backgroundReadAttemptedFromControlTerminal

    /// Background read attempted from control terminal
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "backgroundReadAttemptedFromControlTerminal")
    public static var ttin: Self { .backgroundReadAttemptedFromControlTerminal }

    /// Background write attempted to control terminal (SIGTTOU)
    ///
    /// Default Action: Stop process
    case backgroundWriteAttemptedFromControlTerminal

    /// Background write attempted to control terminal
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "backgroundWriteAttemptedFromControlTerminal")
    public static var ttou: Self { .backgroundWriteAttemptedFromControlTerminal }

    /// I/O is possible on a descriptor (SIGIO)
    ///
    /// Default Action: Discard Signal
    ///
    /// - Note: See fcntl(2)
    case ioIsPossibleOnADescriptor

    /// I/O is possible on a descriptor (SIGIO)
    ///
    /// Default Action: Discard Signal
    ///
    /// - Note: See map page fcntl(2)
    @available(*, unavailable, renamed: "ioIsPossibleOnADescriptor")
    public static var io: Self { .ioIsPossibleOnADescriptor }

    /// CPU time limit exceeded (SIGXCPU)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setrlimit(2)
    case cpuTimeLimitExceeded

    /// CPU time limit exceeded (SIGXCPU)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setrlimit(2)
    @available(*, unavailable, renamed: "cpuTimeLimitExceeded")
    public static var xcpu: Self { .cpuTimeLimitExceeded }

    /// File size limit exceeded (SIGXFSZ)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setrlimit(2)
    case fileSizeLimitExceeded

    /// File size limit exceeded (SIGXFSZ)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setrlimit(2)
    @available(*, unavailable, renamed: "fileSizeLimitExceeded")
    public static var xfsz: Self { .fileSizeLimitExceeded }

    /// Virtual time alarm (SIGVTALRM)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setitimer(2)
    case virtualTimeAlarm

    /// Virtual time alarm (SIGVTALRM)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setitimer(2)
    @available(*, unavailable, renamed: "virtualTimeAlarm")
    public static var vtalrm: Self { .virtualTimeAlarm }

    /// Profiling timer alarm (SIGPROF)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setitimer(2)
    case profilingTimerAlarm

    /// Profiling timer alarm (SIGPROF)
    ///
    /// Default Action: Terminate process
    ///
    /// - Note: See man page for setitimer(2)
    @available(*, unavailable, renamed: "profilingTimerAlarm")
    public static var prof: Self { .profilingTimerAlarm }

    /// Window size change (SIGWINCH)
    ///
    /// Default Action: Discard signal
    case windowSizeChange

    /// Window size change (SIGWINCH)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "windowSizeChange")
    public static var winch: Self { .windowSizeChange }

    /// Status request from keyboard (SIGINFO)
    ///
    /// Default Action: Discard signal
    case statusRequestFromKeyboard

    /// Status request from keyboard (SIGINFO)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "statusRequestFromKeyboard")
    public static var info: Self { .statusRequestFromKeyboard }

    /// User defined signal 1 (SIGUSR1)
    ///
    /// Default Action: Terminate process
    case userDefined1

    /// User defined signal 1 (SIGUSR1)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "userDefined1")
    public static var usr1: Self { .userDefined1 }

    /// User defined signal 2 (SIGUSR2)
    ///
    /// Default Action: Terminate process
    case userDefined2

    /// User defined signal 2 (SIGUSR2)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "userDefined2")
    public static var usr2: Self { .userDefined2 }
}

extension Signal: RawRepresentable {
    @inlinable
    public var rawValue: CInt {
        switch self {
        case .hangUp:
            return SIGHUP
        case .interrupt:
            return SIGINT
        case .quit:
            return SIGQUIT
        case .illegalInstruction:
            return SIGILL
        case .trap:
            return SIGTRAP
        case .abort:
            return SIGABRT
        case .emulateInstructionExecuted:
            return SIGEMT
        case .floatingPointException:
            return SIGFPE
        case .kill:
            return SIGKILL
        case .busError:
            return SIGBUS
        case .segmentationViolation:
            return SIGSEGV
        case .nonExistentSystemCallInvoked:
            return SIGSYS
        case .writeOnPipeWithNoReader:
            return SIGPIPE
        case .realtimeTimerExpired:
            return SIGALRM
        case .termination:
            return SIGTERM
        case .urgentConditionPresentOnSocket:
            return SIGURG
        case .stop:
            return SIGSTOP
        case .stopFromKeyboard:
            return SIGTSTP
        case .continueAfterStop:
            return SIGCONT
        case .childStatusChanged:
            return SIGCHLD
        case .backgroundReadAttemptedFromControlTerminal:
            return SIGTTIN
        case .backgroundWriteAttemptedFromControlTerminal:
            return SIGTTOU
        case .ioIsPossibleOnADescriptor:
            return SIGIO
        case .cpuTimeLimitExceeded:
            return SIGXCPU
        case .fileSizeLimitExceeded:
            return SIGXFSZ
        case .virtualTimeAlarm:
            return SIGVTALRM
        case .profilingTimerAlarm:
            return SIGPROF
        case .windowSizeChange:
            return SIGWINCH
        case .statusRequestFromKeyboard:
            return SIGINFO
        case .userDefined1:
            return SIGUSR1
        case .userDefined2:
            return SIGUSR2
        }
    }

    @inlinable
    public init?(rawValue: Int32) {
        switch rawValue {
        case SIGHUP:
            self = .hangUp
        case SIGINT:
            self = .interrupt
        case SIGQUIT:
            self = .quit
        case SIGILL:
            self = .illegalInstruction
        case SIGTRAP:
            self = .trap
        case SIGABRT:
            self = .abort
        case SIGEMT:
            self = .emulateInstructionExecuted
        case SIGFPE:
            self = .floatingPointException
        case SIGKILL:
            self = .kill
        case SIGBUS:
            self = .busError
        case SIGSEGV:
            self = .segmentationViolation
        case SIGSYS:
            self = .nonExistentSystemCallInvoked
        case SIGPIPE:
            self = .writeOnPipeWithNoReader
        case SIGALRM:
            self = .realtimeTimerExpired
        case SIGTERM:
            self = .termination
        case SIGURG:
            self = .urgentConditionPresentOnSocket
        case SIGSTOP:
            self = .stop
        case SIGTSTP:
            self = .stopFromKeyboard
        case SIGCONT:
            self = .continueAfterStop
        case SIGCHLD:
            self = .childStatusChanged
        case SIGTTIN:
            self = .backgroundReadAttemptedFromControlTerminal
        case SIGTTOU:
            self = .backgroundWriteAttemptedFromControlTerminal
        case SIGIO:
            self = .ioIsPossibleOnADescriptor
        case SIGXCPU:
            self = .cpuTimeLimitExceeded
        case SIGXFSZ:
            self = .fileSizeLimitExceeded
        case SIGVTALRM:
            self = .virtualTimeAlarm
        case SIGPROF:
            self = .profilingTimerAlarm
        case SIGWINCH:
            self = .windowSizeChange
        case SIGINFO:
            self = .statusRequestFromKeyboard
        case SIGUSR1:
            self = .userDefined1
        case SIGUSR2:
            self = .userDefined2
        default:
            return nil
        }
    }
}

extension Signal {
    public enum DefaultAction: Hashable, CaseIterable {
        case createCoreImage
        case discardSignal
        case terminateProcess
        case stopProcess
    }

    @inlinable
    public var defaultAction: DefaultAction {
        switch self {
        case .hangUp:
            return .terminateProcess
        case .interrupt:
            return .terminateProcess
        case .quit:
            return .createCoreImage
        case .illegalInstruction:
            return .createCoreImage
        case .trap:
            return .createCoreImage
        case .abort:
            return .createCoreImage
        case .emulateInstructionExecuted:
            return .createCoreImage
        case .floatingPointException:
            return .createCoreImage
        case .kill:
            return .terminateProcess
        case .busError:
            return .createCoreImage
        case .segmentationViolation:
            return .createCoreImage
        case .nonExistentSystemCallInvoked:
            return .createCoreImage
        case .writeOnPipeWithNoReader:
            return .terminateProcess
        case .realtimeTimerExpired:
            return .terminateProcess
        case .termination:
            return .terminateProcess
        case .urgentConditionPresentOnSocket:
            return .discardSignal
        case .stop:
            return .stopProcess
        case .stopFromKeyboard:
            return .stopProcess
        case .continueAfterStop:
            return .discardSignal
        case .childStatusChanged:
            return .discardSignal
        case .backgroundReadAttemptedFromControlTerminal:
            return .stopProcess
        case .backgroundWriteAttemptedFromControlTerminal:
            return .stopProcess
        case .ioIsPossibleOnADescriptor:
            return .discardSignal
        case .cpuTimeLimitExceeded:
            return .terminateProcess
        case .fileSizeLimitExceeded:
            return .terminateProcess
        case .virtualTimeAlarm:
            return .terminateProcess
        case .profilingTimerAlarm:
            return .terminateProcess
        case .windowSizeChange:
            return .discardSignal
        case .statusRequestFromKeyboard:
            return .discardSignal
        case .userDefined1:
            return .terminateProcess
        case .userDefined2:
            return .terminateProcess
        }
    }
}

extension Signal {
    @inlinable
    public var canBeCaught: Bool {
        switch self {
        case .kill,
                .stop:
            return false
        default:
            return true
        }
    }

    @inlinable
    public var canBeIgnored: Bool {
        switch self {
        case .kill,
                .stop:
            return false
        default:
            return true
        }
    }
}

extension Signal {
    @inlinable
    public static var pending: Set<Signal> {
        var pending = sigset_t()
        sigpending(&pending)
        return parse(mask: pending)
    }

    @usableFromInline
    static func parse(mask: sigset_t) -> Set<Signal> {
        .init(allCases.filter { UInt32($0.rawValue) & mask != 0 })
    }
}

extension Sequence where Element == Signal {
    @usableFromInline
    var sigset: sigset_t {
        var set = sigset_t()
        for signal in self {
            set |= sigset_t(signal.rawValue)
        }
        return set
    }
}
