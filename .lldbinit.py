import lldb

def __lldb_init_module(debugger, internal_dict):
    print("Loading Signal Passing")
    signals = [
        "SIGABRT",
        "SIGFPE",
        "SIGILL",
        "SIGINT",
        "SIGSEGV",
        "SIGTERM",
        "SIGHUP",
        "SIGQUIT",
        "SIGTRAP",
        "SIGEMT",
        "SIGKILL",
        "SIGBUS",
        "SIGSYS",
        "SIGPIPE",
        "SIGALRM",
        "SIGURG",
        "SIGSTOP",
        "SIGTSTP",
        "SIGCONT",
        "SIGCHLD",
        "SIGTTIN",
        "SIGTTOU",
        "SIGIO",
        "SIGXCPU",
        "SIGXFSZ",
        "SIGVTALRM",
        "SIGPROF",
        "SIGWINCH",
        "SIGINFO",
        "SIGUSR1",
        "SIGUSR2",
    ]
    for signal in signals:
        command = "process handle {} --pass true --stop false".format(signal)
        debugger.HandleCommand(command)
