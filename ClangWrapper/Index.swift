//
//  Index.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//




public final class Index {
	public init(excludeDeclarationsFromPCH: Bool, displayDiagnostics: Bool) {
		raw	=	clang_createIndex(excludeDeclarationsFromPCH ? 1 : 0, displayDiagnostics ? 1 : 0)
	}
	deinit {
		allTranslationUnits.killAll()
		allDiagnostics.killAll()
		allTokenSequences.killAll()
		clang_disposeIndex(raw)
		debugLog("clang_disposeIndex")
	}
	
	public func parseTranslationUnit(sourceFilename:String) -> TranslationUnit {
		let	tuptr	=	sourceFilename.withCString { [unowned self](p:UnsafePointer<Int8>) -> CXTranslationUnit in
			return	clang_parseTranslationUnit(self.raw, p, nil, 0, nil, 0, 0)
		}
		return	TranslationUnit(index: UnmanagedIndexRef(self), raw: tuptr)
	}
	public func parseTranslationUnit(sourceFilename:String, commandLineArguments:[String]) -> TranslationUnit {
		var	tuptr	=	CXTranslationUnit()
		withCPointerToNullTerminatingCArrayOfCStrings(commandLineArguments, { (pArgs:UnsafePointer<UnsafeMutablePointer<Int8>>) -> () in
			let	pArgs1	=	UnsafePointer<UnsafePointer<Int8>>(pArgs)
			tuptr	=	sourceFilename.withCString { (pFilename:UnsafePointer<Int8>) -> CXTranslationUnit in
				return	clang_parseTranslationUnit(self.raw, pFilename, pArgs1, Int32(commandLineArguments.count), nil, 0, 0)
			}
		})
		
		return	TranslationUnit(index: UnmanagedIndexRef(self), raw: tuptr)
	}
	
	////
	
	let	raw:CXIndex
	
	let	allTranslationUnits	=	RemotePointerTracker<TranslationUnit>()
	let	allDiagnostics		=	RemotePointerTracker<Diagnostic>()
	let	allTokenSequences	=	RemotePointerTracker<TokenSequence>()
}



struct UnmanagedIndexRef {
	let	ref:Unmanaged<Index>
	
	init(_ index:Index) {
		self.ref	=	Unmanaged.passUnretained(index)
	}
	var	allTranslationUnits:RemotePointerTracker<TranslationUnit> {
		get {
			return	ref.takeUnretainedValue().allTranslationUnits
		}
	}
	var	allDiagnostics:RemotePointerTracker<Diagnostic> {
		get {
			return	ref.takeUnretainedValue().allDiagnostics
		}
	}
	var	allTokenSequences:RemotePointerTracker<TokenSequence> {
		get {
			return	ref.takeUnretainedValue().allTokenSequences
		}
	}
}












