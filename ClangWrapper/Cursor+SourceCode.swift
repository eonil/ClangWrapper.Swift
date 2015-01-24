//
//  Cursor+SourceCode.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//





public extension Cursor {
	public var sourceCode:String {
		get {
			return	stringOfRange(translationUnit, extent)
		}
	}
}

private func stringOfRange(unit:TranslationUnit, range:SourceRange) -> String {
	var	a		=	[] as [String]
	let	tkseq	=	unit.tokenize(range)
	for tk in tkseq {
		a.append(tk.spelling)
	}
	return	join(" ", a)
}

