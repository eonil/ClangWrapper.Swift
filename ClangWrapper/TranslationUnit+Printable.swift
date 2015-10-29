//
//  TranslationUnit+Printable.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



extension TranslationUnit: CustomStringConvertible {
	public var description:String {
		get {
			var	s	=	""
			runOverChildrenOf(cursor, 0, &s)
			return	s
		}
	}
}









private func runOverChildrenOf<O:OutputStreamType>(c:Cursor, _ depth:Int, inout _ s:O) {
	let	indent	=	Repeat(count: depth, repeatedValue: "  ").joinWithSeparator("")
	let	desc	=	c.description
	s.write("\(indent)\(desc)")
	s.write("\n")
	
	c.visitChildrenWithBlock { (cursor, parent) -> ChildVisitResult in
		runOverChildrenOf(cursor, depth+1, &s)
		return	ChildVisitResult.Continue
	}
}


