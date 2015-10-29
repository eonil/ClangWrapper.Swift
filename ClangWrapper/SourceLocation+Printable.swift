//
//  SourceLocation+Printable.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



extension SourceLocation: CustomStringConvertible {
	public var description:String {
		get {
			let	s	=	spelling
			return	"\(s.line):\(s.column)"
		}
	}
}

extension SourceRange: CustomStringConvertible {
	public var description:String {
		get {
			return	"\(start)~\(end)"
		}
	}
}