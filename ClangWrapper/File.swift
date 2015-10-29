//
//  File.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//





public struct File {
	public var name:String {
		get {
			let	s	=	clang_getFileName(raw);
			let	s1	=	toSwiftString(s, disposeCXString: true)
			return	s1!
		}
	}
	
	////
	
	let	raw:CXFile
	
	init(raw: CXFile) {
		self.raw	=	raw
	}
}




