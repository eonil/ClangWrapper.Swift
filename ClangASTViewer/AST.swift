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
//	case Mangling
	case Description
}

class ASTNode {
	var	name:String		=	""
	init() {
	}
	
	func textForField(f:ASTNodeField) -> String {
		return	""
	}
	func shouldDisplayAsInactive() -> Bool {
		return	false
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
		self.name	=	"[U] \(translationUnitData.cursor.spelling.lastPathComponent)"
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
		let	typedefDeclarationUnderlyingTypeNode:TypeNode
		let	childCursorNodes:[CursorNode]
		
		let	resultTypeNode:TypeNode?
		let	argumentCursorNodes:[CursorNode]
		
		init(_ data:Cursor) {			
			self.typeNode								=	TypeNode(data.type, "[T] type")
			self.typedefDeclarationUnderlyingTypeNode	=	TypeNode(data.typedefDeclarationUnderlyingType, "[T] typedefDeclUnderlyingType")
			
			////
			
			if data.spelling == "ReadRawData" {
				println(data.sourceCode)
				println(data.children.count)
				println(data.visitChildrenWithBlock({ (cursor, parent) -> ChildVisitResult in
					println(cursor)
					return	ChildVisitResult.Recurse
				}))
			}
			var	a1	=	[] as [CursorNode]
			for i in 0..<data.children.count {
				let	c1		=	data.children[i]
				let	cn1		=	CursorNode(c1, "[C] \(c1.spelling)")
//				cn1.name	=	"children[\(i)] \(c1.spelling)"
				a1.append(cn1)
			}
			childCursorNodes	=	a1
			
			var	a2	=	[] as [CursorNode]
			if data.kind == CursorKind.FunctionDecl || data.kind == CursorKind.CXXMethod {
				resultTypeNode	=	TypeNode(data.resultType, "resultType")
				for i in 0..<data.argumentCursors.count {
					let	c	=	data.argumentCursors[i]
					let	n	=	CursorNode(c, "argument[\(i)]")
					a2.append(n)
				}
			} else {
				resultTypeNode	=	nil
			}
			argumentCursorNodes	=	a2
			
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
//		case .Mangling:		return	cursorData.mangling
		case .Description:	return	cursorData.description
		default:			return	""
		}
	}
	override func shouldDisplayAsInactive() -> Bool {
		return	cursorData.isNull
	}
}




















class TypeNode: ASTNode {
	let	typeData:Type
	lazy var lazyData:LazyData	=	LazyData(self.typeData)
	
	init(_ data:Type, _ name:String) {
		self.typeData					=	data
		
		super.init()
		self.name	=	name
	}
	
	struct LazyData {
		let	canonicalTypeNode:TypeNode
		let	declarationCursorLinkNode:CursorLinkNode
		
		///	Array or vectors.
		let	elementTypeNode:TypeNode
		let	arrayElementTypeNode:TypeNode
		
		
		///	For function-like types. 
		let	resultTypeNode:TypeNode?
		let	argumentTypeNodes:[TypeNode]?
		
		///	For point/reference types.
		let	pointeeTypeNode:TypeNode?
		
		init(_ data:Type) {
			let	invalid	=	data.kind == TypeKind.Invalid
			
			func numberExpr(n:Int?) -> String {
				return	n == nil ? "????" : "\(n!)"
			}
			
			canonicalTypeNode			=	TypeNode(data.canonicalType, "[T] canonicalType")
			declarationCursorLinkNode	=	CursorLinkNode(data.declaration, "[@C] declaration")
			elementTypeNode				=	TypeNode(data.elementType, "elementType x \(numberExpr(data.numberOfElements))")
			arrayElementTypeNode		=	TypeNode(data.arrayElementType, "arrayElementType x \(numberExpr(data.arraySize))")
			
			if data.kind == TypeKind.Invalid {
				resultTypeNode		=	nil
				argumentTypeNodes	=	nil
				pointeeTypeNode		=	nil
				return
			}
			
			////
			
			resultTypeNode		=	TypeNode(data.resultType, "[T] resultType")
			
			argumentTypeNodes	=	{
				if let args = data.argumentTypes {
					return	(0..<args.count).map { i in
						let	t	=	args[i]
						return	TypeNode(t,"[T] argumentTypes[\(i)]")
					}
				} else {
					return	nil
				}
			}()
////			if data.kind == TypeKind.FunctionProto || data.kind == TypeKind.FunctionNoProto || data.kind == TypeKind.Unexposed {
//				resultTypeNode		=	TypeNode(data.resultType, "[T] resultType")
//				if let args = data.argumentTypes {
//					argumentTypeNodes	=	(0..<args.count).map { i in
//						let	t	=	args[i]
//						return	TypeNode(t,"[T] argumentTypes[\(i)]")
//					}
////					argumentTypeNodes	=	[]
////					for i in 0..<args.count {
////						let	t	=	args[i]
////						argumentTypeNodes!.append(TypeNode(t,"[T] argumentTypes[\(i)]"))
////					}
//				}
////			}
			
			
			pointeeTypeNode	=	{
				if data.kind == TypeKind.Pointer {
					return	TypeNode(data.pointeeType, "[T] pointeeType")
				}
				if data.kind == TypeKind.LValueReference {
					return	TypeNode(data.pointeeType, "[T] pointeeType")
				}
				if data.kind == TypeKind.RValueReference {
					return	TypeNode(data.pointeeType, "[T] pointeeType")
				}
				return	nil
			}()
		}
	}
	override func textForField(f: ASTNodeField) -> String {
		switch f {
		case .Spelling:		return	typeData.spelling
		case .Kind:			return	typeData.kind.description
//		case .Mangling:		return	""
		case .Description:	return	typeData.description
		default:			return	""
		}
	}
	override func shouldDisplayAsInactive() -> Bool {
		return	typeData.kind == TypeKind.Invalid
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
//		case .Mangling:		return	cursorData.mangling
		case .Description:	return	cursorData.description
		default:			return	""
		}
	}
	override func shouldDisplayAsInactive() -> Bool {
		return	cursorData.isNull
	}
}

































protocol ASTNodeNavigation: AnyObject {
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
			return	translationUnitChildNodes.map({ a in a as ASTNodeNavigation })
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
			var	a	=	[] as [ASTNodeNavigation]
			a.append(lazyData.typeNode)
			a.append(lazyData.typedefDeclarationUnderlyingTypeNode)
			//	Doesn't work in Swift 1.2.
//			lazyData.childCursorNodes.map({ x in a.append(x as ASTNodeNavigation) })
			for x in lazyData.childCursorNodes {
				a.append(x)
			}
			if let n = lazyData.resultTypeNode {
				a.append(n)
			}
			for x in lazyData.argumentCursorNodes {
				a.append(x)
			}
			//	Doesn't work in Swift 1.2.
//			lazyData.argumentCursorNodes.map(a.append)
			return	a
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
//			ns.append(lazyData.canonicalTypeNode)
			ns.append(lazyData.declarationCursorLinkNode)
			if let n = lazyData.resultTypeNode {
				ns.append(n)
			}
			if let ns1 = lazyData.argumentTypeNodes {
				//	Doesn't work in Swift 1.2.
//				ns.extend(ns1 as [ASTNodeNavigation])
				for x in ns1 {
					ns.append(x)
				}
			}
			if let n = lazyData.pointeeTypeNode {
				ns.append(n)
			}
			ns.append(lazyData.elementTypeNode)
			ns.append(lazyData.arrayElementTypeNode)
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






