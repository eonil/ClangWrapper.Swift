//
//  Cursor+Iteration.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	///	This copied all direct children cursors into an array.
	public var children:[Cursor] {
		get {
			var	cs	=	[] as [Cursor]
			self.visitChildrenWithBlock { (cursor, parent) -> ChildVisitResult in
				cs.append(cursor)
				return	ChildVisitResult.Continue
			}
			return	cs
		}
	}
}

