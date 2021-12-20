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
    // MARK: - C Standard Signals
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

    /// Floating-point exception (SIGFPE)
    ///
    /// Default Action: Create core image
    case floatingPointException

    /// Floating-point exception (SIGFPE)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "floatingPointException")
    public static var fpe: Self { .floatingPointException }

    /// Illegal Instruction (SIGILL)
    ///
    /// Default Action: Create core image
    case illegalInstruction

    /// Illegal Instruction (SIGILL)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "illegalInstruction")
    public static var ill: Self { .illegalInstruction }

    /// Interrupt program (SIGINT)
    ///
    /// Default Action: Terminate process
    case interrupt

    /// Interrupt program (SIGINT)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "interrupt")
    public static var int: Self { .interrupt }

    /// Segmentation violation (SIGSEGV)
    ///
    /// Default Action: Create core image
    case segmentationViolation

    /// Segmentation violation (SIGSEGV)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "segmentationViolation")
    public static var segv: Self { .segmentationViolation }

    /// Software termination signal (SIGTERM)
    ///
    /// Default Action: Terminate process
    case termination

    /// Software termination signal (SIGTERM)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "termination")
    public static var term: Self { .termination }

    // MARK: - Unix Signal Extensions
#if !NO_UNIX_SIGNALS
#if !NO_SIGHUP
    /// Terminal line hangup (SIGHUP)
    ///
    /// Default Action: Terminate process
    case hangUp

    /// Terminal line hangup (SIGHUP)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "hangUp")
    public static var hup: Self { .hangUp }
#endif

#if !NO_SIGQUIT
    /// Quit program (SIGQUIT)
    ///
    /// Default Action: Create core image
    case quit
#endif

#if !NO_SIGTRAP
    /// Trace trap (SIGTRAP)
    ///
    /// Defualt Action: Create core image
    case trap
#endif

#if !NO_SIGEMT
    /// Emulate instruction executed (SIGEMT)
    ///
    /// Default Action: Create core image
    case emulateInstructionExecuted

    /// Emulate instruction executed (SIGEMT)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "emulateInstructionExecuted")
    public static var emt: Self { .emulateInstructionExecuted }
#endif

#if !NO_SIGKILL
    /// Kill program (SIGKILL)
    ///
    /// Default Action: Terminate process
    case kill
#endif

#if !NO_SIGBUS
    /// Bus error (SIGBUS)
    ///
    /// Default Action: Create core image
    case busError

    /// Bus error (SIGBUS)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "busError")
    public static var bus: Self { .busError }
#endif

#if !NO_SIGSYS
    /// Non-existent system call invoked (SIGSYS)
    ///
    /// Default Action: Create core image
    case nonExistentSystemCallInvoked

    /// Non-existent system call invoked (SIGSYS)
    ///
    /// Default Action: Create core image
    @available(*, unavailable, renamed: "nonExistentSystemCallInvoked")
    public static var sys: Self { .nonExistentSystemCallInvoked }
#endif

#if !NO_SIGPIPE
    /// Write on a pipe with no reader (SIGPIPE)
    ///
    /// Default Action: Terminate process
    case writeOnPipeWithNoReader

    /// Write on a pipe with no reader (SIGPIPE)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "writeOnPipeWithNoReader")
    public static var pipe: Self { .writeOnPipeWithNoReader }
#endif

#if !NO_SIGALRM
    /// Real-time timer expired (SIGALRM)
    ///
    /// Default Action: Terminate process
    case realtimeTimerExpired

    /// Real-time timer expired (SIGALRM)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "writeOnPipeWithNoReader")
    public static var alrm: Self { .realtimeTimerExpired }
#endif

#if !NO_SIGURG
    /// Urgent condition present on socket (SIGURG)
    ///
    /// Default Action: Discard signal
    case urgentConditionPresentOnSocket

    /// Urgent condition present on socket (SIGURG)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "urgentConditionPresentOnSocket")
    public static var urg: Self { .urgentConditionPresentOnSocket }
#endif

#if !NO_SIGSTOP
    /// Stop (SIGSTOP)
    ///
    /// Default Action: Stop process
    ///
    /// - Important: Cannot be caught or ignored
    case stop
#endif

#if !NO_SIGTSTP
    /// Stop signal generated from keyboard (SIGTSTP)
    ///
    /// Default Action: Stop process
    case stopFromKeyboard

    /// Stop signal generated from keyboard (SIGTSTP)
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "stopFromKeyboard")
    public static var tstp: Self { .stopFromKeyboard }
#endif

#if !NO_SIGCONT
    /// Continue after stop (SIGCONT)
    ///
    /// Default Action: Discard signal
    case continueAfterStop

    /// Continue after stop (SIGCONT)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "continueAfterStop")
    public static var cont: Self { .continueAfterStop }
#endif

#if !NO_SIGCHLD
    /// Child status has changed (SIGCHLD)
    ///
    /// Default Action: Discard signal
    case childStatusChanged

    /// Child status has changed (SIGCHLD)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "childStatusChanged")
    public static var chld: Self { .childStatusChanged }
#endif

#if !NO_SIGTTOU
    /// Background read attempted from control terminal (SIGTTOU)
    ///
    /// Default Action: Stop process
    case backgroundReadAttemptedFromControlTerminal

    /// Background read attempted from control terminal
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "backgroundReadAttemptedFromControlTerminal")
    public static var ttin: Self { .backgroundReadAttemptedFromControlTerminal }
#endif

#if !NO_SIGTTOU
    /// Background write attempted to control terminal (SIGTTOU)
    ///
    /// Default Action: Stop process
    case backgroundWriteAttemptedFromControlTerminal

    /// Background write attempted to control terminal
    ///
    /// Default Action: Stop process
    @available(*, unavailable, renamed: "backgroundWriteAttemptedFromControlTerminal")
    public static var ttou: Self { .backgroundWriteAttemptedFromControlTerminal }
#endif

#if !NO_SIGIO
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
#endif

#if !NO_SIGXCPU
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
#endif

#if !NO_SIGXFSZ
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
#endif

#if !NO_SIGVTALRM
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
#endif

#if !NO_SIGPROF
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
#endif

#if !NO_SIGWINCH
    /// Window size change (SIGWINCH)
    ///
    /// Default Action: Discard signal
    case windowSizeChange

    /// Window size change (SIGWINCH)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "windowSizeChange")
    public static var winch: Self { .windowSizeChange }
#endif

#if !NO_SIGINFO
    /// Status request from keyboard (SIGINFO)
    ///
    /// Default Action: Discard signal
    case statusRequestFromKeyboard

    /// Status request from keyboard (SIGINFO)
    ///
    /// Default Action: Discard signal
    @available(*, unavailable, renamed: "statusRequestFromKeyboard")
    public static var info: Self { .statusRequestFromKeyboard }
#endif

#if !NO_SIGUSR1
    /// User defined signal 1 (SIGUSR1)
    ///
    /// Default Action: Terminate process
    case userDefined1

    /// User defined signal 1 (SIGUSR1)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "userDefined1")
    public static var usr1: Self { .userDefined1 }
#endif

#if !NO_SIGUSR2
    /// User defined signal 2 (SIGUSR2)
    ///
    /// Default Action: Terminate process
    case userDefined2

    /// User defined signal 2 (SIGUSR2)
    ///
    /// Default Action: Terminate process
    @available(*, unavailable, renamed: "userDefined2")
    public static var usr2: Self { .userDefined2 }
#endif
#endif // !NO_UNIX_SIGNALS
}

extension Signal: RawRepresentable {
    @inlinable
    public var rawValue: CInt {
        switch self {
        case .abort:
            return SIGABRT
        case .floatingPointException:
            return SIGFPE
        case .illegalInstruction:
            return SIGILL
        case .interrupt:
            return SIGINT
        case .segmentationViolation:
            return SIGSEGV
        case .termination:
            return SIGTERM
#if !NO_UNIX_SIGNALS
#if !NO_SIGHUP
        case .hangUp:
            return SIGHUP
#endif
#if !NO_SIGQUIT
        case .quit:
            return SIGQUIT
#endif
#if !NO_SIGTRAP
        case .trap:
            return SIGTRAP
#endif
#if !NO_SIGEMT
        case .emulateInstructionExecuted:
            return SIGEMT
#endif
#if !NO_SIGKILL
        case .kill:
            return SIGKILL
#endif
#if !NO_SIGBUS
        case .busError:
            return SIGBUS
#endif
#if !NO_SIGSYS
        case .nonExistentSystemCallInvoked:
            return SIGSYS
#endif
#if !NO_SIGPIPE
        case .writeOnPipeWithNoReader:
            return SIGPIPE
#endif
#if !NO_SIGALRM
        case .realtimeTimerExpired:
            return SIGALRM
#endif
#if !NO_SIGURG
        case .urgentConditionPresentOnSocket:
            return SIGURG
#endif
#if !NO_SIGSTOP
        case .stop:
            return SIGSTOP
#endif
#if !NO_SIGTSTP
        case .stopFromKeyboard:
            return SIGTSTP
#endif
#if !NO_SIGCONT
        case .continueAfterStop:
            return SIGCONT
#endif
#if !NO_SIGCHLD
        case .childStatusChanged:
            return SIGCHLD
#endif
#if !NO_SIGTTIN
        case .backgroundReadAttemptedFromControlTerminal:
            return SIGTTIN
#endif
#if !NO_SIGTTOU
        case .backgroundWriteAttemptedFromControlTerminal:
            return SIGTTOU
#endif
#if !NO_SIGIO
        case .ioIsPossibleOnADescriptor:
            return SIGIO
#endif
#if !NO_SIGXCPU
        case .cpuTimeLimitExceeded:
            return SIGXCPU
#endif
#if !NO_SIGXFSZ
        case .fileSizeLimitExceeded:
            return SIGXFSZ
#endif
#if !NO_SIGVTALRM
        case .virtualTimeAlarm:
            return SIGVTALRM
#endif
#if !NO_SIGPROF
        case .profilingTimerAlarm:
            return SIGPROF
#endif
#if !NO_SIGWINCH
        case .windowSizeChange:
            return SIGWINCH
#endif
#if !NO_SIGINFO
        case .statusRequestFromKeyboard:
            return SIGINFO
#endif
#if !NO_SIGUSR1
        case .userDefined1:
            return SIGUSR1
#endif
#if !NO_SIGUSR2
        case .userDefined2:
            return SIGUSR2
#endif
#endif // !NO_UNIX_SIGNALS
        }
    }

    @inlinable
    public init?(rawValue: Int32) {
        switch rawValue {
        case SIGABRT:
            self = .abort
        case SIGFPE:
            self = .floatingPointException
        case SIGILL:
            self = .illegalInstruction
        case SIGINT:
            self = .interrupt
        case SIGSEGV:
            self = .segmentationViolation
        case SIGTERM:
            self = .termination
#if !NO_UNIX_SIGNALS
#if !NO_SIGHUP
        case SIGHUP:
            self = .hangUp
#endif
#if !NO_SIGQUIT
        case SIGQUIT:
            self = .quit
#endif
#if !NO_SIGTRAP
        case SIGTRAP:
            self = .trap
#endif
#if !NO_SIGEMT
        case SIGEMT:
            self = .emulateInstructionExecuted
#endif
#if !NO_SIGKILL
        case SIGKILL:
            self = .kill
#endif
#if !NO_SIGBUS
        case SIGBUS:
            self = .busError
#endif
#if !NO_SIGSYS
        case SIGSYS:
            self = .nonExistentSystemCallInvoked
#endif
#if !NO_SIGPIPE
        case SIGPIPE:
            self = .writeOnPipeWithNoReader
#endif
#if !NO_SIGALRM
        case SIGALRM:
            self = .realtimeTimerExpired
#endif
#if !NO_SIGURG
        case SIGURG:
            self = .urgentConditionPresentOnSocket
#endif
#if !NO_SIGSTOP
        case SIGSTOP:
            self = .stop
#endif
#if !NO_SIGTSTP
        case SIGTSTP:
            self = .stopFromKeyboard
#endif
#if !NO_SIGCONT
        case SIGCONT:
            self = .continueAfterStop
#endif
#if !NO_SIGCHLD
        case SIGCHLD:
            self = .childStatusChanged
#endif
#if !NO_SIGTTIN
        case SIGTTIN:
            self = .backgroundReadAttemptedFromControlTerminal
#endif
#if !NO_SIGTTOU
        case SIGTTOU:
            self = .backgroundWriteAttemptedFromControlTerminal
#endif
#if !NO_SIGIO
        case SIGIO:
            self = .ioIsPossibleOnADescriptor
#endif
#if !NO_SIGXCPU
        case SIGXCPU:
            self = .cpuTimeLimitExceeded
#endif
#if !NO_SIGXFSZ
        case SIGXFSZ:
            self = .fileSizeLimitExceeded
#endif
#if !NO_SIGVTALRM
        case SIGVTALRM:
            self = .virtualTimeAlarm
#endif
#if !NO_SIGPROF
        case SIGPROF:
            self = .profilingTimerAlarm
#endif
#if !NO_SIGWINCH
        case SIGWINCH:
            self = .windowSizeChange
#endif
#if !NO_SIGINFO
        case SIGINFO:
            self = .statusRequestFromKeyboard
#endif
#if !NO_SIGUSR1
        case SIGUSR1:
            self = .userDefined1
#endif
#if !NO_SIGUSR2
        case SIGUSR2:
            self = .userDefined2
#endif
#endif // !NO_UNIX_SIGNALS
        default:
            return nil
        }
    }
}

extension Signal {
    /// The default actions a signal can take when sent to a process.
    public enum DefaultAction: Hashable, CaseIterable {
        /// Continue the process if it is stopped, otherewise ignored.
        case `continue`
        /// Abnormal termination of the process. If the OS supports creating a core file then that may occur.
        case createCoreImage
        /// Ignore the signal.
        case discardSignal
        /// Abnormal termination of the process.
        case terminateProcess
        /// Stop (not terminate) the process.
        case stopProcess
    }

    /// The default action taken when a signal is sent to a process.
    @inlinable
    public var defaultAction: DefaultAction {
        switch self {
        case .abort:
            return .createCoreImage
        case .floatingPointException:
            return .createCoreImage
        case .illegalInstruction:
            return .createCoreImage
        case .interrupt:
            return .terminateProcess
        case .segmentationViolation:
            return .createCoreImage
        case .termination:
            return .terminateProcess
#if !NO_UNIX_SIGNALS
#if !NO_SIGHUP
        case .hangUp:
            return .terminateProcess
#endif
#if !NO_SIGQUIT
        case .quit:
            return .createCoreImage
#endif
#if !NO_SIGTRAP
        case .trap:
            return .createCoreImage
#endif
#if !NO_SIGEMT
        case .emulateInstructionExecuted:
            return .createCoreImage
#endif
#if !NO_SIGKILL
        case .kill:
            return .terminateProcess
#endif
#if !NO_SIGBUS
        case .busError:
            return .createCoreImage
#endif
#if !NO_SIGSYS
        case .nonExistentSystemCallInvoked:
            return .createCoreImage
#endif
#if !NO_SIGPIPE
        case .writeOnPipeWithNoReader:
            return .terminateProcess
#endif
#if !NO_SIGALRM
        case .realtimeTimerExpired:
            return .terminateProcess
#endif
#if !NO_SIGURG
        case .urgentConditionPresentOnSocket:
            return .discardSignal
#endif
#if !NO_SIGSTOP
        case .stop:
            return .stopProcess
#endif
#if !NO_SIGTSTP
        case .stopFromKeyboard:
            return .stopProcess
#endif
#if !NO_SIGCONT
        case .continueAfterStop:
            return .continue
#endif
#if !NO_SIGCHLD
        case .childStatusChanged:
            return .discardSignal
#endif
#if !NO_SIGTTIN
        case .backgroundReadAttemptedFromControlTerminal:
            return .stopProcess
#endif
#if !NO_SIGTTOU
        case .backgroundWriteAttemptedFromControlTerminal:
            return .stopProcess
#endif
#if !NO_SIGIO
        case .ioIsPossibleOnADescriptor:
            return .discardSignal
#endif
#if !NO_SIGXCPU
        case .cpuTimeLimitExceeded:
            return .terminateProcess
#endif
#if !NO_SIGXFSZ
        case .fileSizeLimitExceeded:
            return .terminateProcess
#endif
#if !NO_SIGVTALRM
        case .virtualTimeAlarm:
            return .terminateProcess
#endif
#if !NO_SIGPROF
        case .profilingTimerAlarm:
            return .terminateProcess
#endif
#if !NO_SIGWINCH
        case .windowSizeChange:
            return .discardSignal
#endif
#if !NO_SIGINFO
        case .statusRequestFromKeyboard:
            return .discardSignal
#endif
#if !NO_SIGUSR1
        case .userDefined1:
            return .terminateProcess
#endif
#if !NO_SIGUSR2
        case .userDefined2:
            return .terminateProcess
#endif
#endif // !NO_UNIX_SIGNALS
        }
    }
}

extension Signal {
    /// If a signal can be caught.
    ///
    /// If this returns `false` then a signal handler can not catch the signal.
    @inlinable
    public var canBeCaught: Bool {
        let kill: Self?
        #if !NO_SIGKILL
        kill = .kill
        #else
        kill = nil
        #endif
        let stop: Self?
        #if !NO_SIGSTOP
        stop = .stop
        #else
        stop = nil
        #endif
        return !(self == kill || self == stop)
    }

    /// If a signal can be ignored.
    ///
    /// If this returns `false` then a process can not ignore the signal.
    @inlinable
    public var canBeIgnored: Bool {
        let kill: Self?
        #if !NO_SIGKILL
        kill = .kill
        #else
        kill = nil
        #endif
        let stop: Self?
        #if !NO_SIGSTOP
        stop = .stop
        #else
        stop = nil
        #endif
        return !(self == kill || self == stop)
    }
}

extension Signal {
    /// Signals currently pending delivery to the calling process.
    @inlinable
    public static var pending: SignalSet {
        var pending = sigset_t.emptySet()
        sigpending(&pending)
        return SignalSet(pending)
    }
}

// MARK: - Other Extensions
extension Sequence where Element == Signal {
    /// Create a `sigset_t` representation of the `Seqeunce`.
    @usableFromInline
    var sigset: sigset_t {
        var set = sigset_t.emptySet()
        for signal in self {
            sigaddset(&set, signal.rawValue)
        }
        return set
    }
}
