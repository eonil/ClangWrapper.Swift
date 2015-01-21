//
//  SourceLocation.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


public struct SourceLocation {
	
	public var spelling:(line:UInt32, column:UInt32) {
		get {
			var	line:UInt32		=	UInt32.max
			var	column:UInt32	=	UInt32.max
			clang_getSpellingLocation(raw, nil, &line, &column, nil)
			return	(line, column)
		}
	}
	
	////
	
	let	raw:CXSourceLocation
	
	init(raw: CXSourceLocation) {
		self.raw	=	raw
	}
}

public struct SourceRange {
	public var start:SourceLocation {
		get {
			return	SourceLocation(raw: clang_getRangeStart(raw))
		}
	}
	public var end:SourceLocation {
		get {
			return	SourceLocation(raw: clang_getRangeEnd(raw))
		}
	}
	
	////
	
	let	raw:CXSourceRange
	
	init(raw: CXSourceRange) {
		self.raw	=	raw
	}
}



