//
//  Cursor.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public struct Cursor {
	///	Returns the translation unit that a cursor originated from.
	public var translationUnit:TranslationUnit {
		get {
			let	r	=	clang_Cursor_getTranslationUnit(raw)
			return	TranslationUnit(index: index, raw: r)
		}
	}
	public func visitChildrenWithBlock(block:(cursor:Cursor, parent:Cursor)->ChildVisitResult) {
		let	r	=	clang_visitChildrenWithBlock(raw) { (cursor:CXCursor, parent:CXCursor) -> CXChildVisitResult in
			let	r1	=	block(cursor: Cursor(index: self.index, raw: cursor), parent: Cursor(index: self.index, raw: parent))
			
			return	r1.raw
		}
	}
	public var kind:CursorKind {
		get {
			let	r	=	clang_getCursorKind(raw)
			return	CursorKind(raw: r)
		}
	}
	public var type:Type {
		get {
			let	r	=	clang_getCursorType(raw)
			return	Type(index: index, raw: r)
		}
	}
	public var enumDeclarationIntegerType:Type {
		get {
			let	r	=	clang_getEnumDeclIntegerType(raw)
			return	Type(index: index, raw: r)
		}
	}
	public var enumConstantDeclarationValue:Int64 {
		get {
			return	clang_getEnumConstantDeclValue(raw)
		}
	}
	public var enumConstantDeclarationUnsignedValue:UInt64 {
		get {
			return	clang_getEnumConstantDeclUnsignedValue(raw)
		}
	}
	public var argumentCursors:[Cursor] {
		get {
			let	mk	=	{ i in Cursor(index: self.index, raw: clang_Cursor_getArgument(self.raw, i)) }
			let	n	=	UInt32(clang_Cursor_getNumArguments(raw))
			return	(0..<n).map(mk)
		}
	}
	public var resultType:Type {
		get {
			let	r	=	clang_getCursorResultType(raw)
			return	Type(index: index, raw: r)
		}
	}
	
	public var extent:SourceRange {
		get {
			let	r	=	clang_getCursorExtent(raw);
			return	SourceRange(raw: r)
		}
	}
	
	//	Prefixed with module name to avoid compiler crash.
	public var CXXAccessSpecifier:ClangWrapper.CXXAccessSpecifier {
		get {
			let	r	=	clang_getCXXAccessSpecifier(raw)
			return	ClangWrapper.CXXAccessSpecifier(raw: r)
		}
	}

	////
	
	let	index:UnmanagedIndexRef
	let	raw:CXCursor
	
	init(index:UnmanagedIndexRef, raw: CXCursor) {
		self.index	=	index
		self.raw	=	raw
	}
}





