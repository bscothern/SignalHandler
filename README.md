# SignalHandler

Adds support for signal handlers in a fully swifty way.

## Why this over raw signal handling or other packages.

Signal handler functions are part of the C language standard.
This means that all of them that take a function pointer are `@convention(c)` so you cannot use typical swift closure syntax as you would normally expect.
They instead become limited to only accessing global scope.
This library takes that limitation away and lets you fully use swift closures and capture variables.

This library also takes inspiration from [SwiftSystem](https://github.com/apple/swift-system) and does its best to move away from the C names as much as possible to follow swift naming guidelines.
For convenience the C names have been implimneted with unavailable annotations that direct you to the new more descriptive names.

## Configuring Signals
The C language standard only defines 6 signals.
Most other common ones are part of the UNIX.
So this library has been configured in such a way that you can build it with or without the common UNIX signals by building with different environment variables.

If you set the `NO_UNIX_SIGNALS` environment variable then all non C signals will be disabled.
To turn off one signal define `NO_<SIGNAL_C_NAME>` and it will be disabled.
You can specify any number of signals to turn off in this manner.

## Debugging Signal Handlers with LLDB

When a process receives a signal as lldb is running it then by default captures the signal.
To change this behavior you need to run the following command when you begin execution of your app.

```bash
process handle <SIGNAL_C_NAME> --pass true --stop false
```

This will then cause the signal to be passed on to the process you are debugging.
If you are potentially debugging multiple signals then you should run this command for each of them.
Because this can be tedious and obnoxious to run at the start of each run of your app, in Xcode you can do the following to help simplify the process.

1) Create a breakpoint at the start of your app's execution. This should be a line that does work not just a declaration otherwise it will typically not run.
2) Right click on the breakpoint.
3) Select 'Edit Breakpoint...'.
4) Click 'Add Action'.
5) Ensure it is set to 'Debugger Command'.
6) Put the lldb command from above into the text box.
7) If you have other signals to catch hit the + and repeat steps 5-7 until you have set up all signals you care about.
8) Check the Option box 'Automatically continue after evaluating actions'.

Now as you launch the app in the debugger it will automatically set the signals up for delivery each time as long as the breakpoint is active.
