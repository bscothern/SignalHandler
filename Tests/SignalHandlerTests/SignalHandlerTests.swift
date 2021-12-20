@testable import SignalHandler
import XCTest

final class SignalHandlerTests: XCTestCase {
    func testCanCatchSignals() {
        var caught: Set<Signal> = .init(minimumCapacity: Signal.allCases.count)
        let expected = Set(
            Signal.allCases.lazy
                .filter(\.canBeCaught)
        )

        for signal in expected {
            Signals.handle(signal) { signal in
                caught.insert(signal)
            }
            defer {
                Signals.restoreDefaultAction(for: signal)
            }

            Signals.raise(signal)
        }

        XCTAssertEqual(caught, expected)
    }

    func testCanIgnoreSignals() {
        var caught: Set<Signal> = .init(minimumCapacity: Signal.allCases.count)
        let ignorable = Set(
            Signal.allCases.lazy
                .filter(\.canBeIgnored)
        )

        for signal in ignorable {
            Signals.handle(signal) { signal in
                caught.insert(signal)
            }
            defer {
                Signals.restoreDefaultAction(for: signal)
            }

            Signals.ignore(signal)
        }
    }
}
