//
//  CursorKind+RawConversion.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



extension CursorKind {
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
	return	CursorKind(rawValue: raw.value)!
}