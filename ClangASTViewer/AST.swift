//
//  AST.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/24.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation
import ClangWrapper





enum ASTNodeField {
	case Spelling
	case Extent
	case Kind
	case Description
}

class ASTNode {
	var	name:String		=	""
	init() {
	}
	
	func textForField(f:ASTNodeField) -> String {
		return	""
	}
}










class ASTRootNode: ASTNode {
	var	translationUnitChildNodes:[TranslationUnitNode]	=	[]
	
	override init() {
		super.init()
		name	=	"(Root)"
	}
}

class TranslationUnitNode: ASTNode {
	let	translationUnitData:TranslationUnit
	let	cursorNode:CursorNode
	
	init(_ translationUnit:TranslationUnit) {
		self.translationUnitData	=	translationUnit
		cursorNode				=	CursorNode(translationUnitData.cursor, "[C] cursor")
		
		super.init()
		self.name	=	"[U] (TranslationUnit)"
	}
}

class CursorNode: ASTNode {
	let	cursorData:Cursor
	lazy var lazyData:LazyData	=	LazyData(self.cursorData)
	
	init(_ data:Cursor, _ name:String) {
		self.cursorData			=	data
		
		super.init()
		self.name	=	name
	}
	
	struct LazyData {
		let	typeNode:TypeNode
		let	childCursorNodes:[CursorNode]		=	[]
		let	argumentCursorNodes:[CursorNode]	=	[]
		
		init(_ data:Cursor) {			
			self.typeNode			=	TypeNode(data.type)
			typeNode.name			=	"[T] type"
			
			////
			
			for i in 0..<data.children.count {
				let	c1		=	data.children[i]
				let	cn1		=	CursorNode(c1, "[C] \(c1.spelling)")
//				cn1.name	=	"children[\(i)] \(c1.spelling)"
				childCursorNodes.append(cn1)
			}
			
//			if data.kind == CursorKind.FunctionDecl || data.kind == CursorKind.CXXMethod {
//				for i in 0..<data.argumentCursors.count {
//					let	c1		=	data.argumentCursors[i]
//					let	cn1		=	CursorNode(c1, "[C] \(c1.spelling)")
//					argumentCursorNodes.append(cn1)
//				}
//			}
		}
	}
	
	override func textForField(f: ASTNodeField) -> String {
		switch f {
		case .Spelling:		return	cursorData.spelling
		case .Extent:		return	cursorData.extent.description
		case .Kind:			return	cursorData.kind.description
		case .Description:	return	cursorData.description
		default:			return	""
		}
	}
}




class TypeNode: ASTNode {
	let	typeData:Type
	lazy var lazyData:LazyData	=	LazyData(self.typeData)
	
	init(_ data:Type, _ name:String = "") {
		self.typeData					=	data
		
		super.init()
		self.name	=	name
	}
	
	struct LazyData {
		let	declarationCursorLinkNode:CursorLinkNode
		
		///	For function types.
		let	resultTypeNode:TypeNode?
		let	argumentTypeNodes:[TypeNode]?
		
		///	For point/reference types.
		let	pointeeTypeNode:TypeNode?
			
		init(_ data:Type) {
			let	invalid	=	data.kind == TypeKind.Invalid
			
			declarationCursorLinkNode	=	CursorLinkNode(data.declaration, "[@C] declaration")
			
			if data.kind == TypeKind.FunctionProto {
				resultTypeNode		=	invalid ? nil : TypeNode(data.resultType, "[T] resultType")
				argumentTypeNodes	=	[]
				println(data.kind.description)
				for i in 0..<data.argumentTypes.count {
					let	t	=	data.argumentTypes[i]
					argumentTypeNodes!.append(TypeNode(t,"[T] argumentTypes[\(i)]"))
				}
			}
			
			if data.kind == TypeKind.Pointer {
				pointeeTypeNode	=	TypeNode(data.pointeeType, "[T] pointeeType")
			}
			if data.kind == TypeKind.LValueReference {
				pointeeTypeNode	=	TypeNode(data.pointeeType, "[T] pointeeType")
			}
			if data.kind == TypeKind.RValueReference {
				pointeeTypeNode	=	TypeNode(data.pointeeType, "[T] pointeeType")
			}
		}
	}
	override func textForField(f: ASTNodeField) -> String {
		switch f {
		case .Spelling:		return	typeData.spelling
		case .Kind:			return	typeData.kind.description
		case .Description:	return	typeData.description
		default:			return	""
		}
	}
}


class CursorLinkNode: ASTNode {
	let	cursorData:Cursor
	
	init(_ data:Cursor, _ name:String) {
		self.cursorData	=	data
		
		super.init()
		self.name		=	name
	}
	override func textForField(f: ASTNodeField) -> String {
		switch f {
		case .Spelling:		return	cursorData.spelling
		case .Extent:		return	cursorData.extent.description
		case .Kind:			return	cursorData.kind.description
		case .Description:	return	cursorData.description
		default:			return	""
		}
	}
}























@objc
protocol ASTNodeNavigation {
	var	name:String { get }
	var	description:String { get }
	var	allChildNodes:[ASTNodeNavigation] { get }
}
extension ASTRootNode: ASTNodeNavigation {
	var description:String {
		get {
			return	""
		}
	}
	var	allChildNodes:[ASTNodeNavigation] {
		get {
			return	translationUnitChildNodes
		}
	}
}
extension TranslationUnitNode: ASTNodeNavigation {
	var description:String {
		get {
			return	""
		}
	}
	var	allChildNodes:[ASTNodeNavigation] {
		get {
			return	[cursorNode]
		}
	}
}
extension CursorNode: ASTNodeNavigation {
	var description:String {
		get {
			return	self.cursorData.description
		}
	}
	var	allChildNodes:[ASTNodeNavigation] {
		get {
			return	[lazyData.typeNode] as [ASTNodeNavigation] + lazyData.childCursorNodes as [ASTNodeNavigation] + lazyData.argumentCursorNodes as [ASTNodeNavigation]
		}
	}
}

extension TypeNode: ASTNodeNavigation {
	var description:String {
		get {
			return	self.typeData.description
		}
	}
	var	allChildNodes:[ASTNodeNavigation] {
		get {
			var	ns	=	[] as [ASTNodeNavigation]
			ns.append(lazyData.declarationCursorLinkNode)
			if let n = lazyData.resultTypeNode {
				ns.append(n)
			}
			if let ns1 = lazyData.argumentTypeNodes {
				ns.extend(ns1 as [ASTNodeNavigation])
			}
			if let n = lazyData.pointeeTypeNode {
				ns.append(n)
			}
			return	ns
		}
	}
}

extension CursorLinkNode: ASTNodeNavigation {
	var description:String {
		get {
			return	cursorData.description
		}
	}
	var	allChildNodes:[ASTNodeNavigation] {
		get {
			return	[]
		}
	}
}






