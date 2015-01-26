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
		
		let	args	=	[
			"-x", "c++",
			"-std=c++11",
			"-stdlib=libc++",
			"-isysroot", "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk",
			"-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
			"-F\(p)",
		]
		let	tu		=	self.idx.parseTranslationUnit(p1, commandLineArguments: args)
		
		println(tu.diagnostics)
		
		////
		
		let	root	=	ASTRootNode()
		root.translationUnitChildNodes.append(TranslationUnitNode(tu))
		
		mainSplit.syntaxTree.syntaxOutline.rootNodeRepresentation	=	root
		mainSplit.syntaxTree.syntaxOutline.outlineView.reloadData()
		
		mainSplit.syntaxTree.becomeFirstResponder()
	}

	func applicationWillTerminate(aNotification: NSNotification) {
	}


}



///Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
//-x c++
//-arch x86_64
//-fmessage-length=0
//-fdiagnostics-show-note-include-stack
//-fmacro-backtrace-limit=0
//-std=gnu++11
//-stdlib=libc++
//-fmodules
//-fmodules-cache-path=/Users/Eonil/Workshop/Temp/Xcode/Derivations/ModuleCache
//-fmodules-prune-interval=86400
//-fmodules-prune-after=345600
//-Wnon-modular-include-in-framework-module
//-Werror=non-modular-include-in-framework-module
//-Wno-trigraphs
//-fpascal-strings
//-O0
//-Wno-missing-field-initializers
//-Wno-missing-prototypes
//-Werror=return-type
//-Wunreachable-code
//-Werror=deprecated-objc-isa-usage
//-Werror=objc-root-class
//-Wno-non-virtual-dtor
//-Wno-overloaded-virtual
//-Wno-exit-time-destructors
//-Wno-missing-braces
//-Wparentheses
//-Wswitch
//-Wunused-function
//-Wno-unused-label
//-Wno-unused-parameter
//-Wunused-variable
//-Wunused-value
//-Wempty-body
//-Wconditional-uninitialized
//-Wno-unknown-pragmas
//-Wno-shadow
//-Wno-four-char-constants
//-Wno-conversion
//-Wconstant-conversion
//-Wint-conversion
//-Wbool-conversion
//-Wenum-conversion
//-Wshorten-64-to-32
//-Wno-newline-eof
//-Wno-c++11-extensions
//-DDEBUG=1
//-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk
//-fasm-blocks
//-fstrict-aliasing
//-Wdeprecated-declarations
//-Winvalid-offsetof
//-mmacosx-version-min=10.10
//-g
//-fvisibility-inlines-hidden
//-Wno-sign-conversion
//-iquote /Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/SampleProgram4-generated-files.hmap
//-I/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/SampleProgram4-own-target-headers.hmap
//-I/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/SampleProgram4-all-target-headers.hmap
//-iquote /Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/SampleProgram4-project-headers.hmap
//-I/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Products/Debug/include
//-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
//-I/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/DerivedSources/x86_64
//-I/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/DerivedSources
//-F/Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Products/Debug
//-F/Users/Eonil/Workshop/Incubation/LLDBWrapper
//-MMD
//-MT dependencies
//-MF /Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/Objects-normal/x86_64/Try1.d
//--serialize-diagnostics /Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/Objects-normal/x86_64/Try1.dia
//-c /Users/Eonil/Workshop/Incubation/LLDBWrapper/SampleProgram4/Try1.cpp
//-o /Users/Eonil/Workshop/Temp/Xcode/Derivations/LLDBWrapperOnly-airsqgxbfhgxzbftmxsbryswsmcx/Build/Intermediates/LLDBWrapper.build/Debug/SampleProgram4.build/Objects-normal/x86_64/Try1.o








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














