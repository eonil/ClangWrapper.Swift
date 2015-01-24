////
////  TypeOutlineViewController.swift
////  ClangWrapper
////
////  Created by Hoon H. on 2015/01/24.
////  Copyright (c) 2015 Eonil. All rights reserved.
////
//
//import Foundation
//import AppKit
//
//
//
//
//
//
//
//
//class TypeOutlineViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
//	
//	enum ColumnIdentifier: String {
//		case Spelling	=	"SPELLING"
//		case Kind		=	"KIND"
//	}
//	
//	var	rootNodeRepresentation:TypeNode? {
//		get {
//			return	self.representedObject as ASTRootNode?
//		}
//		set(v) {
//			self.representedObject	=	v
//			self.outlineView.reloadData()
//		}
//	}
//	
//	var	outlineView:NSOutlineView {
//		get {
//			return	view as NSOutlineView
//		}
//	}
//	override func loadView() {
//		super.view	=	NSOutlineView()
//	}
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		self.outlineView.setDataSource(self)
//		self.outlineView.setDelegate(self)
//		
//		func makeColumn(id:ColumnIdentifier, title:String) -> NSTableColumn {
//			let	c	=	NSTableColumn()
//			c.identifier	=	id.rawValue
//			c.title			=	title
//			c.width			=	200
//			return	c
//		}
//	
//		let	cs	=	[
//			makeColumn(ColumnIdentifier.Spelling, "Spelling"),
//			makeColumn(ColumnIdentifier.Kind, "Kind"),
//		]
//		cs.map(self.outlineView.addTableColumn)
//		self.outlineView.outlineTableColumn	=	cs[0]
//		self.outlineView.rowSizeStyle		=	NSTableViewRowSizeStyle.Small
//	}
//	
//	func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
//		if rootNodeRepresentation == nil {
//			return	0
//		}
//
//		if item == nil {
//			return	1
//		}
//		
//		if let m = item as? ASTRootNode {
//			return	m.translationUnitChildNodes.count
//		}
//		
//		if let m = item as? TranslationUnitNode {
//			return	1
//		}
//		
//		if let m = item as? CursorNode {
//			return	m.cursorChildren.count
//		}
//		return	0
//	}
////	func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
////		
////	}
//	func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
//		if item == nil {
//			return	rootNodeRepresentation!
//		}
//		
//		if let m = item as? ASTRootNode {
//			return	m.translationUnitChildNodes[index]
//		}
//		
//		if let m = item as? TranslationUnitNode {
//			return	m.cursorChildNode
//		}
//		
//		if let m = item as? CursorNode {
//			return	m.cursorChildren[index]
//		}
//		fatalError()
//	}
//	func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
//		return	self.outlineView(outlineView, numberOfChildrenOfItem: item) > 0
//	}
//	func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
//		let	t	=	NSTextField()
//		let	m	=	NSImageView()
//		let	v	=	NSTableCellView()
//		
//		v.textField	=	t
//		v.imageView	=	m
//		
//		v.addSubview(t)
//		v.addSubview(m)
//		
//		////
//		
//		func selectText(item:AnyObject) -> String {
//			if let n = item as? ASTRootNode {
//				if tableColumn == outlineView.outlineTableColumn {
//					return	"(Root)"
//				} else {
//					return	""
//				}
//			}
//			if let n = item as? TranslationUnitNode {
//				if tableColumn == outlineView.outlineTableColumn {
//					return	"(Translation Unit)"
//				} else {
//					return	""
//				}
//			}
//			if let n = item as? CursorNode {
//				switch tableColumn!.identifier {
//				case "SPELLING":	return	n.cursorData.spelling
//				case "KIND":		return	n.cursorData.kind.description
//				case "EXTENT":		return	n.cursorData.extent.description
//				case "TYPE":		return	n.cursorData.type.spelling
//				default:
//					fatalError()
//				}
//			}
//			fatalError()
//		}
//		
//		t.bordered			=	false
//		t.lineBreakMode		=	NSLineBreakMode.ByTruncatingTail
//		t.backgroundColor	=	NSColor.clearColor()
//		t.stringValue		=	selectText(item)
//		
//		return	v
//	}
//}
//
