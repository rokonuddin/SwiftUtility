//: Playground - noun: a place where people can play

import UIKit

struct Throttle {
    static func onQueue(queue: OperationQueue, by timeInterval: TimeInterval, function: @escaping () -> ()) {
        queue.cancelAllOperations()
        
        let delayOperation = DelayOperation(timeInterval: timeInterval)
        
        let throttledOperation = BlockOperation() {
            function()
        }
        
        throttledOperation.addDependency(delayOperation)
        queue.addOperations([delayOperation, throttledOperation], waitUntilFinished: false)
    }
}

class DelayOperation: Operation {
    private let timeInterval: TimeInterval
    
    override var isAsynchronous: Bool {
        get {
            return true
        }
    }
    
    
    private var _executing: Bool = false
    override var isExecuting: Bool {
        get {return _executing}
        
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
            
            if _cancelled == true {
                self.isFinished = true
            }
        }
    }
    
    private var _finished: Bool = false
    override var isFinished: Bool {
        get { return _finished}
        
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _cancelled: Bool = false
    
    override var isCancelled: Bool {
        get {return _cancelled}
        set {
            willChangeValue(forKey: "isCancelled")
            _cancelled = newValue
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    override func start() {
        super.start()
        self.isExecuting = true
    }
    
    override func main() {
        if isCancelled {
            isExecuting = false
            isFinished = true
            return
        }
        
        let when =  DispatchTime.now() + timeInterval
        DispatchQueue.global().asyncAfter(deadline: when) { 
            self.isFinished = true
            self.isExecuting = true
        }
        
    }
    
    override func cancel() {
        super.cancel()
        
        isCancelled = true
        
        if isExecuting {
            isExecuting = false
            isFinished = true
        }
    }
    
    
}


class Usage {
    
    func doSmething() {
        let globalQueue = OperationQueue()
        Throttle.onQueue(queue: globalQueue, by: 0.2) { 
            
        }
    }
}
