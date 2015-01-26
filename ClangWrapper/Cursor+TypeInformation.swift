//
//  Cursor+TypeInformation.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/26.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	public var type:Type {
		get {
			let	r	=	clang_getCursorType(raw)
			return	Type(index: index, raw: r)
		}
	}
	public var typedefDeclarationUnderlyingType:Type {
		get {
			let	r	=	clang_getTypedefDeclUnderlyingType(raw)
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
	public var fieldDeclarationBitWidth:Int {
		get {
			let	r	=	clang_getFieldDeclBitWidth(raw)
			return	Int(r)
		}
	}
	///	Composition of `clang_Cursor_getArgument` and `clang_Cursor_getNumArguments`.
	///	`clang_Cursor_getArgument`: Retrieve the number of non-variadic arguments associated with a given cursor.
	///	`clang_Cursor_getNumArguments`: Retrieve the argument cursor of a function or method.
	public var argumentCursors:[Cursor] {
		get {
			let	mk	=	{ i in Cursor(index: self.index, raw: clang_Cursor_getArgument(self.raw, i)) }
			let	r	=	clang_Cursor_getNumArguments(raw)
			precondition(r != -1)
			
			let	n	=	UInt32(r)
			return	(0..<n).map(mk)
		}
	}
	public var resultType:Type {
		get {
			let	r	=	clang_getCursorResultType(raw)
			return	Type(index: index, raw: r)
		}
	}
	
	///	`clang_Cursor_isBitField`: Returns non-zero if the cursor specifies a Record member that is a bitfield.
	public var isBitField:Bool {
		get {
			let	r	=	clang_Cursor_isBitField(raw)
			return	r != 0
		}
	}
	
	//	Prefixed with module name to avoid compiler crash.
	public var CXXAccessSpecifier:ClangWrapper.CXXAccessSpecifier {
		get {
			let	r	=	clang_getCXXAccessSpecifier(raw)
			return	ClangWrapper.CXXAccessSpecifier(raw: r)
		}
	}
	
	///	Composition of `clang_getNumOverloadedDecls` and `clang_getOverloadedDecl`.
	///	`clang_getNumOverloadedDecls`: Determine the number of overloaded declarations referenced by a CXCursor_OverloadedDeclRef cursor.
	///	`clang_getOverloadedDecl`: Retrieve a cursor for one of the overloaded declarations referenced by a CXCursor_OverloadedDeclRef cursor.
	public var overloadedDeclaraions:[Cursor] {
		get {
			let	n	=	clang_getNumOverloadedDecls(raw)
			let	a	=	(0..<n).map({ (idx:UInt32)->Cursor in
				let	r	=	clang_getOverloadedDecl(self.raw, idx)
				return	Cursor(index: self.index, raw: r)
			})
			return	a
		}
	}
}






