#pragma rtGlobals=1		// Use modern global access method.
#pragma IgorVersion=6.2
#pragma version=6.30		// Shipped with Igor 6.30
#pragma IndependentModule=WMMenusModule

// NOTE: Let's try to keep these menu items alphabetically sorted, where it is reasonable.

// Quick access to select packages in WaveMetrics Procedures folder...
Menu "Load Waves", hideable
	Submenu "Packages"
		"Install GIS Utilities",/Q,Execute/P/Q/Z "INSERTINCLUDE <GIS Utilities>";Execute/P/Q/Z "COMPILEPROCEDURES "
		"Load FITS",/Q,Execute/P/Q/Z "INSERTINCLUDE <FITS Loader>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "CreateFITSLoader()"
		"Install HDF5 Package",/Q, InstallHDF5Package()
	End
End

// Although the following is a submenu it behaves like main menu.
Menu "Statistics", hideable
	"ANOVA Power Panel",/Q,Execute/P/Q/Z "INSERTINCLUDE <AllStatsProcedures>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_SetupANOVAPowerPanel()"
	"1D Statistics Report...",/Q,Execute/P/Q/Z "INSERTINCLUDE <AllStatsProcedures>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_initAncilla()"
	"Two Sample Tests...",/Q,Execute/P/Q/Z "INSERTINCLUDE <AllStatsProcedures>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "TSP_OpenPanel()"
	"Percentiles", Execute/P/Q/Z "INSERTINCLUDE <Percentile and Box Plot>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "MakeWavePercentilePanel(1)"
	"Waves Average", Execute/P/Q/Z "INSERTINCLUDE <Waves Average>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "MakeWavesAveragePanel()"
End
	
Menu "Analysis", hideable
	Submenu "Packages"
		"Average Waves",/Q,Execute/P/Q/Z "INSERTINCLUDE <Waves Average>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "MakeWavesAveragePanel()"
		"Batch Curve Fitting...",/Q,Execute/P/Q/Z "INSERTINCLUDE <WMBatchCurveFitIM>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMBatchCurveFit#InitBatchFitPanel()"
		"Function Grapher",/Q,Execute/P/Q/Z "INSERTINCLUDE <Function Grapher>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "fGraphFunctionGraph()"
		"Global Fit",/Q,Execute/P/Q/Z "INSERTINCLUDE <Global Fit 2>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_NewGlobalFit1#InitNewGlobalFitPanel()"
		"Image Processing",/Q,Execute/P/Q/Z "INSERTINCLUDE <All IP Procedures>";Execute/P/Q/Z "INSERTINCLUDE <Image Saver>";Execute/P/Q/Z "COMPILEPROCEDURES "
		"Median XY Smoothing",/Q,Execute/P/Q/Z "INSERTINCLUDE <Median XY Smoothing Dialog>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMMedianXYIM#WMMedian#ShowMedianXYSmoothingPanel()"
		Submenu "Multipeak Fitting"
			"Multipeak Fitting 2",/Q,InstallMultipeakFit2()
			"\\M0Multipeak Fitting 1.4 (old version)",/Q,Execute/P/Q/Z "INSERTINCLUDE <Multi-peak fitting 1.4>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "CreateFitSetupPanel()"
		end
		"Percentiles and Box Plot",/Q,Execute/P/Q/Z "INSERTINCLUDE <Percentile and Box Plot>";Execute/P/Q/Z "COMPILEPROCEDURES "
		"Wave Arithmetic",/Q,Execute/P/Q/Z "INSERTINCLUDE <Wave Arithmetic Panel>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "InitWaveArith(WinName(0,1))"
	End
End

Menu "Graph", hideable
	Submenu "Packages"
		"Append Calibrator",/Q,Execute/P/Q/Z "INSERTINCLUDE <Append Calibrator>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "Calibrator()"
		"Autosize Images",/Q,Execute/P/Q/Z "INSERTINCLUDE <Autosize Images>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "AutoSizeImage()"
		"Axis Slider",/Q,Execute/P/Q/Z "INSERTINCLUDE <AxisSlider>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMAppendAxisSlider()"
		"Color Table Control",/Q,Execute/P/Q/Z "INSERTINCLUDE <Color Table Control Panel>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMColorTableControlPanel#createColorTableControlPanel()"
		"Copy Image Subset",/Q,Execute/P/Q/Z "INSERTINCLUDE <CopyImageSubset>";Execute/P/Q/Z "COMPILEPROCEDURES "
		"Fill Between Contours...", /Q, Execute/P/Q/Z "INSERTINCLUDE <FillBetweenContours>,menus=0";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMFillContour#WMFillBetweenContours()"
		"Graph Magnifier",/Q,Execute/P/Q/Z "INSERTINCLUDE <GraphMagnifier>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "mMakeMagnifier()"
		"Insert Subwindow",/Q,Execute/P/Q/Z "INSERTINCLUDE <InsertSubwindowInGraph>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMSubwindowInGraphPanel()"
		"Make Traces Different",/Q,Execute/P/Q/Z "INSERTINCLUDE <KBColorizeTraces>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "ShowKBColorizePanel()"
		"Modify Waterfall",/Q,Execute/P/Q/Z "INSERTINCLUDE <Waterfall>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_fNewWaterfallPanel(1)"
		"Save Graph",/Q,Execute/P/Q/Z "INSERTINCLUDE <SaveGraph>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "DoSaveGraphToFile()"
		"Select Points for Mask",/Q,Execute/P/Q/Z "INSERTINCLUDE <Select Points for Mask>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "SelectPointsforMask#StartupDataMask(\"\")"
		"Split Axes",/Q,Execute/P/Q/Z "INSERTINCLUDE <Split Axis>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_SplitAxisIModule#BuildSplitAxisPanel(WinName(0,1))"
		"Tint Background",/Q,Execute/P/Q/Z "INSERTINCLUDE <TintedWindowBackground>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_TintedBkgPanel()"
		"Transform Axes",/Q, LoadTransformAxis(0)
		"ZoomBrowser",/Q,Execute/P/Q/Z "INSERTINCLUDE <ZoomBrowser>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMZoomBrowser#AddZoomBrowserPanel()"
	End
End


Menu "Panel", hideable
	Submenu "Packages"
		"Edit Controls Resized Positions",/Q,Execute/P/Q/Z "INSERTINCLUDE <Resize Controls>";Execute/P/Q/Z "INSERTINCLUDE <Resize Controls Panel>,menus=0";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "ShowResizeControlsPanel()"
	End
End


Menu "Layout", hideable
	Submenu "Packages"
		"Tint Background",/Q,Execute/P/Q/Z "INSERTINCLUDE <TintedWindowBackground>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_TintedBkgPanel()"
	End
End

// JW is putting the Window Browser in two places: Misc is easier to find but not really appropriate;
// The proper place is in the Windows menu but that can't take user-defined menu items;
// The Control menu is somewhat logical, but puts the menu item buried pretty deeply.
Menu "Misc", hideable
	Submenu "Packages"
		"Window Browser", /Q, Execute/P/Q/Z "INSERTINCLUDE <WindowBrowser>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMWInBrowser#MakeWindowBrowser()"
		help = {"A window that displays a hierarchical list of all windows and subwindows. Provides a small set of actions that can be taken on selected windows."}
	end
end

Menu "Control", hideable
	Submenu "Packages"
		"Window Browser", /Q, Execute/P/Q/Z "INSERTINCLUDE <WindowBrowser>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMWInBrowser#MakeWindowBrowser()"
		help = {"A window that displays a hierarchical list of all windows and subwindows. Provides a small set of actions that can be taken on selected windows."}
	end
end

Menu "New", hideable
	Submenu "Packages"
		"Box Plot",/Q, Execute/P/Q/Z "INSERTINCLUDE <Percentile and Box Plot>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "MakeWavePercentilePanel(0)"
		"2D Pie Chart",/Q,Execute/P/Q/Z "INSERTINCLUDE <PieChart>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "New2DPieChart()"
		"3D Pie Chart",/Q,Execute/P/Q/Z "INSERTINCLUDE <Gizmo3DPieChart>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "NewGizmo3DPieChart()"
		"Polar Graph",/Q,Execute/P/Q/Z "INSERTINCLUDE <New Polar Graphs>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WMPolarGraphs(0)"
		"Probability Graph",/Q,LoadTransformAxis(1);
		"Rose Plot",/Q,Execute/P/Q/Z "INSERTINCLUDE <RosePlot>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "RosePlot()"
		"Scatter Dot Plot",/Q,Execute/P/Q/Z "INSERTINCLUDE <Scatter Dot Plot>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "ScatterDotPlot#ScatterDotPlotPanel()"
		"Scatter Plot Matrix",/Q,Execute/P/Q/Z "INSERTINCLUDE <Scatter Plot Matrix 2>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "fScatterPlotMatrixPanel2()"
		"Sonogram", Execute/P/Q/Z "INSERTINCLUDE <Sonogram>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "SG_SonogramPanel()"
		"Ternary Diagram",/Q, Execute/P/Q/Z "INSERTINCLUDE <Ternary Diagram>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "TernaryDiagramModule#mNewTernaryGraph()"
		"Waterfall Plot",/Q,Execute/P/Q/Z "INSERTINCLUDE <Waterfall>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "WM_fNewWaterfallPanel(0)"
	End
End

Menu "Data", hideable
	Submenu "Packages"
		"Color Wave Editor",/Q, Execute/P/Q/Z "INSERTINCLUDE <ColorWaveEditor>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "CWE_MakeColorEditorPanel()"
		"Delete XY Points",/Q, Execute/P/Q/Z "INSERTINCLUDE <Delete XY Points>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "ShowDeleteXYPointsPanel()"
		"XY Pair To Waveform",/Q,  Execute/P/Q/Z "INSERTINCLUDE <XY Pair To Waveform Panel>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "XY2WFM#ShowXYPairToWaveformPanel()"
		"XYZ to Matrix",/Q, Execute/P/Q/Z "INSERTINCLUDE <XYZtoMatrix>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "DoAlert 0, \"Make a selection from the Macros menu\""
	End
End

static Function IsIgorJ()
	String locale
	Variable result

	locale = StringByKey("LOCALE",IgorInfo(3))
	result = CmpStr(locale,"Japan") == 0
	return result
End

Function/S GetHelpMenuUpdateItem()
	String result

	if (IsIgorJ())
		result = "最新バージョンの確認"			// "Check Latest Version" in Japanese.
	else
		result = "Updates for Igor "+StringByKey("IGORFILEVERSION",IgorInfo(3))+SelectString(strsearch(StringByKey("IGORKIND",IgorInfo(0)),"64",0)>=0,""," x64")
	endif
	
	return result
End

Function/S GetHelpMenuUpdateURL()
	String result
	
	if (IsIgorJ())
		result = "http://www.wavemetrics.com/Updates/IGORProJ/LatestVersion.html"
	else
		// Ask PHP script about updates
		String format = "http://www.wavemetrics.com/Updates/IGORPro/igor6updatecheck.php?version=%s&platform=%s"
		String sixtyFour= SelectString(strsearch(StringByKey("IGORKIND",IgorInfo(0)),"64",0)>=0,"","64")
		String platform = SelectString(strsearch(UpperStr(IgorInfo(2)),"WINDOWS",0)>=0,"Mac","Win")+sixtyFour
		String version = StringByKey("IGORFILEVERSION",IgorInfo(3))
		sprintf result, format, version, platform
	endif
	
	return result
End

Function LoadTransformAxis(prob)
	variable prob

	if (Exists("TransformAxisWindowHook"))					// a function in old transform axis package
		Execute/P/Q/Z "DoAlert 0, \"You already have the older version of Transform Axis loaded\""
	elseif (Exists("TransformAxisWindowHook1_2"))		// a function in transform axis package 1.2
		return 0													// no action needed
	else
	// no transform axis package loaded
		Execute/P/Q/Z "INSERTINCLUDE <TransformAxis1.2>"
		Execute/P/Q/Z "COMPILEPROCEDURES "
		if (prob)
			Execute/P/Q/Z "DoProcessProbabilityDataPanel()"
		else
			Execute/P/Q/Z "DoTransformAxisPanel(0)"
		endif
	endif
end

Function InstallHDF5Package()
	String message
	
	Variable haveHDF5XOP = Exists("HDF5LoadData") == 4
	Variable haveHDF5BrowserProcs = Exists("ProcGlobal#HDF5Browser#CreateNewHDF5Browser") == 6
	
	if (haveHDF5XOP && haveHDF5BrowserProcs)
		message = "The HDF5 package is installed."
		message += " If you have not already done it, go through the HDF5 Guided Tour."
		message += "\r\rClick OK to see the HDF5 Help file."
		DoAlert 0, message
		DisplayHelpTopic "HDF5XOP"
	else
		message = "The HDF5 package is not installed."
		if (haveHDF5XOP)
			message = "The HDF5Browser procedure file is not installed."
		endif
		if (haveHDF5BrowserProcs)
			message = "The HDF5 XOP is not installed."
		endif
		message += "\r\rClick OK to see installation instructions."
		DoAlert 0, message
		DisplayHelpTopic "Installing The HDF5 Package"
	endif
End

Function InstallMultipeakFit2()

	Variable havePeakFunctions2XOP = strlen(FunctionInfo("MPFXGaussPeak")) > 0

	if (!havePeakFunctions2XOP)
		DoAlert 0, "The Peak Functions 2 XOP is missing and Multipeak Fit 2 depends on it. It should have been shipped already installed."
		DisplayHelpTopic "Loading the Multi-Peak Fit Package"
	else
		Execute/P/Q/Z "INSERTINCLUDE <Multi-peak fitting 2.0>";Execute/P/Q/Z "COMPILEPROCEDURES ";Execute/P/Q/Z "fStartMultipeakFit2()"
	endif
end