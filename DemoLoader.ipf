#pragma rtGlobals=1
#pragma IndependentModule= WMDemoLoader

// Igor Pro 6.33 (Macintosh) 7/3/13

#pragma IgorVersion=6.32

Menu "Example Experiments"
	SubMenu "Analysis"
		"\M03DRotationsPanel",  /Q, ExamplesExperimentLoader(":Examples:Analysis:3DRotationsPanel.pxp")
		"\M0Ave, Box Plot, Percentile",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Ave, Box Plot, Percentile.pxp")
		"\M0BiVariate Histogram Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:BiVariate Histogram Demo.pxp")
		"\M0Clustering",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Clustering.pxp")
		"\M0CWT Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:CWT Demo.pxp")
		"\M0Differential Equation Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Differential Equation Demo.pxp")
		"\M0DimensionReductionDemo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:DimensionReductionDemo.pxp")
		"\M0FFT Swapping Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:FFT Swapping Demo.pxp")
		"\M0Gaussian Filtering",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Gaussian Filtering.pxp")
		"\M0ImageUnwrapPhase Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:ImageUnwrapPhase Demo.pxp")
		"\M0Integrating Histogram",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Integrating Histogram.pxp")
		"\M0KalmanFilterExample",  /Q, ExamplesExperimentLoader(":Examples:Analysis:KalmanFilterExample.pxp")
		"\M0MagPhase Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:MagPhase Demo.pxp")
		"\M0MD Root Finder Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:MD Root Finder Demo.pxp")
		"\M0Neural Net Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Neural Net Demo.pxp")
		"\M0NumericalIntegrationDemo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:NumericalIntegrationDemo.pxp")
		"\M0ODE Friction Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:ODE Friction Demo.pxp")
		"\M0PCADemo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:PCADemo.pxp")
		"\M0PSD Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:PSD Demo.pxp")
		"\M0RadonTransformDemo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:RadonTransformDemo.pxp")
		"\M0Smooth Operation Responses",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Smooth Operation Responses.pxp")
		"\M0Special Functions Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Special Functions Demo.pxp")
		"\M0Spectral ConfidenceInterval",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Spectral ConfidenceInterval.pxp")
		"\M0Spectral Deconvolution Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Spectral Deconvolution Demo.pxp")
		"\M0Wave Arithmetic Panel Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Wave Arithmetic Panel Demo.pxp")
		"\M0Wavelet Demo 2.0",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Wavelet Demo 2.0.pxp")
		"\M0Wigner Demo",  /Q, ExamplesExperimentLoader(":Examples:Analysis:Wigner Demo.pxp")
	end
	SubMenu "Curve Fitting"
		"\M0Batch Curve Fitting Demo",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Batch Curve Fitting Demo.pxp")
		"\M0Constraint Demo",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Constraint Demo.pxp")
		"\M0Fit Line Between Cursors",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Fit Line Between Cursors.pxp")
		"\M0Global Fit Demo",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Global Fit Demo.pxp")
		"\M0Multi-peak fit 1.4",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Multi-peak fit 1.4.pxp")
		"\M0Multi-peak fit 2 Demo",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Multi-peak fit 2 Demo.pxp")
		"\M0Multi-variate Fit Demo",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:Multi-variate Fit Demo.pxp")
		"\M0MultipleFitsInThreads",  /Q, ExamplesExperimentLoader(":Examples:Curve Fitting:MultipleFitsInThreads.pxp")
	end
	SubMenu "Feature Demos"
		"\M0FIFO Chart Demo FM",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:FIFO Chart Demo FM.pxp")
		"\M0FIFO Chart Overhead",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:FIFO Chart Overhead.pxp")
		"\M0GIS Utilities Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:GIS Utilities Demo.pxp")
		"\M0HalfDomeDemo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:HalfDomeDemo.pxp")
		"\M0Live mode",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Live mode.pxp")
		"\M0Live Textbox Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Live Textbox Demo.pxp")
		"\M0Loess Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Loess Demo.pxp")
		"\M0Make Sample Data Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Make Sample Data Demo.pxp")
		"\M0Marquee Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Marquee Demo.pxp")
		"\M0Notebook Actions Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Notebook Actions Demo.pxp")
		"\M0Notebook Demo #1",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Notebook Demo #1.pxp")
		"\M0Quick Append",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Quick Append.pxp")
		"\M0Smooth Curve Through Noise",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Smooth Curve Through Noise.pxp")
		"\M0Smoothing Control Panel",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Smoothing Control Panel.pxp")
		"\M0Spline Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Spline Demo.pxp")
		"\M0SQL Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:SQL Demo.pxp")
		"\M0ValDisplay Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:ValDisplay Demo.pxp")
		"\M0Wave Review Chart Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Wave Review Chart Demo.pxp")
		"\M0Web Page Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos:Web Page Demo.pxp")
	end
	SubMenu "Feature Demos 2"
		"\M0All Controls Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:All Controls Demo.pxp")
		"\M0Barbs and Arrows",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Barbs and Arrows.pxp")
		"\M0ColorScale Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:ColorScale Demo.pxp")
		"\M0ColorsMarkersLinesPatterns",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:ColorsMarkersLinesPatterns.pxp")
		"\M0Custom Control Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Custom Control Demo.pxp")
		"\M0Custom Markers Demos",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Custom Markers Demos.pxp")
		"\M0History Carbon Copy",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:History Carbon Copy.pxp")
		"\M0ListBox Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:ListBox Demo.pxp")
		"\M0Map Projections Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Map Projections Demo.pxp")
		"\M0Notebook in Panel",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Notebook in Panel.pxp")
		"\M0Progress Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Progress Demo.pxp")
		"\M0Resize Panel and List Demo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Resize Panel and List Demo.pxp")
		"\M0sequenceSearchDemo",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:sequenceSearchDemo.pxp")
		"\M0Slider Labels",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:Slider Labels.pxp")
		"\M0TrueType Outlines",  /Q, ExamplesExperimentLoader(":Examples:Feature Demos 2:TrueType Outlines.pxp")
	end
	SubMenu "Graphing Techniques"
		"\M02D Pie Chart Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:2D Pie Chart Demo.pxp")
		"\M0Arrow Plot",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Arrow Plot.pxp")
		"\M0Color Table Control Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Color Table Control Demo.pxp")
		"\M0Colorize Traces Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Colorize Traces Demo.pxp")
		"\M0Fake Waterfall Plot",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Fake Waterfall Plot.pxp")
		"\M0Graph Grid Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Graph Grid Demo.pxp")
		"\M0New Polar Graph Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:New Polar Graph Demo.pxp")
		"\M0Probability Graph Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Probability Graph Demo.pxp")
		"\M0Scatter Dot Plot Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Scatter Dot Plot Demo.pxp")
		"\M0Scatter Plot Matrix Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Scatter Plot Matrix Demo.pxp")
		"\M0Split Axes",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Split Axes.pxp")
		"\M0Ternary Diagram Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Ternary Diagram Demo.pxp")
		"\M0Transform Axis Demo",  /Q, ExamplesExperimentLoader(":Examples:Graphing Techniques:Transform Axis Demo.pxp")
	end
	SubMenu "Imaging"
		"\M0FITS Loader Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:FITS Loader Demo.pxp")
		"\M0Fuzzy Classify Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Fuzzy Classify Demo.pxp")
		"\M0Image MagPhase Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Image MagPhase Demo.pxp")
		"\M0Image Processing Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Image Processing Demo.pxp")
		"\M0Image Registration Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Image Registration Demo.pxp")
		"\M0Image Strip FIFO Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Image Strip FIFO Demo.pxp")
		"\M0Image Warping Demo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:Image Warping Demo.pxp")
		"\M0snakeDemo",  /Q, ExamplesExperimentLoader(":Examples:Imaging:snakeDemo.pxp")
	end
	SubMenu "Movies & Audio"
		SubMenu "Sound Input"
			"\M0Audio Snarfer",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Audio Snarfer.pxp")
			"\M0Fake Acquisition (fifo)",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Fake Acquisition (fifo).pxp")
			"\M0Fake Acquisition (sound)",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Fake Acquisition (sound).pxp")
			"\M0Realtime Sonagram",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Realtime Sonagram.pxp")
			"\M0Realtime Soundlevel",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Realtime Soundlevel.pxp")
			"\M0Sound Chart Demo",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Sound Chart Demo.pxp")
			"\M0Sound System Eval",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sound Input:Sound System Eval.pxp")
		end
		"\M0FM Modulation Movie",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:FM Modulation Movie.pxp")
		"\M0ReadWriteAIFF",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:ReadWriteAIFF.pxp")
		"\M0Sonogram Demo",  /Q, ExamplesExperimentLoader(":Examples:Movies & Audio:Sonogram Demo.pxp")
	end
	SubMenu "Programming"
		"\M0AutoGraph",  /Q, ExamplesExperimentLoader(":Examples:Programming:AutoGraph.pxp")
		"\M0Background Task Demo",  /Q, ExamplesExperimentLoader(":Examples:Programming:Background Task Demo.pxp")
		"\M0CallMicrosoftWord",  /Q, ExamplesExperimentLoader(":Examples:Programming:CallMicrosoftWord.pxp")
		"\M0Extensible Tab Panel Demo",  /Q, ExamplesExperimentLoader(":Examples:Programming:Extensible Tab Panel Demo.pxp")
		"\M0FIFO File Parse",  /Q, ExamplesExperimentLoader(":Examples:Programming:FIFO File Parse.pxp")
		"\M0HDF Demos",  /Q, ExamplesExperimentLoader(":Examples:Programming:HDF Demos.pxp")
		"\M0Hook Peak Place",  /Q, ExamplesExperimentLoader(":Examples:Programming:Hook Peak Place.pxp")
		"\M0Load File Demo",  /Q, ExamplesExperimentLoader(":Examples:Programming:Load File Demo.pxp")
		"\M0Multi-Experiment Process",  /Q, ExamplesExperimentLoader(":Examples:Programming:Multi-Experiment Process.pxp")
		"\M0Multithreaded LoadWave",  /Q, ExamplesExperimentLoader(":Examples:Programming:Multithreaded LoadWave.pxp")
		"\M0MultiThreadMandelbrot",  /Q, ExamplesExperimentLoader(":Examples:Programming:MultiThreadMandelbrot.pxp")
		"\M0Package Preferences Demo",  /Q, ExamplesExperimentLoader(":Examples:Programming:Package Preferences Demo.pxp")
		"\M0read-write test",  /Q, ExamplesExperimentLoader(":Examples:Programming:read-write test.pxp")
		"\M0SearchProceduresInFolder",  /Q, ExamplesExperimentLoader(":Examples:Programming:SearchProceduresInFolder.pxp")
		"\M0Slow Data Acq",  /Q, ExamplesExperimentLoader(":Examples:Programming:Slow Data Acq.pxp")
		"\M0Thread-at-a-Time Demo",  /Q, ExamplesExperimentLoader(":Examples:Programming:Thread-at-a-Time Demo.pxp")
		"\M0Watch Folder",  /Q, ExamplesExperimentLoader(":Examples:Programming:Watch Folder.pxp")
		"\M0WaveSelectorWidgetExample",  /Q, ExamplesExperimentLoader(":Examples:Programming:WaveSelectorWidgetExample.pxp")
	end
	SubMenu "Sample Graphs"
		"\M0Contour Demo",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Contour Demo.pxp")
		"\M0Demo Experiment #1",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Demo Experiment #1.pxp")
		"\M0Demo Experiment #2",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Demo Experiment #2.pxp")
		"\M0Exotic Functions",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Exotic Functions.pxp")
		"\M0Layout Demo",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Layout Demo.pxp")
		"\M0Monster Graph",  /Q, ExamplesExperimentLoader(":Examples:Sample Graphs:Monster Graph.pxp")
	end
	SubMenu "Statistics"
		SubMenu "Circular Statistics"
			"\M0Angular Distance Test",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Angular Distance Test.pxp")
			"\M0Circular Correlation Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Circular Correlation Demo.pxp")
			"\M0Circular Moments Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Circular Moments Demo.pxp")
			"\M0Circular Two Sample Test",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Circular Two Sample Test.pxp")
			"\M0Hodges-Ajne Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Hodges-Ajne Demo.pxp")
			"\M0Watson USquared Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Watson USquared Demo.pxp")
			"\M0Watson-Williams Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Watson-Williams Demo.pxp")
			"\M0Wheeler-Watson Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Circular Statistics:Wheeler-Watson Demo.pxp")
		end
		"\M0ANOVA1 Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:ANOVA1 Demo.pxp")
		"\M0ANOVA2 Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:ANOVA2 Demo.pxp")
		"\M0ANOVA2NR Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:ANOVA2NR Demo.pxp")
		"\M0ANOVA2RM Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:ANOVA2RM Demo.pxp")
		"\M0BoxPlot Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:BoxPlot Demo.pxp")
		"\M0Chi-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Chi-Test Demo.pxp")
		"\M0Cochran-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Cochran-Test Demo.pxp")
		"\M0Contingency Table Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Contingency Table Demo.pxp")
		"\M0Critical Values Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Critical Values Demo.pxp")
		"\M0Dunnett-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Dunnett-Test Demo.pxp")
		"\M0F-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:F-Test Demo.pxp")
		"\M0Friedman-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Friedman-Test Demo.pxp")
		"\M0Jarque-Bera Simulation",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Jarque-Bera Simulation.pxp")
		"\M0Kruskal-Wallis Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Kruskal-Wallis Demo.pxp")
		"\M0Linear Correlation Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Linear Correlation Demo.pxp")
		"\M0Linear Regression Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Linear Regression Demo.pxp")
		"\M0Multi-Correlation Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Multi-Correlation Demo.pxp")
		"\M0NominalSR Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:NominalSR Demo.pxp")
		"\M0NonParametric MultiCompDemo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:NonParametric MultiCompDemo.pxp")
		"\M0PowerDemo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:PowerDemo.pxp")
		"\M0Scheffe-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Scheffe-Test Demo.pxp")
		"\M0Serial Randomness Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Serial Randomness Demo.pxp")
		"\M0Spearman Rank Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Spearman Rank Demo.pxp")
		"\M0T-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:T-Test Demo.pxp")
		"\M0Tukey-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Tukey-Test Demo.pxp")
		"\M0Variances-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Variances-Test Demo.pxp")
		"\M0Wilcoxon-Test Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:Wilcoxon-Test Demo.pxp")
		"\M0WR Correlation Demo",  /Q, ExamplesExperimentLoader(":Examples:Statistics:WR Correlation Demo.pxp")
	end
	SubMenu "Techniques"
		"\M0Cursor Moved Hook Demo",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Cursor Moved Hook Demo.pxp")
		"\M0cursorhook demo",  /Q, ExamplesExperimentLoader(":Examples:Techniques:cursorhook demo.pxp")
		"\M0Cursors Move Together Demo",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Cursors Move Together Demo.pxp")
		"\M0Delete Points from Wave",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Delete Points from Wave.pxp")
		"\M0Delete XY Points Demo",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Delete XY Points Demo.pxp")
		"\M0Load Row Data",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Load Row Data.pxp")
		"\M0Tags as Markers Demo",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Tags as Markers Demo.pxp")
		"\M0Trace Graph",  /Q, ExamplesExperimentLoader(":Examples:Techniques:Trace Graph.pxp")
	end
	SubMenu "Testing"
		"\M0Automated Self Testing",  /Q, ExamplesExperimentLoader(":Examples:Testing:Automated Self Testing.pxp")
		"\M0benchmark 2.02",  /Q, ExamplesExperimentLoader(":Examples:Testing:benchmark 2.02.pxp")
		"\M0Bessel Accuracy",  /Q, ExamplesExperimentLoader(":Examples:Testing:Bessel Accuracy.pxp")
		"\M0GenerateDemoLoader",  /Q, ExamplesExperimentLoader(":Examples:Testing:GenerateDemoLoader.pxp")
		"\M0ImageSpeedTest",  /Q, ExamplesExperimentLoader(":Examples:Testing:ImageSpeedTest.pxp")
		"\M0Live Update Testing",  /Q, ExamplesExperimentLoader(":Examples:Testing:Live Update Testing.pxp")
		"\M0MatrixOps Tests",  /Q, ExamplesExperimentLoader(":Examples:Testing:MatrixOps Tests.pxp")
		"\M0matrixOPValidation",  /Q, ExamplesExperimentLoader(":Examples:Testing:matrixOPValidation.pxp")
		"\M0Notebook Operations Test",  /Q, ExamplesExperimentLoader(":Examples:Testing:Notebook Operations Test.pxp")
		"\M0Notebook Picture Tests",  /Q, ExamplesExperimentLoader(":Examples:Testing:Notebook Picture Tests.pxp")
		"\M0PerformanceTesting",  /Q, ExamplesExperimentLoader(":Examples:Testing:PerformanceTesting.pxp")
		"\M0Printer Test",  /Q, ExamplesExperimentLoader(":Examples:Testing:Printer Test.pxp")
		"\M0PrintSettings Test",  /Q, ExamplesExperimentLoader(":Examples:Testing:PrintSettings Test.pxp")
		"\M0Tick Mark Tests",  /Q, ExamplesExperimentLoader(":Examples:Testing:Tick Mark Tests.pxp")
		"\M0User Menu Tests",  /Q, ExamplesExperimentLoader(":Examples:Testing:User Menu Tests.pxp")
		"\M0WaveStats Tests",  /Q, ExamplesExperimentLoader(":Examples:Testing:WaveStats Tests.pxp")
	end
	SubMenu "Visualization"
		SubMenu "Advanced"
			"\M0BackgroundImageDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:BackgroundImageDemo.pxp")
			"\M0Clipping Demo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:Clipping Demo.pxp")
			"\M0crystalDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:crystalDemo.pxp")
			"\M0DepthSortingDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:DepthSortingDemo.pxp")
			"\M0GizmoEarth",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:GizmoEarth.pxp")
			"\M0GizmoPerspectiveDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:GizmoPerspectiveDemo.pxp")
			"\M0GizmoWindowHook",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:GizmoWindowHook.pxp")
			"\M0LissajousDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:LissajousDemo.pxp")
			"\M0mobiusTexture",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:mobiusTexture.pxp")
			"\M0Positional Light",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:Positional Light.pxp")
			"\M0Scatter Arrows",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:Scatter Arrows.pxp")
			"\M0scatterOfScatter",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:scatterOfScatter.pxp")
			"\M0textCoordinatesDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Advanced:textCoordinatesDemo.pxp")
		end
		"\M0GizmoColorScaleDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:GizmoColorScaleDemo.pxp")
		"\M0GizmoSphere",  /Q, ExamplesExperimentLoader(":Examples:Visualization:GizmoSphere.pxp")
		"\M0Intersecting surfaces",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Intersecting surfaces.pxp")
		"\M0IsoSurfaceDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:IsoSurfaceDemo.pxp")
		"\M0Material Attributes Demo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Material Attributes Demo.pxp")
		"\M0Mobius",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Mobius.pxp")
		"\M0Molecule",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Molecule.pxp")
		"\M0objects",  /Q, ExamplesExperimentLoader(":Examples:Visualization:objects.pxp")
		"\M0quaternaryDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:quaternaryDemo.pxp")
		"\M0Ribbon",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Ribbon.pxp")
		"\M0RotationDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:RotationDemo.pxp")
		"\M0scatter",  /Q, ExamplesExperimentLoader(":Examples:Visualization:scatter.pxp")
		"\M0sphericalHarmonicsDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:sphericalHarmonicsDemo.pxp")
		"\M0Text",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Text.pxp")
		"\M0Translucency",  /Q, ExamplesExperimentLoader(":Examples:Visualization:Translucency.pxp")
		"\M0VolumeGridsDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:VolumeGridsDemo.pxp")
		"\M0VolumeSlicerDemo",  /Q, ExamplesExperimentLoader(":Examples:Visualization:VolumeSlicerDemo.pxp")
		"\M0voxelgram",  /Q, ExamplesExperimentLoader(":Examples:Visualization:voxelgram.pxp")
		"\M0wedges",  /Q, ExamplesExperimentLoader(":Examples:Visualization:wedges.pxp")
	end
		"-"
	SubMenu "Sample Data"
		"\M0ImageSample",  /Q, ExamplesExperimentLoader(":Learning Aids:Sample Data:ImageSample.pxp")
	end
	SubMenu "Tutorials"
		"\M03D Graphics Tutorial",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:3D Graphics Tutorial.pxp")
		"\M0Data Folder Tutorial",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:Data Folder Tutorial.pxp")
		"\M0Image Processing Tutorial",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:Image Processing Tutorial.pxp")
		"\M0User Fit Tutorial",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:User Fit Tutorial.pxp")
		"\M0Using Igor Documentation",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:Using Igor Documentation.pxp")
		"\M0X Scaling Tutorial",  /Q, ExamplesExperimentLoader(":Learning Aids:Tutorials:X Scaling Tutorial.pxp")
	end
		"-"
		"Removing This Menu...", /Q, DoAlert 0, "To remove this menu from Igor, drag the file DemoLoader.ipf out of the Igor Procedures folder (in your Igor Pro folder)."
	end
end

Function ExamplesExperimentLoader(ExperimentFilePath)
	String ExperimentFilePath

	Execute/P/Q "LOADFILE "+ExperimentFilePath
end

// PNG: width= 13, height= 12
Picture IgorDemoExperimentIcon
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!!X!!!!T#Qau+!5']b#64`($#iF<ErZ1jhuEa-huR'\3irA^!"j<A=EI
	J[Aor6*Eb,5BB5_f5:i^J$6(dBA!!)dc6pXdcJaJlA$,\G*7BM^V\jC'!9[-8q9O=DuTd.(&6DBhq(
	e^h+TQbEc+!0E7R"Wo&;JTRiQQLPG':*g'Zr,$+l1'JuI/"bXQ=4J4L?5Rbb&Uk@H%,67s(:8]KMfp
	sZt#7WGXdlZDgfF"AQ[Y0k440Q>JEfGcfrMrS)kKp$qiZOElkY4Aa()RB[/:1=N^%#(e-*pdLH]/Om
	XqlC6o-`>)&jog0@5`54oB\R-O*I=?=]"jeW*TQ=4LJ`.%q%D<YcK)YDAZ:74N\7P2O+%LgP:<0oX[
	N1Q&d>Hg1+QGg+SG"s&V%2cJ]905>bf00,?F\a1]!!!!j78?7R6=>B
	ASCII85End
End

// PNG: width= 30, height= 30
Picture IgorProcedureIcon
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!!?!!!!?#Qau+!45Wao`+sl&TgHDFAm*iFE_/6AH5;7DfQssEc39jTBQ
	=U!D,jN5u^C3eX"s0KJ3g'Fa%LAPTX%#9r8)\@$Ntb2]pcHGSt>Mi63JC@)VAM/.7)l,cRe!-re`bP
	DB3p0ohut)$#hoW\Hu'Mk%,3:1dOSc0W/e8h$TIArh6\pUPE/c7f!Gkc&VUKQ)6ecM8i$&L#ggjW+P
	u7;is[PlZ[Hd%"O-Xhc$Q6O<,>f&ZAU"MgXX(rlg%3EOeBcs<8C^e1_4oFpP-gU?LM*%0:/d2L%1f(
	2#92.36692J4+[6;jVBX\HploLpHFeG)&9<I;Y@Yfj7>hP.B0"\=4l%pKXj1D]ieRp0_^tP@27.:!+
	P@Eg6P5TEn>6F$T]X.%=/6AsS?@K6K(]';;s8J),;QZ6EM\`"qW-6bO/+Ghg@"ZiUV34WSlG!YudJJ
	#cIBG=[`cYRBTLEBo(6\68^Q[Pb.mf%_TY57D!!!!j78?7R6=>B
	ASCII85End
End

// PNG: width= 30, height= 30
Picture IgorNoProcedureIcon
	ASCII85Begin
	M,6r;%14!\!!!!.8Ou6I!!!!?!!!!?#Qau+!45Wao`+sl&TgHDFAm*iFE_/6AH5;7DfQssEc39jTBQ
	=U"85;S5u^C3[?c;9)eBl,TD*g,Y-qU@Pee?qfQEkA\ga;((e+RpgTnS[9p>i<1c.+1RO.m*M_X`D@
	u+9X3mb**VV=?K2hWp<;A`la&e1CQ$Sdk%0f,g3C2>&GCTi..s/7,<gAM#D^FjH]kB!9iHd<uk+<i"
	%Op&s-OsJ#6)upO:ghuk,d1o(nKHMI0P2peuEVW4mjd7Ho.*AWpU*r[Dp38\@O%3%]B'qsNcCJ1p_?
	EYD-N&Bb=/?#F0.34a.j,mK,,uQ%]GT>s(iXK`IV:Q4=fI[PkSkF_*>eEM<"*Ia'bM,RbJRXA1JIp:
	?s/qa#5is9B&R'fNtgZ/p?c9XIC5r:5\F/?EXF7TT*,WpFF:`9ZX)1.;*=BFGcHH("Qfk!07jBqGXq
	QK"8sR$q7bQ#^<iFr>m!^^*0"D]==Au?6Y#l!o"ZXG,SZ-ufME9G"Te\>&6jUt4>^$.s&<WBe]`djh
	>VL\orhdT(*Eat@6/F%lQ>o;D"2t'm#l\hOue$H<J+m>)@Z@,"*eB[ZIs>QPW"$!rt4FkpWf,p3app
	;1s9glKV)"$I^j]1/o\JAn(;O(Hf@k6#.8'^6P`2HCc5F^D)PV%D\Q`YAQR@0-Vf8jq$r1fhEDhh$4
	jng'c4.+/E$?fU525$(`*0Me'iI#jtjU3f.4TP2)Jbb&>#I#hjq,423+al!J$DZHkuO:Zdo,,PcDRM
	4f>N/M[#D$eu[@SNa!k5`+5)DPAh20B<>7>S0PANs7N84f8W*sV+6hI^?WWu@gjL\5R9r5:7S`Dqd`
	I)^TDqHj*G=><UZqrV!R7qC&(7`$hmnd#(lo;oOgd4]d5%MQep*PF>4Z6`9Jg^E=nP"_3^F1pdVG,H
	8kEd%>A5TUt1I!2f@:;9?Yp^K=SM)>Wgs(Sh3njV2/s]3lfq)!rHT3pUfcVmQ>aFPlBCi20e&PMY)U
	@^G2"L0VT(ea`?13j^grb%RtmegmPhs,*<*r,;T6_cT#5`c!5[CHE,^aU!gsn-29FPM/_[LMd8S=gV
	I&S2@fIGI*C6QE3A#bQ[eZ$XhN.=CG[U/?s,BHLYlDR)7U<iG!1]WI'faWD&kt/=TGC<D>$Jp#XIC,
	92"+>p00J2LYm;T=[[Z^oXs--@?%rT"OSV9NRXCS/B`n(=CjmMV#E7KVWs&P\C,bC1l?nMWY*OaX-F
	DJ#`6%k5dT%ce@pc/,FXScAIU10fkQRa[3pP),GERTf<%c]BCWN]kjis\Zd5-e8[3'Jgsr7M,tT;:(
	qZ1.o^j[B)?B'fl4=R,^['t<"n4);GA.f*z8OZBBY!QNJ
	ASCII85End
End
