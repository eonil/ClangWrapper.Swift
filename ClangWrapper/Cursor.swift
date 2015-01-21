//
//  Cursor.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public struct Cursor {
	public func visitChildrenWithBlock(block:(cursor:Cursor, parent:Cursor)->ChildVisitResult) {
		let	r	=	clang_visitChildrenWithBlock(raw) { (cursor:CXCursor, parent:CXCursor) -> CXChildVisitResult in
			let	r1	=	block(cursor: Cursor(raw: cursor), parent: Cursor(raw: parent))
			
			return	r1.raw
		}
	}
	public var kind:CursorKind {
		get {
			let	r	=	clang_getCursorKind(raw)
			return	CursorKind(rawValue: r.value)!
		}
	}
	public var extent:SourceRange {
		get {
			let	r	=	clang_getCursorExtent(raw);
			return	SourceRange(raw: r)
		}
	}
	public var spelling:String {
		get {
			let	s	=	clang_getCursorSpelling(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
	
	////
	
	let	raw:CXCursor
	
	init(raw: CXCursor) {
		self.raw	=	raw
	}
}

