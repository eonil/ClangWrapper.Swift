//
//  AppDelegate.swift
//  ClangASTViewer
//
//  Created by Hoon H. on 2015/01/24.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Cocoa
import ClangWrapper

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!

	let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
	let	mainSplit	=	MainSplitViewControlelr()

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window.contentViewController		=	mainSplit
		
		var	ps	=	[] as [String]
		let	p	=	NSBundle.mainBundle().resourcePath!
		let	p1	=	p + "/LLDB.framework/Headers/LLDB.h"
		
		let	args	=	["-std=c++11", "-F\(p)"]
		let	tu		=	self.idx.parseTranslationUnit(p1, commandLineArguments: args)
		
		let	root	=	ASTRootNode()
		root.translationUnitChildNodes.append(TranslationUnitNode(tu))
		
		mainSplit.syntaxTree.syntaxOutline.rootNodeRepresentation	=	root
		mainSplit.syntaxTree.syntaxOutline.outlineView.reloadData()
	}

	func applicationWillTerminate(aNotification: NSNotification) {
	}


}












class MainSplitViewControlelr: NSSplitViewController {
	let	syntaxTree				=	SyntaxTreeViewController()
	let	typeTree				=	TypeTreeViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.addSplitViewItem(NSSplitViewItem(viewController: syntaxTree))
//		self.addSplitViewItem(NSSplitViewItem(viewController: typeTree))
	}
}

class ScrollViewController: NSViewController {
	var	scrollView:NSScrollView {
		get {
			return	view as NSScrollView
		}
	}
	override func loadView() {
		super.view	=	NSScrollView()
	}
	
	var	documentViewController:NSViewController? {
		didSet {
			self.scrollView.documentView	=	documentViewController?.view
		}
	}
}



class SyntaxTreeViewController: ScrollViewController {
	let	syntaxOutline	=	SyntaxOutlineViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.hasVerticalScroller	=	true
		scrollView.hasHorizontalRuler	=	true
		self.documentViewController	=	syntaxOutline
	}
}

class TypeTreeViewController: ScrollViewController {
	let	typeOutline	=	SyntaxOutlineViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.hasVerticalScroller	=	true
		scrollView.hasHorizontalRuler	=	true
		self.documentViewController	=	typeOutline
	}
}














