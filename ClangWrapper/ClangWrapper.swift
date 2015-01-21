//
//  ClangWrapper.swift
//  libclang_example1
//
//  Created by Hoon H. on 2015/01/20.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


//	https://www.mikeash.com/pyblog/friday-qa-2014-01-24-introduction-to-libclang.html








public final class Index {
	public init(excludeDeclarationsFromPCH: Bool, displayDiagnostics: Bool) {
		_raw	=	clang_createIndex(excludeDeclarationsFromPCH ? 1 : 0, displayDiagnostics ? 1 : 0)
	}
	deinit {
		clang_disposeIndex(_raw)
	}
	
	public func parseTranslationUnit(sourceFilename:String) -> TranslationUnit {
		let	tuptr	=	sourceFilename.withCString { [unowned self](p:UnsafePointer<Int8>) -> CXTranslationUnit in
			return	clang_parseTranslationUnit(self._raw, p, nil, 0, nil, 0, 0)
		}
		return	TranslationUnit(raw: tuptr)
	}
	
	////
	
	private let	_raw:CXIndex
}



public final class TranslationUnit {
	private init(raw:CXTranslationUnit) {
		self._raw	=	raw
	}
	public init(index:Index, astFilename:String) {
		_raw	=
			astFilename.withCString { (p:UnsafePointer<Int8>) -> CXTranslationUnit in
				return	clang_createTranslationUnit(index._raw, p)
			}
	}
	deinit {
		clang_disposeTranslationUnit(_raw);
	}
	
	public var cursor:Cursor {
		get {
			return	Cursor(raw: clang_getTranslationUnitCursor(_raw))
		}
	}
	
	////
	
	public var numberOfDiagnostics:UInt32 {
		get {
			return	clang_getNumDiagnostics(_raw)
		}
	}
	public func diagnosticAtIndex(index:UInt32) -> Diagnostic {
		let	dptr	=	clang_getDiagnostic(_raw, index)
		return	Diagnostic(raw: dptr)
	}
	
	////
	
	private let	_raw:CXTranslationUnit
}
extension TranslationUnit {
	public var diagnostics:[Diagnostic] {
		get {
			return	(0..<numberOfDiagnostics).map { [unowned self] i in
				return	self.diagnosticAtIndex(i)
			}
		}
	}
}








public final class Diagnostic {
	
	public var location:SourceLocation {
		get {
			let	ptr	=	clang_getDiagnosticLocation(_raw)
			return	SourceLocation(raw: ptr)
		}
	}
	deinit {
		clang_disposeDiagnostic(_raw)
	}
	
	public var spelling:String {
		get {
			let	s	=	clang_getDiagnosticSpelling(_raw);
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
	
	////
	
	private let	_raw:CXDiagnostic
	
	private init(raw:CXDiagnostic) {
		self._raw	=	raw
	}
}







public final class File {
//	public init() {
//	}
	deinit {
//		clang_dispose
	}
	
	public var name:String {
		get {
			let	s	=	clang_getFileName(_raw);
			let	s1	=	toSwiftString(s, true)
			return	s1
		}
	}
	
	////
	
	private let	_raw:CXFile
	
	private init(raw: CXFile) {
		self._raw	=	raw
	}
}















































