//
//  Cursor+CrossReferencing.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	///	Retrieve a name for the entity referenced by this cursor.
	public var spelling:String {
		get {
			let	s	=	clang_getCursorSpelling(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1!
		}
	}
	
	///	Retrieve the display name for the entity referenced by this cursor.
	public var displayName:String? {
		get {
			let	s	=	clang_getCursorDisplayName(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
	
	///	For a cursor that is a reference, retrieve a cursor representing the entity that it references.
	public var referenced:Cursor {
		get {
			let	r	=	clang_getCursorReferenced(raw)
			return	Cursor(index: index, raw: r)
		}
	}
	///	For a cursor that is either a reference to or a declaration of some entity, retrieve a cursor that describes the definition of that entity.
	public var definition:Cursor {
		get {
			let	r	=	clang_getCursorDefinition(raw)
			return	Cursor(index: index, raw: r)
		}
	}
	///	Determine whether the declaration pointed to by this cursor is also a definition of that entity. 
	public var isDefinition:Bool {
		get {
			let	r	=	clang_isCursorDefinition(raw)
			return	r != 0
		}
	}
	///	Retrieve the canonical cursor corresponding to the given cursor.
	public var canonicalCursor:Cursor {
		get {
			let	r	=	clang_getCanonicalCursor(raw)
			return	Cursor(index: index, raw: r)
		}
	}
	
	
	
	public var commentRange:SourceRange {
		get {
			let	r	=	clang_Cursor_getCommentRange(raw)
			return	SourceRange(raw: r)
		}
	}
	public var rawCommentText:String? {
		get {
			let	s	=	clang_Cursor_getRawCommentText(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
	public var briefCommentText:String? {
		get {
			let	s	=	clang_Cursor_getBriefCommentText(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
}