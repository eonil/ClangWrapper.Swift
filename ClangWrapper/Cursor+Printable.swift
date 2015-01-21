//
//  Cursor+Printable.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	public var description:String {
		get {
			var	s	=	""
			runOverChildrenOf(self, 0, &s)
			return	s
		}
	}
}













private func runOverChildrenOf<O:OutputStreamType>(c:Cursor, depth:Int, inout s:O) {
	c.visitChildrenWithBlock { (cursor, parent) -> ChildVisitResult in
		let	indent	=	join("", Repeat(count: depth, repeatedValue: "  "))
		s.write("\(indent)\(cursor.spelling) (\(cursor.kind), \(c.extent))")
		s.write("\n")
		runOverChildrenOf(cursor, depth+1, &s)
		return	ChildVisitResult.Continue
	}
}





