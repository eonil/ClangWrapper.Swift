//
//  TranslationUnit.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//




public struct TranslationUnit: TrackableRemoteObjectProxy {
	public func dispose() {
		index.allTranslationUnits.untrack(self)
		clang_disposeTranslationUnit(raw)
		debugLog("clang_disposeTranslationUnit")
	}
	
	///	Eonil:
	///	`TranslationUnit.cursor.spelling` returns file path of the unit.
	public var cursor:Cursor {
		get {
			return	Cursor(index: index, raw: clang_getTranslationUnitCursor(raw))
		}
	}
	
	////
	
	public var numberOfDiagnostics:UInt32 {
		get {
			return	clang_getNumDiagnostics(raw)
		}
	}
	public func diagnosticAtIndex(index:UInt32) -> Diagnostic {
		let	dptr	=	clang_getDiagnostic(raw, index)
		return	Diagnostic(index: self.index, raw: dptr)
	}
	
	////
	
	let	index:UnmanagedIndexRef
	let	raw:CXTranslationUnit
	
	init(index:UnmanagedIndexRef, raw:CXTranslationUnit) {
		self.index	=	index
		self.raw	=	raw
		
		index.allTranslationUnits.track(self)
	}
}
extension TranslationUnit {
	public var diagnostics:[Diagnostic] {
		get {
			return	(0..<numberOfDiagnostics).map { i in
				return	self.diagnosticAtIndex(i)
			}
		}
	}
}









