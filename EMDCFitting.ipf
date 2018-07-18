#pragma rtGlobals=1		// Use modern global access method.
#pragma rtGlobals=1		// Use modern global access method.
#pragma rtGlobals=1		// Use modern global access method.


//*****************************************************************************************

Function ButtonProc_dataploter_MDC(ctrlName) : ButtonControl
	String ctrlName
	
	String/G Data_name
	Variable/G EMCheck
	Variable/G EDCNUm
	Variable/G MDCNum
	Variable/G CombineNum
	
	Make/o/n=(100,100) wave0
	wave0=0
	
	If(wintype("dataploter")==0)
		Execute "dataploter_MDC()"
	Else
			DoWindow/F dataploter_MDC
	Endif	
	
	EDCnum=0
	mdcnum=0
End
//*****************************************************************************************
//*****************************************************************************************

Window dataploter_MDC() : Graph
	PauseUpdate; Silent 1		// building window...
	Display /W=(117,128,636,577) 
	//AppendToGraph EMDC_y vs EMDC_x
	//AppendToGraph EMDC_y vs EMDC_x
	AppendImage wave0
	ModifyImage wave0 ctab= {*,*,Grays,0}
	ModifyGraph mirror=2
	ShowInfo
	ShowTools/A
	ControlBar 74
	Button Target_data,pos={10,4},size={50,20},proc=Target_data,title="Data"
	Button Target_data,fSize=14
	PopupMenu EMDC,pos={10,35},size={54,20},proc=EDCorMDC,font="Helvetica",fSize=14
	PopupMenu EMDC,mode=1,popvalue="MDC",value= #"\"MDC;EDC\""
	SetVariable EDCTune,pos={76,4},size={80,20},proc=EDCTune,title="EDC",fSize=14
	SetVariable EDCTune,value= EDCNUm
	SetVariable MDCTune,pos={76,35},size={80,20},proc=MDCTune,title="MDC",fSize=14
	SetVariable MDCTune,value= MDCNum
	Button ShowWave,pos={168,4},size={80,20},proc=ButtonProc_1,title="ShowWave"
	Button ShowWave,fSize=14
	SetVariable Combine,pos={168,35},size={80,20},proc=MDCTune,title="Comb",fSize=14
	SetVariable Combine,value= MDCNum
EndMacro
//*****************************************************************************************
Function Target_data(ctrlName) : ButtonControl
	string ctrlname
	
	String/G Data_name
	Variable/G CombineNum
	CombineNum=1
	
	string DN
	Prompt DN, "Append data:"
	Doprompt "Data:", DN
	
	Data_name=DN
	
	Execute "NewData_MDC()"
	
	make/o/n=(2,1) EMDC_x, EMDC_y
	EMDC_x={dimoffset(wave0,0),dimoffset(wave0,0)+dimdelta(wave0,0)*dimsize(wave0,0)}
	EMDC_y={dimoffset(wave0,1),dimoffset(wave0,1)}
	appendtograph EMDC_y vs EMDC_x
	
End
//*****************************************************************************************

Function EDCorMDC(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	Variable/G EMCheck
	Wave EMDC_x
	Wave EMDC_y
	
	EMCheck=popNum
	//print emcheck
	If(PopNum==1)
		EMDC_x={dimoffset(wave0,0),dimoffset(wave0,0)+dimdelta(wave0,0)*dimsize(wave0,0)}
		EMDC_y={dimoffset(wave0,1),dimoffset(wave0,1)}
	else
		EMDC_x={dimoffset(wave0,0),dimoffset(wave0,0)}
		EMDC_y={dimoffset(wave0,1),dimoffset(wave0,1)+dimdelta(wave0,1)*dimsize(wave0,1)}
	endif
	
End
//*****************************************************************************************

Function EDCTune(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	Variable/G EMCheck
	Variable/G EDCNUm
	wave wave0
	wave emdc_x
	wave emdc_y
	
	If(EmCheck==2)
		If(exists("EMDC_x")==1)
			EMDC_x={varNum*dimdelta(wave0,0)+dimoffset(wave0,0),varNum*dimdelta(wave0,0)+dimoffset(wave0,0)}
		endif
	endif
End
//*****************************************************************************************

Function MDCTune(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	Variable/G EMCheck
	Variable/G MDCNUm
	wave wave0
	wave emdc_x
	wave emdc_y
	
	if(emcheck==1)
		If(exists("EMDC_y")==1)
			EMDC_y={varNum*dimdelta(wave0,1)+dimoffset(wave0,1), varNum*dimdelta(wave0,1)+dimoffset(wave0,1)}
		endif
	endif
End
//*****************************************************************************************

Function CombineWave(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	Variable/G CombineNum
	combinenum=varnum
	
	Variable i
		
	
End
//*****************************************************************************************

Function ShowEMDC(ctrlName) : ButtonControl
	String ctrlName
	
End

//*****************************************************************************************
//*****************************************************************************************
Proc NewData_MDC()
	String/G Data_name
	
	duplicate/o $Data_name wave0
	
	
End

//*****************************************************************************************
//*****************************************************************************************
Window EMDC_Fit() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(444,44,716,242)
	ModifyPanel cbRGB=(16385,28398,65535)
	ShowTools/A
	SetDrawLayer UserBack
	SetDrawEnv xcoord= rel,ycoord= rel,fillfgc= (3,52428,1)
	DrawRect 0,0.5,1,1
	Button MDC_Fitting,pos={11,12},size={70,20},proc=ButtonProc_dataploter_MDC,title="EMDC"
	Button MDC_Fitting,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Lorentz1,pos={11,40},size={70,20},proc=Lorentz1_fitting,title="Lor1"
	Button Lorentz1,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Lorentz2,pos={11,68},size={70,20},proc=Lorentz2_fitting,title="Lor2"
	Button Lorentz2,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Lorentz3,pos={89,40},size={70,20},proc=Lor1_table,title="Lor1_Tab"
	Button Lorentz3,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Lorentz4,pos={89,68},size={70,20},proc=Lor2_table,title="Lor2_Tab"
	Button Lorentz4,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Re_Fit,pos={168,40},size={70,20},proc=ReFitting1,title="ReFit1"
	Button Re_Fit,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Re_fit2,pos={168,67},size={70,20},proc=ReFitting2,title="ReFit2"
	Button Re_fit2,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
	Button Plot,pos={11,108},size={70,20},proc=Plot,title="Plot",font="Helvetica"
	Button Plot,fSize=14,fColor=(65535,65535,65535)
	Button MDC_Fitting2,pos={11,138},size={70,20},proc=ButtonProc_2,title="EMDC"
	Button MDC_Fitting2,font="Helvetica",fSize=14,fColor=(65535,65535,65535)
EndMacro

//*****************************************************************************************

Function LorFit_1(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = y0+A*B/((x-x0)^2+B^2)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 4
	//CurveFitDialog/ w[0] = y0
	//CurveFitDialog/ w[8] = A
	//CurveFitDialog/ w[9] = B
	//CurveFitDialog/ w[10] = x0

	return w[0]+w[1]*w[2]/((x-w[3])^2+w[2]^2)
End

Function LorFit_2(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = y0+A*B/((x-x0)^2+B^2)+A1*B1/((x-x1)^2+B1^2)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 7
	//CurveFitDialog/ w[0] = y0
	//CurveFitDialog/ w[2] = A
	//CurveFitDialog/ w[3] = B
	//CurveFitDialog/ w[4] = x0
	//CurveFitDialog/ w[5] = A1
	//CurveFitDialog/ w[6] = B1
	//CurveFitDialog/ w[7] = x1

	return w[0]+w[1]*w[2]/((x-w[3])^2+w[2]^2)+w[4]*w[5]/((x-w[6])^2+w[5]^2)
End


//*****************************************************************************************

Function Lorentz1_fitting(ctrlName) : ButtonControl
	String ctrlName
	
	If(Exists("Lor1_y0")==1)
		
		Execute "Lor1_MDC()"
	else
		
		Print "Make table first!!"
	endif
End
//*****************************************************************************************

Function Lor1_table(ctrlName) : ButtonControl
	String ctrlName
	Variable/G Lor1_Ei, Lor1_DE
	Variable E_i, DE
	
	make/o/n=1 Lor1_y0, Lor1_A, Lor1_B, Lor1_x0, Lor1_EB
	make/o/n=1 Lor1_y0sig, Lor1_Asig, Lor1_Bsig, Lor1_x0sig
	Lor1_y0=0 
	Lor1_A=0 
	Lor1_B=0 
	Lor1_x0=0 
	
	Prompt E_i, "Lowest binding energy"
	Prompt DE, "Delta E:"
	DoPrompt "Energy table:", E_i, DE
	
	Lor1_Ei=E_i
	Lor1_DE=DE
	
	Lor1_EB=Lor1_Ei
	edit Lor1_y0, Lor1_A, Lor1_B, Lor1_x0, Lor1_EB
	edit Lor1_y0sig, Lor1_Asig, Lor1_Bsig, Lor1_x0sig

End
//*****************************************************************************************


Function Lorentz2_fitting(ctrlName) : ButtonControl
	String ctrlName
	
	If(Exists("Lor2_y0")==1)
		
		Execute "Lor2_MDC()"
	else
		
		Print "Make table first!!"
	endif
End
//*****************************************************************************************

Function Lor2_table(ctrlName) : ButtonControl
	String ctrlName
	Variable/G Lor2_Ei, Lor2_DE
	Variable E_i, DE
	
	make/o/n=1 Lor2_y0, Lor2_A, Lor2_B, Lor2_x0, Lor2_C, Lor2_D, Lor2_x1,Lor2_EB
	make/o/n=1 Lor2_y0sig, Lor2_Asig, Lor2_Bsig, Lor2_x0sig, Lor2_Csig, Lor2_Dsig, Lor2_x1sig
	
	Lor2_y0=0 
	Lor2_A=0 
	Lor2_B=0 
	Lor2_x0=0 
	Lor2_C=0 
	Lor2_D=0 
	Lor2_x1=0 
	
	Prompt E_i, "Lowest binding energy"
	Prompt DE, "Delta E:"
	DoPrompt "Energy table:", E_i, DE
	
	Lor2_Ei=E_i
	Lor2_DE=DE
	
	Lor2_EB=Lor2_Ei
	edit Lor2_y0, Lor2_A, Lor2_B, Lor2_x0, Lor2_C, Lor2_D, Lor2_x1,Lor2_EB
	edit Lor2_y0sig, Lor2_Asig, Lor2_Bsig, Lor2_x0sig, Lor2_Csig, Lor2_Dsig, Lor2_x1sig

End
//*****************************************************************************************

Function ReFitting1(ctrlName) : ButtonControl
	String ctrlName
	
	Wave Lor1_y0
	If(dimsize(Lor1_y0,0)>1)
		execute "RemovePoints1()"
		Execute "Lor1_MDC()"	
	endif
End
//*****************************************************************************************

Function ReFitting2(ctrlName) : ButtonControl
	String ctrlName
	
	Wave Lor2_y0
	If(dimsize(Lor2_y0,0)>1)
		execute "RemovePoints2()"
		Execute "Lor2_MDC()"	
	endif
End
//*****************************************************************************************

Function Plot_2(ctrlName) : ButtonControl
	String ctrlName
	
	string/g Wave_name
	String/G AppWave_name
	Variable/g Wave_Number
	Variable/G Wave_Delta
	Variable/G wave_initial
	
	string WaveNameofPlot
	Variable WaveNumofPlot
	Variable WaveDeltaofplot
	Variable waveinitialofplot
	string appendwave
	variable appw
	
	Prompt wavenameofplot, "wave name:"
	Prompt wavenumofplot, "wave number:"
	Prompt wavedeltaofplot, "wave delta:"
	Prompt waveinitialofplot, "Initial Num:"
	Doprompt "Plot waves:",WaveNameofPlot, WaveNumofPlot, wavedeltaofplot,waveinitialofplot
	If(V_flag)
		return 0
	endif
	
	Prompt appw, "Do you want to show fittings?", Popup"Yes;No"
	If(appw==1)
		Prompt appendwave, "append wave:"
		doprompt "appendwave", appendwave
		If(V_flag)
			return 0
		endif
		Appwave_name=appendwave
		Wave_name=wavenameofplot
		wave_number=wavenumofplot
		Wave_delta=wavedeltaofplot
		Wave_initial=waveinitialofplot
		
		execute "PlotWaveAndFit()"
	else
		Wave_name=wavenameofplot
		wave_number=wavenumofplot
		Wave_delta=wavedeltaofplot
		Wave_initial=waveinitialofplot
	
		execute "PlotWaves()"
	endif
	
		
End
//*****************************************************************************************

Function AppendWaves(ctrlName) : ButtonControl
	String ctrlName
	
	
End

//*****************************************************************************************
//*****************************************************************************************
Proc Lor1_MDC()
	Variable/G Lor1_DE
	//wave Lor1_y0
	//wave Lor1_A
	//wave Lor1_B
	//wave Lor1_x0
	//wave Lor1_EB
	
	String MDCCopy
	string MDCfit
	Make/o/n=4 initial
	
	initial=W_coef
	
	Variable i=0
	Make/D/N=4/O W_coef
	Do
	
		W_coef=initial
		FuncFit/NTHR=0/TBOX=1016 LorFit_1 W_coef  EMDC_wave[pcsr(A),pcsr(B)] /D 
	
		initial=w_coef
		i+=1
	While(i<10)
	

	If(Dimsize(Lor1_y0,0)==1)
		
		Lor1_y0[0]=initial[0]
		Lor1_A[0]=initial[1]
		Lor1_B[0]=initial[2]
		Lor1_x0[0]=initial[3]
		
		insertPoints dimsize(lor1_y0,0), 1,Lor1_y0
		insertPoints dimsize(lor1_A,0), 1,Lor1_A
		insertPoints dimsize(lor1_B,0), 1, Lor1_B
		insertPoints dimsize(lor1_x0,0), 1,Lor1_x0
		insertPoints dimsize(lor1_EB,0),1, Lor1_EB
	else
			
		
		Lor1_y0[dimsize(Lor1_y0,0)-1]=initial[0]
		
		Lor1_A[dimsize(Lor1_A,0)-1]=initial[1]
		
		Lor1_B[dimsize(Lor1_B,0)-1]=initial[2]
		
		Lor1_x0[dimsize(Lor1_x0,0)-1]=initial[3]

		Lor1_EB[dimsize(Lor1_EB,0)-1]=Lor1_EB[dimsize(Lor1_EB,0)-2]+Lor1_DE
		
		insertPoints dimsize(lor1_y0,0), 1,Lor1_y0
		insertPoints dimsize(lor1_A,0), 1,Lor1_A
		insertPoints dimsize(lor1_B,0), 1, Lor1_B
		insertPoints dimsize(lor1_x0,0), 1,Lor1_x0
		insertPoints dimsize(lor1_EB,0),1, Lor1_EB
		
	endif
	
	Lor1_y0sig[dimsize(Lor1_y0sig,0)-1]=W_sigma[0]
		
	Lor1_Asig[dimsize(Lor1_Asig,0)-1]=W_sigma[1]
		
	Lor1_Bsig[dimsize(Lor1_Bsig,0)-1]=W_sigma[2]
		
	Lor1_x0sig[dimsize(Lor1_x0sig,0)-1]=W_sigma[3]
	
	insertPoints dimsize(lor1_y0sig,0), 1,Lor1_y0sig
	insertPoints dimsize(lor1_Asig,0), 1,Lor1_Asig
	insertPoints dimsize(lor1_Bsig,0), 1, Lor1_Bsig
	insertPoints dimsize(lor1_x0sig,0), 1,Lor1_x0sig
	
	MDCcopy=Lor1_MDC+num2str(Lor1_EB[dimsize(Lor1_EB,0)-2])
	MDCfit=Lor1_FitMDC+num2str(Lor1_EB[dimsize(Lor1_EB,0)-2])
	Duplicate EMDC_wave $MDCCopy
	Duplicate fit_EMDC_wave $MDCCopy
End
//*****************************************************************************************

Proc Lor2_MDC()
	
	Variable/G Lor2_DE
	String MDCCopy
	string MDCfit
	
	Make/o/n=7 initial
	
	initial=W_coef
	
	Variable i=0
	Make/D/N=7/O W_coef
	Do
	
		W_coef=initial
		FuncFit/NTHR=0/TBOX=1016 LorFit_2 W_coef  EMDC_wave[pcsr(A),pcsr(B)] /D 
	
		initial=w_coef
		i+=1
	While(i<10)
	

	If(Dimsize(Lor2_y0,0)==1)
		
		Lor2_y0[0]=initial[0]
		Lor2_A[0]=initial[1]
		Lor2_B[0]=initial[2]
		Lor2_x0[0]=initial[3]
		Lor2_C[0]=initial[4]
		Lor2_D[0]=initial[5]
		Lor2_x1[0]=initial[6]
		
		insertPoints dimsize(lor2_y0,0), 1,Lor2_y0
		insertPoints dimsize(lor2_A,0), 1,Lor2_A
		insertPoints dimsize(lor2_B,0), 1, Lor2_B
		insertPoints dimsize(lor2_x0,0), 1,Lor2_x0
		insertPoints dimsize(lor2_C,0), 1,Lor2_C
		insertPoints dimsize(lor2_D,0), 1, Lor2_D
		insertPoints dimsize(lor2_x1,0), 1,Lor2_x1
		insertPoints dimsize(lor2_EB,0),1, Lor2_EB
		
	else
			
		Lor2_y0[dimsize(Lor2_y0,0)-1]=initial[0]
		
		Lor2_A[dimsize(Lor2_A,0)-1]=initial[1]
		
		Lor2_B[dimsize(Lor2_B,0)-1]=initial[2]
		
		Lor2_x0[dimsize(Lor2_x0,0)-1]=initial[3]
		
		Lor2_C[dimsize(Lor2_C,0)-1]=initial[4]
		
		Lor2_D[dimsize(Lor2_D,0)-1]=initial[5]
		
		Lor2_x1[dimsize(Lor2_x1,0)-1]=initial[6]

		Lor2_EB[dimsize(Lor2_EB,0)-1]=Lor2_EB[dimsize(Lor2_EB,0)-2]+Lor2_DE
		
		insertPoints dimsize(lor2_y0,0), 1,Lor2_y0
		insertPoints dimsize(lor2_A,0), 1,Lor2_A
		insertPoints dimsize(lor2_B,0), 1, Lor2_B
		insertPoints dimsize(lor2_x0,0), 1,Lor2_x0
		insertPoints dimsize(lor2_C,0), 1,Lor2_C
		insertPoints dimsize(lor2_D,0), 1, Lor2_D
		insertPoints dimsize(lor2_x1,0), 1,Lor2_x1
		insertPoints dimsize(lor2_EB,0),1, Lor2_EB
		
	endif
	
	Lor2_y0sig[dimsize(Lor2_y0sig,0)-1]=W_sigma[0]
		
	Lor2_Asig[dimsize(Lor2_Asig,0)-1]=W_sigma[1]
			
	Lor2_Bsig[dimsize(Lor2_Bsig,0)-1]=W_sigma[2]
			
	Lor2_x0sig[dimsize(Lor2_x0sig,0)-1]=W_sigma[3]
		
	Lor2_Csig[dimsize(Lor2_Csig,0)-1]=W_sigma[4]
		
	Lor2_Dsig[dimsize(Lor2_Dsig,0)-1]=W_sigma[5]
		
	Lor2_x1sig[dimsize(Lor2_x1sig,0)-1]=W_sigma[6]
	
	insertPoints dimsize(lor2_y0sig,0), 1,Lor2_y0sig
	insertPoints dimsize(lor2_Asig,0), 1,Lor2_Asig
	insertPoints dimsize(lor2_Bsig,0), 1, Lor2_Bsig
	insertPoints dimsize(lor2_x0sig,0), 1,Lor2_x0sig
	insertPoints dimsize(lor2_Csig,0), 1,Lor2_Csig
	insertPoints dimsize(lor2_Dsig,0), 1, Lor2_Dsig
	insertPoints dimsize(lor2_x1sig,0), 1,Lor2_x1sig
	
	MDCcopy=Lor2_MDC+num2str(Lor2_EB[dimsize(Lor2_EB,0)-2])
	MDCfit=Lor2_FitMDC+num2str(Lor2_EB[dimsize(Lor2_EB,0)-2])
	Duplicate EMDC_wave $MDCCopy
	Duplicate fit_EMDC_wave $MDCCopy
End
//*****************************************************************************************

Proc RemovePoints1()
	DeletePoints dimsize(lor1_y0sig,0)-1, 1,Lor1_y0
	deletePoints dimsize(lor1_Asig,0)-1, 1,Lor1_A
	deletePoints dimsize(lor1_Bsig,0)-1, 1, Lor1_B
	deletePoints dimsize(lor1_x0sig,0)-1, 1,Lor1_x0
	DeletePoints dimsize(lor1_EB,0)-1,1, Lor1_EB
	
	DeletePoints dimsize(lor1_y0sig,0)-1, 1,Lor1_y0sig
	deletePoints dimsize(lor1_Asig,0)-1, 1,Lor1_Asig
	deletePoints dimsize(lor1_Bsig,0)-1, 1, Lor1_Bsig
	deletePoints dimsize(lor1_x0sig,0)-1, 1,Lor1_x0sig
End
//*****************************************************************************************
Proc RemovePoints2()
	DeletePoints dimsize(lor2_y0,0-1), 1,Lor2_y0
	DeletePoints dimsize(lor2_A,0)-1, 1,Lor2_A
	DeletePoints dimsize(lor2_B,0)-1, 1, Lor2_B
	DeletePoints dimsize(lor2_x0,0)-1, 1,Lor2_x0
	DeletePoints dimsize(lor2_C,0)-1, 1,Lor2_C
	DeletePoints dimsize(lor2_D,0)-1, 1, Lor2_D
	DeletePoints dimsize(lor2_x1,0)-1, 1,Lor2_x1
	DeletePoints dimsize(lor2_EB,0)-1,1, Lor2_EB
	
	DeletePoints dimsize(lor2_y0sig,0)-1, 1,Lor2_y0sig
	DeletePoints dimsize(lor2_Asig,0)-1, 1,Lor2_Asig
	DeletePoints dimsize(lor2_Bsig,0)-1, 1, Lor2_Bsig
	DeletePoints dimsize(lor2_x0sig,0)-1, 1,Lor2_x0sig
	DeletePoints dimsize(lor2_Csig,0)-1, 1,Lor2_Csig
	DeletePoints dimsize(lor2_Dsig,0)-1, 1, Lor2_Dsig
	DeletePoints dimsize(lor2_x1sig,0)-1, 1,Lor2_x1sig
End
//********************************************************************************
proc PlotWaveAndFit()
	string/g Wave_name
	string appwave_name
	Variable/g Wave_Number
	variable/G wave_delta
	Variable/G wave_initial
	
	string dataname1
	string dataname2
	variable i
	i=1
	
	dataname1=wave_name+num2str(wave_initial)
	display $dataname1
	
	Do
		dataname1=wave_name+num2str(wave_initial+wave_delta*i)
		i+=1
		Appendtograph $dataname1
	While(i<wave_number)
	
	i=0
	Do
		dataname2=appwave_name+num2str(wave_initial+wave_delta*i)
		i+=1
		Appendtograph $dataname2
	While(i<wave_number)
	

end
//********************************************************************************

proc PlotWaves()
	string/g Wave_name
	Variable/g Wave_Number
	variable/G wave_delta
	Variable/G wave_initial
	
	string dataname
	variable i
	i=0
	
	dataname=wave_name+num2str(wave_initial)
	display $dataname
	
	Do
		dataname=wave_name+num2str(wave_initial+wave_delta*i)
		i+=1
		Appendtograph $dataname
	While(i<wave_number)
	
end
//********************************************************************************





