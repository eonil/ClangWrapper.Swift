//
//  CursorKind+RawConversion.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



extension CursorKind {
	static func fromRaw(raw r:CXCursorKind) -> CursorKind {
		return	self.init(raw: r)
	}
	
	///	Doesn't work well in Swift 1.2. 
	///	Use `fromRaw` instead of.
	init(raw: CXCursorKind) {
		self	=	fromRaw(raw)
	}
	var raw:CXCursorKind {
		get {
			return	CXCursorKind(self.rawValue)
		}
	}
}








//	I don't know why, but compiler cannot compile if this is in the constructor.
private func fromRaw(raw:CXCursorKind) -> CursorKind {
	return	CursorKind(rawValue: raw.rawValue)!
}