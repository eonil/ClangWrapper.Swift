//
//  Diagnostic.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


public struct Diagnostic: TrackableRemoteObjectProxy {
	public var location:SourceLocation {
		get {
			let	ptr	=	clang_getDiagnosticLocation(raw)
			return	SourceLocation(raw: ptr)
		}
	}
	public func dispose() {
		index.allDiagnostics.untrack(self)
		clang_disposeDiagnostic(raw)
		debugLog("clang_disposeDiagnostic")
	}
	
	public var spelling:String {
		get {
			let	s	=	clang_getDiagnosticSpelling(raw);
			let	s1	=	toSwiftString(s, true)
			return	s1!
		}
	}
	
	////
	
	let index:UnmanagedIndexRef
	let	raw:CXDiagnostic
	
	init(index:UnmanagedIndexRef, raw:CXDiagnostic) {
		self.index	=	index
		self.raw	=	raw
		
		index.allDiagnostics.track(self)
	}
}

