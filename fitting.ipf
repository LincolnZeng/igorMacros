#pragma rtGlobals=1		// Use modern global access method.
Window VSFitting() : Panel

	If(wintype("visualfitting")==0)
		
		Make_Preset()
		String popupChoice="\""
		Variable i=0
		Do
			PopupChoice+=T_funcPreset[i][0]+";"	
			i+=1	
		While(i<dimsize(T_funcPreset,0))		
		Popupchoice+="\""
		
		if(exists("T_FitFunc")==0)
			Make/o/n=1/T T_FitFunc
		endif
		String/G T_ToFit
		Variable/G T_SubFunc
		Variable/G T_Conv
		Variable/G T_ConvRes

		PauseUpdate; Silent 1		// building window...
		NewPanel /W=(307,170,1103,643)
		ShowTools/A
		PopupMenu popup_preset,pos={100,15},size={200,20},title="Function Preset",proc=pop_preset
		PopupMenu popup_preset,mode=1,value= #PopupChoice
		Button button_AutoFill,pos={617,10},size={120,26},title="AutoFill",proc=But_Autofill
		Button button_RestartWindow,pos={450,15},size={107,20},title="RESTART Window",proc=But_restart
		Button button_RestartWindow,disable=1
		
		Button button_fit,pos={12,45},size={69,38},title="\\Z16Fit",Proc=but_fit
		Button button_SetConstrFitting,pos={15,94},size={65,35},proc=But_SetConstrFitting,title="Set\rConstr"
		SetVariable setvar_func,pos={100,54},size={1438,16},title="Function"
		SetVariable setvar_func,value= T_FitFunc[0]
		SetVariable setvar1_Tofit,pos={129,86},size={249,16},title="WaveToFit"
		SetVariable setvar1_Tofit,value= T_ToFit
		SetVariable setvar_SubNo,pos={129,115},size={182,16},title="SubFunc NO.",value= T_SubFunc
		SetVariable setvar_SubNo,limits={1,inf,1}
		CheckBox check_Conv,pos={404,85},size={120,14},title="Gauss Convolution"
		CheckBox check_Conv,Variable= T_conv
		SetVariable setvar_Res,pos={421,108},size={86,16},title="Res"
		SetVariable setvar_Res,limits={0,inf,.01},Value= T_ConvRes
		Button button_GetSub,pos={617,88},size={120,26},title="GetSubFunc",proc=But_GetSub
		Button button_GetVar,pos={15,158},size={65,35},title="Get\rVariable",Proc=But_GetVar
		Button button_Draw,pos={15,200},size={65,35},title="Draw",Proc=But_Draw
	
		Button button_GetVar disable=3
		Button button_Draw disable=3
	
	Else
		dowindow/f visualfitting
	endif
	
EndMacro

Function Make_preset() // window creatation function

	Make/o/T/N=(5,2) T_FuncPreset
	T_funcPreset[0][0]="2Gaussian"
	T_funcPreset[0][1]="TWCoef[0]+ TWCoef[1]*exp(-((x-TWcoef[3])/TWcoef[2])^2)+ TWCoef[4]*exp(-((x-TWcoef[6])/TWcoef[5])^2)"
	
	T_funcPreset[1][0]="2Lorenzian"
	T_funcPreset[1][1]="TWCoef[0]+ TWCoef[1]/((x-TWCoef[2])^2+TWCoef[3])+ TWCoef[4]/((x-TWCoef[5])^2+TWCoef[6])"
	
	T_funcPreset[2][0]="FermiFunction"
	T_funcPreset[2][1]="(TWCoef[0]+TWCoef[1]*x)* 1/(exp((x-TWCoef[2])/(1.38e-23*TWCoef[3]/1.6e-19))+1)+ TWCoef[4]+TWCoef[5]*x"
	
	T_funcPreset[3][0]="Fermi x Lorenzian"
	T_funcPreset[3][1]="TWCoef[0]+ 1/(exp((x-TWCoef[1])/(1.38e-23*TWCoef[2]/1.6e-19))+1)* (TWCoef[3]+TWCoef[4]/((x-TWCoef[5])^2+TWCoef[6]))"

	T_funcPreset[4][0]="Asymmetirc core level peak"
	T_funcPreset[4][1]="TWCoef[0]+ TWCoef[1]*cos(pi*TWCoef[2]/2+(1-TWCoef[2])*atan((x-TWCoef[3])/TWCoef[4]))/((x-TWCoef[3])^2+TWCoef[4]^2)^((1-TWCoef[2])/2)"

End

Function Pop_Preset(ctrlName,popNum,popStr) : PopupMenuControl 
	String ctrlName
	Variable popNum
	String popStr
	
	wave/t T_funcpreset
	wave/t T_fitFunc
	
	T_fitfunc[0]=t_funcpreset[popNum-1][1]
End

Function NSubinString(substr,str)
	string substr
	string str
	
	return ( strlen(str)-strlen(replacestring(substr,str,"")) )/strlen(substr)
	
End

Function But_GetSub(ctrlName) : ButtonControl 
	String ctrlName
	Variable/G T_subFunc
	Wave T_Fitfunc
	PauseUpdate
	Silent 1
	
	Button button_GetVar disable=0
	Button button_Draw disable=0
	
//->Clear old controls

	string allcontrols
	allcontrols = controlnamelist("vsfitting")
	variable NControl=NsubinString("setvar_sub",allcontrols)
	string names2kill
	variable i
	For(i=1;i<=ncontrol;i+=1)
		names2kill="setvar_sub"+num2str(i)
		KillControl /W=VSfitting $names2kill
		names2kill="setvar_"+num2str(i)
		KillControl /W=VSfitting $names2kill		
	endfor

//<-clear old controls	
	
	Make/n=(T_subfunc+1)/o TWcoefNo
	
	Variable Posx=100,Posy=157,boxw=1001,Boxh=16
	String SetvarName,setvartitle,setvarnum
	
	Variable count=1
	Do
		SetvarName="setvar_sub"+num2str(count)
		setvarnum="setvar_"+num2str(count)
		setvartitle="Sub"+num2str(count)
		Posy=157+(count-1)*75
		
		SetVariable $Setvarnum,pos={posx,posy+30},size={30,16},title=" "
		SetVariable $Setvarnum,limits={1,inf,1},value= TWCoefNo[count]
		
		if (Dimsize(T_fitFunc,0)-1<count)
			insertpoints dimsize(T_fitFunc,0),1,T_FitFunc
		endif
		
		SetVariable $SetvarName,pos={posx,posy},size={1001,16},title=setvartitle
		SetVariable $SetvarName,value= T_fitFunc[count]
		
		Count+=1
	While(Count<=T_SubFunc)
	
End

Function But_GetVar(ctrlName) : ButtonControl  
	String ctrlName
	wave TWcoefNo


//->Clear old controls

	string allcontrols
	allcontrols = controlnamelist("vsfitting")
	variable NControl=NsubinString("setvarTW",allcontrols)
	string names2kill
	variable i
	For(i=0;i<ncontrol;i+=1)
		names2kill="setvarTW"+num2str(i)
		KillControl /W=VSfitting $names2kill
		names2kill="setvarRange"+num2str(i)
		KillControl /W=VSfitting $names2kill		
	endfor

//<-clear old controls	
	
	PauseUpdate
	Silent 1
	Make/o/n=(sum(twcoefno)) TWCoef
	Make/o/n=(sum(twcoefno)) TWCoefAdjust
	
	Variable Posx=100,Posy=150,boxw=130,Boxh=16
	Variable/G T_SubFunc
	Variable count=1,totalcount=0
	String setvartitle,setvarname,setvarrangename
	
	Do
	
		Variable Sub_count=1
		for (Sub_count=1;Sub_count<=TWcoefNo[count];Sub_count+=1)
			posx=160+150*(sub_count-1)
			posy=180+75*(count-1)
			setvartitle="TWcoef"+num2str(totalcount)
			setvarname="setvarTW"+num2str(totalcount)
			setvarrangename="setvarRange"+num2str(totalcount)
			SetVariable $setvarname,pos={posx,posy},size={boxw,boxh},title=setvartitle,limits={-inf,inf,0},value= TWCoef[totalcount],proc=setvar_updatePlot
			SetVariable $setvarrangename,pos={posx,posy+20},size={boxw,boxh},title="constr",limits={0,inf,0},value= TWCoefadjust[totalcount]//,proc=setvar_updateLimit			//usage changed, to constraint
			TWCoefAdjust=inf
			totalcount+=1
		EndFor	
		
		Count+=1
	While(Count<=T_SubFunc)
	
	make/o/T/n=0 TW_VSConstraint
End


Function setvar_updatePlot(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	VSF_updatePlot()
End

#if(0) ///////////////usage changed, to constraint
Function setvar_updateLimit(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	variable NUM
	String setvarname
	num=str2num(ReplaceString("setvarRange", ctrlname, ""))
	setvarname="setvarTW"+num2str(Num)
	SetVariable $setvarname,limits={-inf,inf,varNum}
	
End
#endif 

Function VSF_updatePlot()

	Wave/T T_FitFunc
	Variable/g T_SubFunc
	String/G T_Tofit
	String Wname,funcname
	String T_toEXE
	
	Variable/G T_Conv
	Variable/G T_ConvRes

	Variable i
	For(i=0;i<=T_SubFunc;i+=1)
			Wname="VSFit_Sub"+num2str(i)
			funcname=T_FitFunc[i]
			Duplicate/o $T_Tofit $Wname
			T_ToEXE=Wname+"="+Funcname
			Execute T_toEXE
			
			if(T_conv==1)
				conv1d($WName,t_convRes)
			endif
	Endfor
	
	if(T_conv==1)
		if(wintype("T_GaussPlot")==0)
			Display/n=T_GaussPlot as "Resolution Curve"
			Appendtograph T_Gauss
//			Else
//			dowindow/f T_GaussPlot
		endif
	endif

End

Function But_Draw(ctrlName) : ButtonControl  
	String ctrlName
	
	String/G T_Tofit

	If(wintype("VisualfittingPlot")==0)
		Display/n=VisualFittingPlot as "VisualFitting"
		Appendtograph/c=(0,0,0) $T_ToFit
		ModifyGraph lsize($T_ToFit)=2
		VSF_updatePlot()
	
		String Wname
		Variable/G T_subFunc
		Variable i
		For(i=0;i<=T_SubFunc;i+=1)
			Wname="VSFit_Sub"+num2str(i)
			Appendtograph/c=(0,0,65535) $WName
		Endfor
		ModifyGraph lsize(VSFit_Sub0)=2, rgb(VSFit_Sub0)=(65535,0,0)
	
	Else
		Dowindow/f visualfittingplot
	Endif
	
End

Function But_SetConstrFitting(ctrlName) : ButtonControl  
	String ctrlName
	
	wave TWCoef
	wave TWCoefadjust
	variable i
	Variable coefsize=dimsize(TWcoefadjust,0)
	variable cnstrsize
	make/T/o/n=0 TW_VSconstraint
	for (i=0;i<coefsize;i+=1)
		if(TWCoefadjust[i]!=inf)
			cnstrsize=dimsize(TW_VSconstraint,0)
			insertpoints cnstrsize,2,TW_VSconstraint
			TW_VSconstraint[cnstrsize]="K"+num2str(i)+"<"+num2str(TWCoef[i]+TWcoefAdjust[i])
			TW_VSconstraint[cnstrsize+1]="K"+num2str(i)+">"+num2str(TWCoef[i]-TWCoefadjust[i])
		endif
	endfor
	
	if(wintype("Constraint_Table")==2)
		dowindow/f Constraint_Table
	else
		edit/N=Constraint_Table; appendtotable TW_VSconstraint
	endif

End

Function But_Fit(ctrlName) : ButtonControl  
	String ctrlName

	wave TWCoef
	String/g T_ToFit
	
	variable startx,endx
	if(cmpstr(csrinfo(a),"")&&cmpstr(csrinfo(b),"")) //if both cursors are on the graph, then use the cursor range.
		if(xcsr(a)<xcsr(b))
			startx=xcsr(a)
			endx=xcsr(b)
		Else
			startx=xcsr(b)
			endx=xcsr(a)
		Endif
	else														//if not both cursors on, use the full range.
		startx=dimoffset($T_ToFit,0)
		endx=dimoffset($T_ToFit,0)+(dimsize($T_ToFit,0)-1)*dimdelta($T_ToFit,0)
	endif
	
	duplicate/o $T_ToFit xw; 	xw=x
	FuncFit/Q AAOFunc TWCoef $T_ToFit(startx,endx) /x=xw /D /A=0 /R /C=TW_VSconstraint
	
	VSF_updatePlot()
End

Function But_Autofill(ctrlName) : ButtonControl  
	String ctrlName
	
	Wave/T T_fitFunc
	Wave TWcoefNO
	Variable/G T_subFunc
	T_SubFunc=ItemsInList(T_fitfunc[0]," ")
	But_getSub("Button_GetSub")
	
	String TempSTR
	Variable i
	For(i=1;i<=T_SubFunc;i+=1)
		T_FitFunc[i]=stringfromlist(i-1,T_FitFunc[0]," ")
		If(i<T_subFunc)
			TempSTR=T_fitFunc[i]
			T_FitFunc[i]=tempSTR[0,strlen(tempSTR)-2]
		Endif
	EndFor	
	
	Variable prelen,latlen; string temp_funcName
	For(i=1;i<=T_Subfunc;i+=1)
		temp_funcname=T_fitFunc[i]
		prelen=strLen(temp_funcname)
		temp_funcname=replaceString("TWCOEF[",upperstr(temp_FuncName),"")
		latlen=strlen(temp_funcname)
		TWCoefNO[i]=(prelen-latlen)/7
	endFor
	
	But_GetVar("button_GetVar")	
End

Function But_restart(ctrlName) : ButtonControl  
	String ctrlName
	
	Dowindow/K VSFitting
	Execute "VSFitting()" 
	print exists(ctrlname)
End

Function AAOfunc(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	Wave/T T_FitFunc
	
	Variable/G T_Conv
	Variable/G T_ConvRes
	
	String ToEXE
	Duplicate/o yw t_yw
	Duplicate/o pw t_pw
	ToEXE="t_yw="+ReplaceString("TWCoef", T_FitFunc[0], "t_pw")
	Execute toEXE //No pw or yw in Execute, have to use t_yw instead. 
	
	if(T_conv==1)
		conv1d(t_yw,t_convRes)
	endif
	
	yw=t_yw

End

Function conv1D(srcWave,Res)
	
	Wave Srcwave
	Variable Res
	
	variable gmid,gsum
	Duplicate/o srcWave T_Gauss
	gmid=dimoffset(srcWave,0)+dimdelta(srcWave,0)*DimSize(srcwave,0)/2
	T_Gauss=exp(-(x-gmid)*(x-gmid)/res/res)
	gsum=sum(T_Gauss);T_Gauss/=gsum //it is a must to normalize!!

	Variable HalfSize,srcSize2
	HalfSize=ceil(dimsize(srcwave,0)/2)
	insertpoints 0,HalfSize,srcWave; srcWave[,HalfSize-1]= srcWave[HalfSize]
	srcSize2=dimsize(srcWave,0);	insertpoints srcSize2,HalfSize,srcWave;		srcWave[srcsize2,]=srcWave[srcSize2-1]
	convolve/a T_Gauss srcWave
	deletepoints srcSize2,HalfSize,srcWave;		deletepoints 0,HalfSize, srcWave
	
//	killwaves T_Gauss	

//print 0.37867*(sqrt(^2-^2))	
//print 0.335358*(sqrt(^2-^2))	
End
