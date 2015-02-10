//
//  TranslationUnit+Tokenization.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



public extension TranslationUnit {
	public func tokenize(range:SourceRange) -> TokenSequence {
		var	tkrawptr	=	nil as UnsafeMutablePointer<CXToken>
		var	tkrawcount	=	0 as UInt32
		clang_tokenize(raw, range.raw, &tkrawptr, &tkrawcount)
		return	TokenSequence(index: index, rawtu: raw, rawptr: tkrawptr, rawcount: tkrawcount)
	}
//	public func annotateTokens(tokens:TokenSequence, cursors:[Cursor]) {
//	}
}