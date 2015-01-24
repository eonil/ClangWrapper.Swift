//
//  CursorKind+Query.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



public extension CursorKind {
	public var isDeclaration:Bool {
		get {
			let	r	=	clang_isDeclaration(raw)
			return	r != 0
		}
	}
	public var isReference:Bool {
		get {
			let	r	=	clang_isReference(raw)
			return	r != 0
		}
	}
	public var isExpression:Bool {
		get {
			let	r	=	clang_isExpression(raw)
			return	r != 0
		}
	}
	public var isStatement:Bool {
		get {
			let	r	=	clang_isStatement(raw)
			return	r != 0
		}
	}
	public var isAttribute:Bool {
		get {
			let	r	=	clang_isAttribute(raw)
			return	r != 0
		}
	}
	public var isInvalid:Bool {
		get {
			let	r	=	clang_isInvalid(raw)
			return	r != 0
		}
	}
	public var isTranslationUnit:Bool {
		get {
			let	r	=	clang_isTranslationUnit(raw)
			return	r != 0
		}
	}
	public var isPreprocessing:Bool {
		get {
			let	r	=	clang_isPreprocessing(raw)
			return	r != 0
		}
	}
	public var isUnexposed:Bool {
		get {
			let	r	=	clang_isUnexposed(raw)
			return	r != 0
		}
	}
}