//
//  CursorKind+Stringification.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


extension CursorKind: Printable {
	public var description:String {
		get{
			let	a	=	[firstNameOf(self)] + collectAliases(self)
			let	s	=	join("/", a)
			return	s
		}
	}
}














private func firstNameOf(v:CursorKind) -> String {
	switch v {
		
	case CursorKind.UnexposedDecl                 : return	"UnexposedDecl"
		
	case CursorKind.StructDecl                    : return	"StructDecl"
		
	case CursorKind.UnionDecl                     : return	"UnionDecl"
		
	case CursorKind.ClassDecl                     : return	"ClassDecl"
		
	case CursorKind.EnumDecl                      : return	"EnumDecl"
		
	case CursorKind.FieldDecl                     : return	"FieldDecl"
		
	case CursorKind.EnumConstantDecl              : return	"EnumConstantDecl"
		
	case CursorKind.FunctionDecl                  : return	"FunctionDecl"
		
	case CursorKind.VarDecl                       : return	"VarDecl"
		
	case CursorKind.ParmDecl                      : return	"ParmDecl"
		
	case CursorKind.ObjCInterfaceDecl             : return	"ObjCInterfaceDecl"
		
	case CursorKind.ObjCCategoryDecl              : return	"ObjCCategoryDecl"
		
	case CursorKind.ObjCProtocolDecl              : return	"ObjCProtocolDecl"
		
	case CursorKind.ObjCPropertyDecl              : return	"ObjCPropertyDecl"
		
	case CursorKind.ObjCIvarDecl                  : return	"ObjCIvarDecl"
		
	case CursorKind.ObjCInstanceMethodDecl        : return	"ObjCInstanceMethodDecl"
		
	case CursorKind.ObjCClassMethodDecl           : return	"ObjCClassMethodDecl"
		
	case CursorKind.ObjCImplementationDecl        : return	"ObjCImplementationDecl"
		
	case CursorKind.ObjCCategoryImplDecl          : return	"ObjCCategoryImplDecl"
		
	case CursorKind.TypedefDecl                   : return	"TypedefDecl"
		
	case CursorKind.CXXMethod                     : return	"CXXMethod"
		
	case CursorKind.Namespace                     : return	"Namespace"
		
	case CursorKind.LinkageSpec                   : return	"LinkageSpec"
		
	case CursorKind.Constructor                   : return	"Constructor"
		
	case CursorKind.Destructor                    : return	"Destructor"
		
	case CursorKind.ConversionFunction            : return	"ConversionFunction"
		
	case CursorKind.TemplateTypeParameter         : return	"TemplateTypeParameter"
		
	case CursorKind.NonTypeTemplateParameter      : return	"NonTypeTemplateParameter"
		
	case CursorKind.TemplateTemplateParameter     : return	"TemplateTemplateParameter"
		
	case CursorKind.FunctionTemplate              : return	"FunctionTemplate"
		
	case CursorKind.ClassTemplate                 : return	"ClassTemplate"
		
	case CursorKind.ClassTemplatePartialSpecialization : return	"ClassTemplatePartialSpecialization"
		
	case CursorKind.NamespaceAlias                : return	"NamespaceAlias"
		
	case CursorKind.UsingDirective                : return	"UsingDirective"
		
	case CursorKind.UsingDeclaration              : return	"UsingDeclaration"
		
	case CursorKind.TypeAliasDecl                 : return	"TypeAliasDecl"
		
	case CursorKind.ObjCSynthesizeDecl            : return	"ObjCSynthesizeDecl"
		
	case CursorKind.ObjCDynamicDecl               : return	"ObjCDynamicDecl"
		
	case CursorKind.CXXAccessSpecifier            : return	"CXXAccessSpecifier"
		
		
		
	case CursorKind.FirstRef                        : return	"FirstRef"
	case CursorKind.ObjCProtocolRef               : return	"ObjCProtocolRef"
	case CursorKind.ObjCClassRef                  : return	"ObjCClassRef"
		
	case CursorKind.TypeRef                       : return	"TypeRef"
	case CursorKind.CXXBaseSpecifier              : return	"CXXBaseSpecifier"
		
	case CursorKind.TemplateRef                   : return	"TemplateRef"
		
	case CursorKind.NamespaceRef                  : return	"NamespaceRef"
		
	case CursorKind.MemberRef                     : return	"MemberRef"
		
	case CursorKind.LabelRef                      : return	"LabelRef"
		
		
	case CursorKind.OverloadedDeclRef             : return	"OverloadedDeclRef"
		
		
	case CursorKind.VariableRef                   : return	"VariableRef"
		
		
		
	case CursorKind.FirstInvalid                  : return	"FirstInvalid"
	case CursorKind.NoDeclFound                   : return	"NoDeclFound"
	case CursorKind.NotImplemented                : return	"NotImplemented"
	case CursorKind.InvalidCode                   : return	"InvalidCode"
		
		
	case CursorKind.FirstExpr                     : return	"FirstExpr"
		
		
		
		
	case CursorKind.DeclRefExpr                   : return	"DeclRefExpr"
		
		
	case CursorKind.MemberRefExpr                 : return	"MemberRefExpr"
		
		
	case CursorKind.CallExpr                      : return	"CallExpr"
		
		
	case CursorKind.ObjCMessageExpr               : return	"ObjCMessageExpr"
		
		
	case CursorKind.BlockExpr                     : return	"BlockExpr"
		
		
	case CursorKind.IntegerLiteral                : return	"IntegerLiteral"
		
		
	case CursorKind.FloatingLiteral               : return	"FloatingLiteral"
		
		
	case CursorKind.ImaginaryLiteral              : return	"ImaginaryLiteral"
		
		
	case CursorKind.StringLiteral                 : return	"StringLiteral"
		
		
	case CursorKind.CharacterLiteral              : return	"CharacterLiteral"
		
		
	case CursorKind.ParenExpr                     : return	"ParenExpr"
		
		
	case CursorKind.UnaryOperator                 : return	"UnaryOperator"
		
		
	case CursorKind.ArraySubscriptExpr            : return	"ArraySubscriptExpr"
		
		
	case CursorKind.BinaryOperator                : return	"BinaryOperator"
		
		
	case CursorKind.CompoundAssignOperator        : return	"CompoundAssignOperator"
		
		
	case CursorKind.ConditionalOperator           : return	"ConditionalOperator"
		
		
	case CursorKind.CStyleCastExpr                : return	"CStyleCastExpr"
		
		
	case CursorKind.CompoundLiteralExpr           : return	"CompoundLiteralExpr"
		
		
	case CursorKind.InitListExpr                  : return	"InitListExpr"
		
		
	case CursorKind.AddrLabelExpr                 : return	"AddrLabelExpr"
		
		
	case CursorKind.StmtExpr                      : return	"StmtExpr"
		
		
	case CursorKind.GenericSelectionExpr          : return	"GenericSelectionExpr"
		
		
	case CursorKind.GNUNullExpr                   : return	"GNUNullExpr"
		
		
	case CursorKind.CXXStaticCastExpr             : return	"CXXStaticCastExpr"
		
		
	case CursorKind.CXXDynamicCastExpr            : return	"CXXDynamicCastExpr"
		
		
	case CursorKind.CXXReinterpretCastExpr        : return	"CXXReinterpretCastExpr"
		
		
	case CursorKind.CXXConstCastExpr              : return	"CXXConstCastExpr"
		
		
	case CursorKind.CXXFunctionalCastExpr         : return	"CXXFunctionalCastExpr"
		
		
	case CursorKind.CXXTypeidExpr                 : return	"CXXTypeidExpr"
		
		
	case CursorKind.CXXBoolLiteralExpr            : return	"CXXBoolLiteralExpr"
		
		
	case CursorKind.CXXNullPtrLiteralExpr         : return	"CXXNullPtrLiteralExpr"
		
		
	case CursorKind.CXXThisExpr                   : return	"CXXThisExpr"
		
		
	case CursorKind.CXXThrowExpr                  : return	"CXXThrowExpr"
		
		
	case CursorKind.CXXNewExpr                    : return	"CXXNewExpr"
		
		
	case CursorKind.CXXDeleteExpr                 : return	"CXXDeleteExpr"
		
		
	case CursorKind.UnaryExpr                     : return	"UnaryExpr"
		
		
	case CursorKind.ObjCStringLiteral             : return	"ObjCStringLiteral"
		
		
	case CursorKind.ObjCEncodeExpr                : return	"ObjCEncodeExpr"
		
		
	case CursorKind.ObjCSelectorExpr              : return	"ObjCSelectorExpr"
		
		
	case CursorKind.ObjCProtocolExpr              : return	"ObjCProtocolExpr"
		
		
	case CursorKind.ObjCBridgedCastExpr           : return	"ObjCBridgedCastExpr"
		
		
	case CursorKind.PackExpansionExpr             : return	"PackExpansionExpr"
		
		
	case CursorKind.SizeOfPackExpr                : return	"SizeOfPackExpr"
		
		
	case CursorKind.LambdaExpr                    : return	"LambdaExpr"
		
		
	case CursorKind.ObjCBoolLiteralExpr           : return	"ObjCBoolLiteralExpr"
		
		
	case CursorKind.ObjCSelfExpr                  : return	"ObjCSelfExpr"
		
		
		
	case CursorKind.FirstStmt                     : return	"FirstStmt"
		
		
	case CursorKind.LabelStmt                     : return	"LabelStmt"
		
		
	case CursorKind.CompoundStmt                  : return	"CompoundStmt"
		
		
	case CursorKind.CaseStmt                      : return	"CaseStmt"
		
		
	case CursorKind.DefaultStmt                   : return	"DefaultStmt"
		
		
	case CursorKind.IfStmt                        : return	"IfStmt"
		
		
	case CursorKind.SwitchStmt                    : return	"SwitchStmt"
		
		
	case CursorKind.WhileStmt                     : return	"WhileStmt"
		
		
	case CursorKind.DoStmt                        : return	"DoStmt"
		
		
	case CursorKind.ForStmt                       : return	"ForStmt"
		
		
	case CursorKind.GotoStmt                      : return	"GotoStmt"
		
		
	case CursorKind.IndirectGotoStmt              : return	"IndirectGotoStmt"
		
		
	case CursorKind.ContinueStmt                  : return	"ContinueStmt"
		
		
	case CursorKind.BreakStmt                     : return	"BreakStmt"
		
		
	case CursorKind.ReturnStmt                    : return	"ReturnStmt"
		
		
	case CursorKind.GCCAsmStmt                    : return	"GCCAsmStmt"
		
		
	case CursorKind.ObjCAtTryStmt                 : return	"ObjCAtTryStmt"
		
		
	case CursorKind.ObjCAtCatchStmt               : return	"ObjCAtCatchStmt"
		
		
	case CursorKind.ObjCAtFinallyStmt             : return	"ObjCAtFinallyStmt"
		
		
	case CursorKind.ObjCAtThrowStmt               : return	"ObjCAtThrowStmt"
		
		
	case CursorKind.ObjCAtSynchronizedStmt        : return	"ObjCAtSynchronizedStmt"
		
		
	case CursorKind.ObjCAutoreleasePoolStmt       : return	"ObjCAutoreleasePoolStmt"
		
		
	case CursorKind.ObjCForCollectionStmt         : return	"ObjCForCollectionStmt"
		
		
	case CursorKind.CXXCatchStmt                  : return	"CXXCatchStmt"
		
		
	case CursorKind.CXXTryStmt                    : return	"CXXTryStmt"
		
		
	case CursorKind.CXXForRangeStmt               : return	"CXXForRangeStmt"
		
		
	case CursorKind.SEHTryStmt                    : return	"SEHTryStmt"
		
		
	case CursorKind.SEHExceptStmt                 : return	"SEHExceptStmt"
		
		
	case CursorKind.SEHFinallyStmt                : return	"SEHFinallyStmt"
		
		
	case CursorKind.MSAsmStmt                     : return	"MSAsmStmt"
		
		
	case CursorKind.NullStmt                      : return	"NullStmt"
		
		
	case CursorKind.DeclStmt                      : return	"DeclStmt"
		
		
	case CursorKind.OMPParallelDirective          : return	"OMPParallelDirective"
		
		
	case CursorKind.OMPSimdDirective              : return	"OMPSimdDirective"
		
		
	case CursorKind.OMPForDirective               : return	"OMPForDirective"
		
		
	case CursorKind.OMPSectionsDirective          : return	"OMPSectionsDirective"
		
		
	case CursorKind.OMPSectionDirective           : return	"OMPSectionDirective"
		
		
	case CursorKind.OMPSingleDirective            : return	"OMPSingleDirective"
		
		
	case CursorKind.OMPParallelForDirective       : return	"OMPParallelForDirective"
		
		
	case CursorKind.OMPParallelSectionsDirective  : return	"OMPParallelSectionsDirective"
		
		
	case CursorKind.OMPTaskDirective              : return	"OMPTaskDirective"
		
		
	case CursorKind.OMPMasterDirective            : return	"OMPMasterDirective"
		
		
	case CursorKind.OMPCriticalDirective          : return	"OMPCriticalDirective"
		
		
	case CursorKind.OMPTaskyieldDirective         : return	"OMPTaskyieldDirective"
		
		
	case CursorKind.OMPBarrierDirective           : return	"OMPBarrierDirective"
		
		
	case CursorKind.OMPTaskwaitDirective          : return	"OMPTaskwaitDirective"
		
		
	case CursorKind.OMPFlushDirective             : return	"OMPFlushDirective"
		
		
	case CursorKind.SEHLeaveStmt                  : return	"SEHLeaveStmt"
		
		
	case CursorKind.OMPOrderedDirective           : return	"OMPOrderedDirective"
		
		
	case CursorKind.OMPAtomicDirective            : return	"OMPAtomicDirective"
		
		
	case CursorKind.OMPForSimdDirective           : return	"OMPForSimdDirective"
		
		
	case CursorKind.OMPParallelForSimdDirective   : return	"OMPParallelForSimdDirective"
		
		
	case CursorKind.OMPTargetDirective            : return	"OMPTargetDirective"
		
		
	case CursorKind.OMPTeamsDirective             : return	"OMPTeamsDirective"
		
		
		
	case CursorKind.TranslationUnit               : return	"TranslationUnit"
		
		
	case CursorKind.FirstAttr                     : return	"FirstAttr"
		
	case CursorKind.IBActionAttr                  : return	"IBActionAttr"
	case CursorKind.IBOutletAttr                  : return	"IBOutletAttr"
	case CursorKind.IBOutletCollectionAttr        : return	"IBOutletCollectionAttr"
	case CursorKind.CXXFinalAttr                  : return	"CXXFinalAttr"
	case CursorKind.CXXOverrideAttr               : return	"CXXOverrideAttr"
	case CursorKind.AnnotateAttr                  : return	"AnnotateAttr"
	case CursorKind.AsmLabelAttr                  : return	"AsmLabelAttr"
	case CursorKind.PackedAttr                    : return	"PackedAttr"
	case CursorKind.PureAttr                      : return	"PureAttr"
	case CursorKind.ConstAttr                     : return	"ConstAttr"
	case CursorKind.NoDuplicateAttr               : return	"NoDuplicateAttr"
	case CursorKind.CUDAConstantAttr              : return	"CUDAConstantAttr"
	case CursorKind.CUDADeviceAttr                : return	"CUDADeviceAttr"
	case CursorKind.CUDAGlobalAttr                : return	"CUDAGlobalAttr"
	case CursorKind.CUDAHostAttr                  : return	"CUDAHostAttr"
	case CursorKind.CUDASharedAttr                : return	"CUDASharedAttr"
		
		
	case CursorKind.PreprocessingDirective        : return	"PreprocessingDirective"
	case CursorKind.MacroDefinition               : return	"MacroDefinition"
	case CursorKind.MacroExpansion                : return	"MacroExpansion"
	case CursorKind.InclusionDirective            : return	"InclusionDirective"
		
		
		
	case CursorKind.ModuleImportDecl              : return	"ModuleImportDecl"
		
	}
	
}
private func collectAliases(v:CursorKind) -> [String] {
	var	s	=	[] as [String]
	
	if v == CursorKind.FirstDecl { s.append("FirstDecl") }
	
	if v == CursorKind.LastDecl { s.append("LastDecl") }
	
	if v == CursorKind.ObjCSuperClassRef { s.append("ObjCSuperClassRef") }
	
	if v == CursorKind.LastRef { s.append("LastRef") }
	
	if v == CursorKind.InvalidFile { s.append("InvalidFile") }
	
	if v == CursorKind.LastInvalid { s.append("LastInvalid") }
	
	if v == CursorKind.UnexposedExpr { s.append("UnexposedExpr") }
	
	if v == CursorKind.LastExpr { s.append("LastExpr") }
	
	
	if v == CursorKind.UnexposedStmt { s.append("UnexposedStmt") }
	
	if v == CursorKind.AsmStmt { s.append("AsmStmt") }
	
	if v == CursorKind.LastStmt { s.append("LastStmt") }
	
	if v == CursorKind.UnexposedAttr { s.append("UnexposedAttr") }
	
	if v == CursorKind.LastAttr { s.append("LastAttr") }
	
	
	if v == CursorKind.MacroInstantiation { s.append("MacroInstantiation") }
	
	
	if v == CursorKind.FirstPreprocessing { s.append("FirstPreprocessing") }
	
	
	if v == CursorKind.LastPreprocessing { s.append("LastPreprocessing") }
	
	
	if v == CursorKind.FirstExtraDecl { s.append("FirstExtraDecl") }
	
	
	if v == CursorKind.LastExtraDecl { s.append("LastExtraDecl") }
	

	return	s
}