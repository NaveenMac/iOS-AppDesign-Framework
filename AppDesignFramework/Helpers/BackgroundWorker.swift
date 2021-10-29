//
//  BackgroundWorker.swift
//  FileManager
//
//  Created by Naveen Chauhan on 26/10/21.
//

import Foundation

class BackgroundWorker: NSObject {
  private var thread: Thread!
  private var block: (()->Void)!

    @objc internal func runBlock() { block() }

  internal func start(_ block: @escaping () -> Void) {
    self.block = block

    let threadName = String(describing: self)
      .components(separatedBy: .punctuationCharacters)[1]

    thread = Thread { [weak self] in
      while (self != nil && !self!.thread.isCancelled) {
        RunLoop.current.run(
            mode: RunLoop.Mode.default,
          before: Date.distantFuture)
      }
      Thread.exit()
    }
    thread.name = "\(threadName)-\(UUID().uuidString)"
    thread.start()

    perform(#selector(runBlock),
      on: thread,
      with: nil,
      waitUntilDone: false,
      modes: [RunLoop.Mode.default.rawValue])
  }

  public func stop() {
    thread.cancel()
  }
}
