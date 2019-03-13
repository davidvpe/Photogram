//
//  ConcurrentOperation.swift
//  PhotoStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

public

class ConcurrentOperation: Operation {
	
	private var _executing = false
	private var _finished = false
	public var father: Operation?
	
	override public func addDependency(_ op: Operation) {
		if let concurrent = op as? ConcurrentOperation {
			concurrent.father = self
		}
	}
	
	public override var isReady: Bool {
		for dependency in self.dependencies where !dependency.isFinished {
			return false
		}
		return true
	}
	
	override public func start() {
		if isCancelled {
			finish()
			return
		}
		
		willChangeValue(forKey: "isExecuting")
		_executing = false
		didChangeValue(forKey: "isExecuting")
		
		main()
	}
	
	func finish() {
		willChangeValue(forKey: "isExecuting")
		willChangeValue(forKey: "isFinished")
		_executing = false
		_finished = true
		didChangeValue(forKey: "isExecuting")
		didChangeValue(forKey: "isFinished")
	}
	
	override public var isExecuting: Bool {
		return _executing
	}
	
	override public var isFinished: Bool {
		return _finished
	}
	
	override public func cancel() {
		super.cancel()
		
		father?.cancel()
		
		finish()
	}
	
}
