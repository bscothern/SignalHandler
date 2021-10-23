@testable import SignalHandler
import XCTest

final class SignalHandlerTests: XCTestCase {
    let excludedSignals: Set<Signal> = [
        .abort
    ]
    
    func testCanCatchSignals() {
        var caught: Set<Signal> = []
        let expected = Set(
            Signal.allCases.lazy
                .filter(\.canBeCaught)
//                .filter { !self.excludedSignals.contains($0) }
        )

        for signal in expected {
            Signals.handle(signal) { signal in
                caught.insert(signal)
            }
            
            Signals.raise(signal)

            Signals.restoreDefaultAction(for: signal)
        }
        
        XCTAssertEqual(caught, expected)
    }
}
