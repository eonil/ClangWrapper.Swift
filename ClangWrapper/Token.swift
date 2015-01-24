//
//  Token.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//




public struct Token {
	public var kind:TokenKind {
		get {
			let	r	=	clang_getTokenKind(raw)
			return	TokenKind(raw: r)
		}
	}
	public var spelling:String {
		get {
			let	s	=	clang_getTokenSpelling(sequence.rawtu, raw)
			let	s1	=	toSwiftString(s, true)
			return	s1!
		}
	}
	public var location:SourceLocation {
		get {
			let	r	=	clang_getTokenLocation(sequence.rawtu, raw)
			return	SourceLocation(raw: r)
		}
	}
	public var extent:SourceRange {
		get {
			let	r	=	clang_getTokenExtent(sequence.rawtu, raw)
			return	SourceRange(raw: r)
		}
	}
	
	////
	
	let sequence:TokenSequence
	let index:Int
	
	var raw:CXToken {
		get {
			return	sequence.rawptr[index]
		}
	}
}







