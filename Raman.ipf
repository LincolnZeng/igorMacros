#pragma rtGlobals=1		// Use modern global access method.



Variable/G GV_Ramandata

//********************************************************************************************************************************	
Window Panel_Raman() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(1114,627,1471,757)
	ModifyPanel cbRGB=(0,0,0)
	Button button0,pos={20,18},size={70,20},proc=ButtonProc_1,title="Load txt"
	Button button1,pos={97,18},size={70,20},proc=ButtonProc_2,title="Display 1"
	Button button2,pos={173,18},size={70,20},proc=ButtonProc_3,title="Append 1"
	Button button3,pos={97,42},size={70,20},proc=ButtonProc_5,title="Sequence"
	Button button5,pos={248,17},size={70,20},proc=ButtonProc_7,title="Edit 1"
	Button button6,pos={13,86},size={90,20},proc=ButtonProc_8,title="Ramanploter"
	Button button6,fColor=(65535,32764,16385)
	Button button4,pos={14,62},size={85,20},proc=ButtonLoadRamanmat_tx,title="Load map tx"
EndMacro
//********************************************************************************************************************************	
Window Ramanploter() : Graph
	PauseUpdate; Silent 1		// building window...
	Display /W=(492,228,954,698) The_Ramanplot_1 vs The_Ramanplot_0
	ModifyGraph wbRGB=(38523,48916,65535),gbRGB=(65535,65535,62965)
	ModifyGraph tick=2
	ModifyGraph mirror=1
	Label left "\\Z22\\F'times'Intensity (arbitrary units)"
	Label bottom "\\Z22\\F'times'Raman shift (cm\\Z18\\S-1\\M\\Z22\\F'times')"
	ControlBar 36
	SetVariable setvar_Ramandata,pos={15,7},size={100,20},proc=SetVarProc_RamanData,title="Data"
	SetVariable setvar_Ramandata,fSize=14
	SetVariable setvar_Ramandata,limits={1,inf,1},value= GV_Ramandata,live= 1
	PopupMenu popup0,pos={125,7},size={50,20},proc=PopMenuProc_7
	PopupMenu popup0,mode=1,popColor= (65535,0,0),value= #"\"*COLORPOP*\""
	Button button0,pos={316,7},size={55,20},proc=ButtonProc_9,title="Original"
	Button button1,pos={263,7},size={50,20},proc=ButtonProc_10,title="Edit"
	Button button2,pos={180,7},size={50,20},proc=ButtonProc_11,title="Update"
EndMacro
//********************************************************************************************************************************	
//********************************************************************************************************************************	
//********************************************************************************************************************************	
Function SetVarProc_RamanData(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	Execute "plot_Ramanploter()"
End
//********************************************************************************************************************************	
//********************************************************************************************************************************	
Function ButtonProc_1(ctrlName) : ButtonControl
	String ctrlName
	Execute "LoadRamantxt()"
End
//********************************************************************************************************************************	
Function ButtonProc_2(ctrlName) : ButtonControl
	String ctrlName
	Execute"Display1Raman()"
End
//********************************************************************************************************************************	
Function ButtonProc_3(ctrlName) : ButtonControl
	String ctrlName
	Execute"Append1Raman()"
End
//********************************************************************************************************************************	
Function ButtonProc_5(ctrlName) : ButtonControl
	String ctrlName
	Execute"DisplayRaman_seq()"
End
//********************************************************************************************************************************	
Function ButtonProc_6(ctrlName) : ButtonControl
	String ctrlName
	Execute"Copy_originals()"
End
//********************************************************************************************************************************	
Function ButtonProc_7(ctrlName) : ButtonControl
	String ctrlName
	Execute"Edit1Raman()"
End
//********************************************************************************************************************************	
Function ButtonProc_Ramanploter(ctrlName) : ButtonControl
	String ctrlName
	If(wintype("ramanploter")==0)
		Execute "ramanploter()"
		Else
			DoWindow/F dataploter
	Endif	
End
//********************************************************************************************************************************	
Function ButtonProc_10(ctrlName) : ButtonControl
	String ctrlName
	Execute "EditthisRaman()"
End
//********************************************************************************************************************************	
Function ButtonProc_9(ctrlName) : ButtonControl
	String ctrlName
	Execute "Recoverthis_Raman()"
	Execute "setup_Ramanploter()"
End
//********************************************************************************************************************************	
Function ButtonProc_11(ctrlName) : ButtonControl
	String ctrlName
	Execute "setup_Ramanploter()"
End
//********************************************************************************************************************************	
Function PopMenuProc_7(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	String toexecute
	toexecute="ModifyGraph rgb(The_Ramanplot_1)="+popStr
	Execute toexecute
End
//********************************************************************************************************************************	
Function ButtonProc_8(ctrlName) : ButtonControl
	String ctrlName
	If(wintype("Ramanploter")==0)
		Execute "setup_Ramanploter()"
		Execute "Ramanploter()"
		Else
			DoWindow/F Ramanploter
	Endif	
End
//********************************************************************************************************************************	


//********************************************************************************************************************************	
Proc setup_Ramanploter() 
	PauseUpdate; Silent 1	
	Variable/G GV_Ramandata
	String thiswave0,thiswave1
	thiswave0=RamanFileName[GV_Ramandata]+"_0"
	thiswave1=RamanFileName[GV_Ramandata]+"_1"
	Duplicate/O $thiswave0 The_Ramanplot_0
	Duplicate/O $thiswave1 The_Ramanplot_1		
End	
//********************************************************************************************************************************	
Proc LoadRamantxt()
	PauseUpdate; Silent 1	
	setDataFolder Root:
	newpath /O tempPath
	String Pathname="tempPath"
	Variable  Loadn=ItemsInList(IndexedFile($PathName,-1,".txt"))
//	print IndexedFile($PathName,-1,".txt")
	String  savedDataFolder=getDataFolder(1)
	String 	Filename, FolderName,Base_Filename
	Variable Ramanbeforeload
	Variable n,m
	String objName
	String Raman_original0,Raman_original1
	String thiswave0,thiswave1
	If(Exists("RamanFileName")==0)
		Make/T/N=1 RamanfullFileName
		Make/T/N=1 RamanFileName
		Edit RamanFileName		
		Ramanbeforeload=1
		Else
			Ramanbeforeload=Dimsize(RamanFileName,0)
	Endif		
	m=loadn-Ramanbeforeload+1
	InSertPoints Ramanbeforeload, m,RamanfullFileName
	InSertPoints Ramanbeforeload, m,RamanFileName
	string mat
	n=Ramanbeforeload
	Do
		Filename=IndexedFile($PathName,n-1,".txt")
		print Filename
		RamanfullFileName[n]=FileName
		RamanFileName[n]=FileName[0,strlen(Filename)-5]
		Base_Filename=RamanfileName[n]+"_"
		loadwave/A=$Base_Filename /Q/G/L={0,0,0,0,2} /P=$PATHName FileName	
		thiswave0=RamanFileName[n]+"_0"
		thiswave1=RamanFileName[n]+"_1"
		Raman_original0=thiswave0+"C"
		Raman_original1=thiswave1+"C"
		Duplicate $thiswave0 $Raman_original0
		Duplicate $thiswave1 $Raman_original1		
		n+=1	
	While(n<=Loadn)
	setDataFolder $savedDataFolder			
End
//********************************************************************************************************************************	
Proc Display1Raman(datanumber)
	Variable datanumber
	Prompt datanumber,"Data number" 
	PauseUpdate; Silent 1	
	String R_intensity, R_shift
	R_shift=RamanFileName[datanumber]+"_0"
	R_intensity=RamanFileName[datanumber]+"_1"
	Display $R_intensity vs $R_shift
	End	
//********************************************************************************************************************************	
Proc Append1Raman(datanumber)
	Variable datanumber
	Prompt datanumber,"Data number" 
	PauseUpdate; Silent 1	
	String R_intensity, R_shift
	R_shift=RamanFileName[datanumber]+"_0"
	R_intensity=RamanFileName[datanumber]+"_1"
	appendtograph $R_intensity vs $R_shift
End	
//********************************************************************************************************************************	
Proc DisplayRaman_seq(datanumbers)
	string datanumbers
	Prompt datanumbers,"Enter the sequence of data numbers" 
	PauseUpdate; Silent 1	
	String R_intensity, R_shift
	Variable total_data
	Variable i
	total_data=Itemsinlist(datanumbers,";")
	Display
	i=0
	Do
		R_shift=RamanFileName[str2num(stringfromlist(i,datanumbers,";"))]+"_0"
		R_intensity=RamanFileName[str2num(stringfromlist(i,datanumbers,";"))]+"_1"
		Appendtograph $R_intensity vs $R_shift
		i+=1
	While(i<total_data)
End	
//********************************************************************************************************************************	
Proc Copy_originals()
	PauseUpdate; Silent 1	
	String thisname0,thisname1,thisname0C,thisname1C
	Variable i
	i=1
	Do
		Thisname0=RamanFileName[i]+"_0"
		Thisname1=RamanFileName[i]+"_1"
		Thisname0C=RamanFileName[i]+"_0C"
		Thisname1C=RamanFileName[i]+"_1C"
		Duplicate $Thisname0 $Thisname0C
		Duplicate $Thisname1 $Thisname1C			
		i+=1
	While(i<dimsize(RamanFileName,0))
End	
//********************************************************************************************************************************	
Proc Recoverthis_Raman()
	PauseUpdate; Silent 1	
	Variable/G GV_Ramandata
	String thisname0,thisname1,thisname0C,thisname1C
	Thisname0=RamanFileName[GV_Ramandata]+"_0"
	Thisname1=RamanFileName[GV_Ramandata]+"_1"
	Thisname0C=RamanFileName[GV_Ramandata]+"_0C"
	Thisname1C=RamanFileName[GV_Ramandata]+"_1C"
	Duplicate/O $Thisname0C $Thisname0
	Duplicate/O $Thisname1C $Thisname1			
End
//********************************************************************************************************************************	
Proc Edit1Raman(datanumber)
	Variable datanumber
	Prompt datanumber,"Data number" 
	PauseUpdate; Silent 1	
	String R_intensity, R_shift
	R_shift=RamanFileName[datanumber]+"_0"
	R_intensity=RamanFileName[datanumber]+"_1"
	Edit $R_shift,$R_intensity
End	
//********************************************************************************************************************************	
Proc EditthisRaman()
	PauseUpdate; Silent 1	
	Variable/G GV_Ramandata
	String R_intensity, R_shift
	R_shift=RamanFileName[GV_Ramandata]+"_0"
	R_intensity=RamanFileName[GV_Ramandata]+"_1"
	Edit $R_shift,$R_intensity
End	
//********************************************************************************************************************************	
Proc plot_Ramanploter()
	PauseUpdate; Silent 1	
	Variable/G GV_Ramandata
	String newname0,newname1
	newname0=RamanFileName[GV_Ramandata]+"_0"
	newname1=RamanFileName[GV_Ramandata]+"_1"	
	Duplicate/O $newname0 The_Ramanplot_0		
	Duplicate/O $newname1 The_Ramanplot_1		
End
//********************************************************************************************************************************	
Proc LoadRamanmat_tx()
	PauseUpdate; Silent 1	
	setDataFolder Root:
	newpath /O tempPath
	String Pathname="tempPath"
	Variable  Loadn=ItemsInList(IndexedFile($PathName,-1,".tx"))
	String  savedDataFolder=getDataFolder(1)
	String 	Filename, FolderName,Base_Filename
	Variable Ramanbeforeload
	Variable n,m
	Variable condition
	Variable thisdeltax,thisdeltay
	Variable thedeltax,thedeltay	
	Variable xfirst,yfirst
	Variable numofx,numofy
	Variable i,j
	Variable thisdeltaofE,thisnumofE
	String objName
	String Raman_original0,Raman_original1
	String thiswave0,thiswave1
	String thisname
	String this3Dname
	If(Exists("RamanmatFileName")==0)
		Make/T/N=1 RamanfullmatFileName
		Make/T/N=1 RamanmatFileName
		Edit RamanmatFileName		
		Ramanbeforeload=1
		Else
			Ramanbeforeload=Dimsize(RamanmatFileName,0)
	Endif		
	m=loadn-Ramanbeforeload+1
	InSertPoints Ramanbeforeload, m,RamanfullmatFileName
	InSertPoints Ramanbeforeload, m,RamanmatFileName
	string mat
	n=Ramanbeforeload
	Do
		Filename=IndexedFile($PathName,n-1,".tx")
		print Filename
		RamanfullmatFileName[n]=FileName
		RamanmatFileName[n]=FileName[0,strlen(Filename)-4]
		Base_Filename=RamanmatfileName[n]+"_"
		loadwave/A=$Base_Filename /Q/D/J/L={0,0,0,2,0}/M /P=$PATHName FileName	
		Base_Filename=RamanmatfileName[n]+"_"
		loadwave/A=$Base_Filename /Q/D/G/L={0,0,0,0,2}/M /P=$PATHName FileName
		thisname=Base_Filename+"1"
		
		Make/O/N=1 waveofx
		waveofx[0]=$thisname[0][0]
		Make/O/N=1 waveofy
		waveofy[0]=$thisname[0][1]
		LoadRamanmat_tx1($thisname,waveofx,waveofy)
		
		thisname=Base_Filename+"0"		
		Make/O/N=(dimsize($thisname,1)) thisenergywave
		thisenergywave[]=$thisname[0][p]
		Make/O/N=(dimsize($thisname,1)-1) thisdiffenergywave
		thisdiffenergywave[]=thisenergywave[p+1]-thisenergywave[p]
		Wavestats/Q thisdiffenergywave
		thisdeltaofE=V_min/1.5
		thisnumofE=Ceil((thisenergywave[dimsize(thisenergywave,0)-1]-thisenergywave[0])/thisdeltaofE)		
		this3Dname=Base_Filename+"3D"
		Make/O/N=(dimsize(waveofx,0),thisnumofE,dimsize(waveofy,0)) $this3Dname
		wavestats/Q waveofx
		Setscale/I  x,V_min,V_max,""$this3Dname
		Setscale/I  y,thisenergywave[0],thisenergywave[dimsize(thisenergywave,0)-1],""$this3Dname		
		wavestats/Q waveofy
		Setscale/I  z,V_min,V_max,""$this3Dname
		LoadRamanmat_tx2($this3Dname,$thisname,thisenergywave)
		n+=1	
	While(n<=Loadn)
	killwaves waveofx,waveofy,thisdiffenergywave,thisenergywave
	setDataFolder $savedDataFolder			
End
//********************************************************************************************************************************	
Function LoadRamanmat_tx1(thisname,waveofx,waveofy)
	Wave thisname
	wave waveofx
	wave waveofy
	PauseUpdate; Silent 1	
	Variable condition
	Variable i,j
	i=1
	If(dimsize(thisname,1)>1)
		Do
			j=0
			condition=1
			Do
				IF(abs((waveofx[j]-thisname[i][0])/thisname[i][0])<0.001)
					condition=0
					j=dimsize(waveofx,0)
				Endif
				j+=1
			While(j<dimsize(waveofx,0))
			IF(condition==1)
				Insertpoints 0,1,waveofx
				waveofx[0]=thisname[i][0]
			Endif
			i+=1
		While(i<dimsize(thisname,0))	
	Endif
	i=1
	If(dimsize(thisname,1)>1)
		Do
			j=0
			condition=1
			Do
				IF(abs((waveofy[j]-thisname[i][1])/thisname[i][1])<0.001)
					condition=0
					j=dimsize(waveofy,0)
				Endif
				j+=1
			While(j<dimsize(waveofy,0))
			IF(condition==1)
				Insertpoints 0,1,waveofy
				waveofy[0]=thisname[i][1]
			Endif
			i+=1
		While(i<dimsize(thisname,0))	
	Endif
End
//********************************************************************************************************************************	
Function LoadRamanmat_tx2(this3Dname,thisname,thisenergywave)
	Wave this3Dname
	Wave thisname
	wave thisenergywave
	PauseUpdate; Silent 1	
	Variable i,j
//		$this3Dname[][][]=$thisname[p*r+r+1][q]
	i=0
	Do
		j=0
		Do
			Make/O/N=(dimsize(thisname,1)) thisintensity
			thisintensity[]=thisname[i*j+j+1][p]
			this3Dname[i][][j]=interp(dimoffset(this3Dname,1)+q*dimdelta(this3Dname,1),thisenergywave,thisintensity)
			j+=1
		While(j<dimsize(this3Dname,2))			
		i+=1
	While(i<dimsize(this3Dname,0))
	killwaves thisintensity	
End
//********************************************************************************************************************************	
Function ButtonLoadRamanmat_tx(ctrlName) : ButtonControl
	String ctrlName
	Execute "LoadRamanmat_tx()"
End
//********************************************************************************************************************************	






