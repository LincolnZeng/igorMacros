	#pragma rtGlobals=1		// Use modern global access method.

//*******************************************************************************************************************************
Proc BKFA_Shiftdata()
	Pauseupdate
	Silent 1;
	String oldname
	String newname
	String windowname
	Variable i
	i=24  //31
	Do
		oldname="data"+num2str(i)
		newname="s"+oldname
		windowname=newname+"_window"
		Duplicate/O $oldname $newname
		Setscale/P y,dimoffset($oldname,1)-16.825,dimdelta($oldname,1),""$newname
		If(wintype(windowname)==0)
			Display; dowindow/C $windowname; appendimage $newname;ModifyImage $newname ctab={*,*,PlanetEarth,1};ModifyGraph width=140,height=225
			Else
				dowindow/F $windowname;ModifyImage $newname ctab={*,*,PlanetEarth,1};ModifyGraph width=140,height=225				
		Endif
		$newname[60][]=0.5*($newname[59][q]+$newname[61][q])
//		if(i!=13)
//			Dowindow/F $windowname; ModifyGraph width=175,height=225	
//			TextBox/C/N=text0/X=37.71/Y=44.00
//		endif
		i+=1
	While(i<25)//dimsize(File_name,0))
End
//*******************************************************************************************************************************
Proc BKFA_Symmat()
	Pauseupdate
	Silent 1
	String oldname
	String newname
	String windowname
	Variable i
	i=24
	Do
		oldname="sdata"+num2str(i)
		newname=oldname+"sym"
		windowname=oldname+"sym_window"
		sym_edc_matrix_far(oldname)
		If(Wintype(windowname)==0)
			Dowindow/C $windowname;ModifyImage $newname ctab={*,*,PlanetEarth,1};ModifyGraph width=140,height=225
			Else
			 	Dowindow/F $windowname;ModifyImage $newname ctab={*,*,PlanetEarth,1};ModifyGraph width=140,height=225
		Endif
//		TextBox/C/N=text0/X=-0.71/Y=0
		$newname[60][]=0.5*($newname[59][q]+$newname[61][q])
		i+=1
	While(i<25)//dimsize(File_name,0))
End
//*******************************************************************************************************************************
Proc BKFA_SymmatEDC(thepnt,num2comb)
	Variable thepnt=1
	Variable num2comb=5
	Prompt thepnt,"Enter the point (1 or 2):"
	Prompt num2comb,"Number of EDC to combine (odd):"
	Pauseupdate
	Silent 1
	String thisedc
	String thismat,listongraph,thistrace
	String windowname
	String Twave,iwave,nicewave
	Variable i, j, index,numongraph,avgnum
	Twave="Tatpnt"+num2str(thepnt)
	iwave="iatpnt"+num2str(thepnt)
	nicewave="nicepnts"+num2str(thepnt)
	i=0
	DO
		windowname="Tdep_at_"+num2str($nicewave[i])
		if(Wintype(windowname)==0)
			Display;Dowindow/C $windowname
			Else
				Dowindow/F $windowname
				listongraph=TraceNameList(windowname, ";", 1)
				numongraph=ItemsInList(listongraph,";")
				j=0
				Do
					thistrace=StringFromList(j,listongraph,";")
					Removefromgraph $thistrace
					j+=1
				While(j<numongraph)
		Endif
		j=0
		Do
			thismat="sdata"+num2str($iwave[j])+"sym"
			thisedc="pnt"+num2str(thepnt)+"T"+num2str($Twave[j])+"slice"+num2str($nicewave[i])
			Make/O/N=(dimsize($thismat,1)) $thisedc
			Setscale/P x,dimoffset($thismat,1),dimdelta($thismat,1),""$thisedc
			$thisedc[]=0
			index=$nicewave[i]-(num2comb-1)/2
			Do
				$thisedc[]+=$thismat[index][p]
				index+=1
			While(index<$nicewave[i]+(num2comb-1)/2+1)
			$thisedc[]/=num2comb
			avgnum=mean($thisedc,pnt2x($thisedc,0),pnt2x($thisedc,20))
			$thisedc[]/=avgnum
			Appendtograph $thisedc
			j+=1
		While(j<dimsize($Twave,0))
		i+=1
	While(i<dimsize($nicewave,0))
End
//*******************************************************************************************************************************
Proc BKFA_Fit1FD1L(slicenum,pntnum)
	Variable slicenum
	Variable pntnum
	Prompt slicenum,"Enter the slice:"
	Prompt pntnum,"Enter the point (1 or 2):"
	Pauseupdate
	Silent 1
	String thisname
	String iwave
	String Twave
	String namepara
	String nameposition
	String namewidth
	String namepositionerr
	String namewidtherr
	Variable i
	variable xstart,xend
	If(xCsr(A)<0)
		xstart=xCsr(A)
		xend=-xCsr(A)
		Else
			xstart=-xCsr(A)
			xend=xCsr(A)
	Endif		
	iwave="iatpnt"+num2str(pntnum)
	Twave="Tatpnt"+num2str(pntnum)
	nameposition="positionpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor1"
	namepositionerr=nameposition+"_err"
	namewidth="widthpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor1"
	namewidtherr=namewidth+"_err"
	Make/O/N=(dimsize($Twave,0)) $nameposition
	Make/O/N=(dimsize($Twave,0)) $namewidth
	Make/O/N=(dimsize($Twave,0)) $namepositionerr
	Make/O/N=(dimsize($Twave,0)) $namewidtherr	
	i=0
	Do
		thisname="pnt"+num2str(pntnum)+"T"+num2str($Twave[i])+"slice"+num2str(slicenum)
		namepara="para_pnt"+num2str(pntnum)+"T"+num2str($Twave[i])+"slice"+num2str(slicenum)+"_lor1"
		Wavestats/Q/R=(xstart,0) $thisname
		Make/O/N=6 $namepara
		Dowindow/F tableparameters
		appendtotable $namepara
		$namepara[0]=0.8
		$namepara[1]=-0.02
		$namepara[2]=0.01
		$namepara[5]=0.01		
		$namepara[3]=V_max*0.01^2*0.8
		$namepara[4]=V_maxloc
		FuncFit/H="000000"/N/Q sym1FDplus1Lor $namepara $thisname(xstart,xend) /D
		$nameposition[i]=-$namepara[4]
		$namewidth[i]=$namepara[5]
		$namepositionerr[i]=W_sigma[4]
		$namewidtherr[i]=W_sigma[5]		
		i+=1
	While(i<dimsize(File_name,0))
	Dowindow/F tableparameters
	appendtotable $nameposition
	appendtotable $namewidth
	appendtotable $namepositionerr
	appendtotable $namewidtherr	
	Display $nameposition vs $Twave
	Appendtograph/R $namewidth vs $Twave
	ModifyGraph rgb($namewidth)=(0,0,65535)
	ErrorBars $nameposition Y,wave=($namepositionerr,$namepositionerr)
	ErrorBars $namewidth Y,wave=($namewidtherr,$namewidtherr)
	ModifyGraph mode=4,marker($nameposition)=8
	ModifyGraph marker($namewidth)=5
End
//*******************************************************************************************************************************
Proc BKFA_Fit1FD2L(slicenum,pntnum)
	Variable slicenum
	Variable pntnum
	Prompt slicenum,"Enter the slice:"
	Prompt pntnum,"Enter the point (1 or 2):"
	Pauseupdate
	Silent 1
	String thisname
	String iwave
	String Twave
	String namepara
	String nameposition1,nameposition2
	String namewidth1,namewidth2
	String namepositionerr1,namepositionerr2
	String namewidtherr1,namewidtherr2
	String constrainttext
	Variable i
	variable xstart,xend
	If(xCsr(A)<0)
		xstart=xCsr(A)
		xend=-xCsr(A)
		Else
			xstart=-xCsr(A)
			xend=xCsr(A)
	Endif		
	iwave="iatpnt"+num2str(pntnum)
	Twave="Tatpnt"+num2str(pntnum)
	nameposition1="positionpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor2p1"
	namepositionerr1=nameposition1+"_err"
	namewidth1="widthpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor2p1"
	namewidtherr1=namewidth1+"_err"
	nameposition2="positionpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor2p2"
	namepositionerr2=nameposition2+"_err"
	namewidth2="widthpnt"+num2str(pntnum)+"slice"+num2str(slicenum)+"lor2p2"
	namewidtherr2=namewidth2+"_err"	
	Make/O/N=(dimsize($Twave,0)) $nameposition1
	Make/O/N=(dimsize($Twave,0)) $namewidth1
	Make/O/N=(dimsize($Twave,0)) $namepositionerr1
	Make/O/N=(dimsize($Twave,0)) $namewidtherr1	
	Make/O/N=(dimsize($Twave,0)) $nameposition2
	Make/O/N=(dimsize($Twave,0)) $namewidth2
	Make/O/N=(dimsize($Twave,0)) $namepositionerr2
	Make/O/N=(dimsize($Twave,0)) $namewidtherr2	
	i=0
	Do
		thisname="pnt"+num2str(pntnum)+"T"+num2str($Twave[i])+"slice"+num2str(slicenum)
		namepara="para_pnt"+num2str(pntnum)+"T"+num2str($Twave[i])+"slice"+num2str(slicenum)+"_lor2"
		Wavestats/Q/R=(xstart,0) $thisname
		Make/O/N=9 $namepara
		Dowindow/F tableparameters
		appendtotable $namepara
		
		if(i==0)
//			$namepara[0]=0.8
//			$namepara[1]=-0.02
//			$namepara[2]=0.01
//			$namepara[5]=0.01		
//			$namepara[3]=V_max*0.01^2*0.3
//			$namepara[4]=V_maxloc
//			$namepara[6]=V_max*0.0005^2*0.2
//			$namepara[7]=V_maxloc+0.005
//			$namepara[8]=0.005
			$namepara[0]=0.8
			$namepara[1]=-0.02
			$namepara[2]=0.01
			$namepara[5]=0.03		
			$namepara[3]=0.000216
			$namepara[4]=-0.04
			$namepara[6]=2.4e-05
			$namepara[7]=-0.005
			$namepara[8]=0.005
			Else
				$namepara[]=oldpara[p]
		Endif
		Make/O/T/N=4 T_Constraints
//		constrainttext=
//		T_Constraints[0]={namepara+"[4]>0.02"}
//		T_Constraints[1]={namepara+"[4]<0"}
//		T_Constraints[2]={namepara+"[7]<0"}
//		T_Constraints[3]={namepara+"[7]>"+namepara+"[4]"}
		FuncFit/H="000000000"/N/Q sym1FDplus2Lor $namepara $thisname(xstart,xend) /D ///C=T_Constraints
		$nameposition1[i]=ABS($namepara[4])
		$namewidth1[i]=$namepara[5]
		$namepositionerr1[i]=W_sigma[4]
		$namewidtherr1[i]=W_sigma[5]
		$nameposition2[i]=ABS($namepara[7])
		$namewidth2[i]=$namepara[8]
		$namepositionerr2[i]=W_sigma[7]
		$namewidtherr2[i]=W_sigma[8]
		Duplicate/O $namepara oldpara				
		i+=1
	While(i<dimsize(File_name,0))
	Dowindow/F tableparameters
	appendtotable $nameposition1
	appendtotable $namewidth1
	appendtotable $namepositionerr1
	appendtotable $namewidtherr1	
	appendtotable $nameposition2
	appendtotable $namewidth2
	appendtotable $namepositionerr2
	appendtotable $namewidtherr2	
	Display $nameposition1 vs $Twave
	Appendtograph/R $namewidth1 vs $Twave
	ModifyGraph rgb($namewidth1)=(0,0,65535)
	ErrorBars $nameposition1 Y,wave=($namepositionerr1,$namepositionerr1)
	ErrorBars $namewidth1 Y,wave=($namewidtherr1,$namewidtherr1)
	ModifyGraph mode=4,marker($nameposition1)=8
	ModifyGraph marker($namewidth1)=5
	Appendtograph $nameposition2 vs $Twave
	Appendtograph/R $namewidth2 vs $Twave
	ModifyGraph rgb($namewidth2)=(0,0,65535)
	ErrorBars $nameposition2 Y,wave=($namepositionerr2,$namepositionerr2)
	ErrorBars $namewidth2 Y,wave=($namewidtherr2,$namewidtherr2)
	ModifyGraph mode=4,marker($nameposition2)=8
	ModifyGraph marker($namewidth2)=5
	killwaves oldpara
End
//*******************************************************************************************************************************
Proc polarerrorBKFA()
	pauseupdate;Silent 1
	String thiserrorx,thiserrory
	Variable i
	Dowindow/F Graph_polarP_inner
	i=0
	Do
		thiserrorx="gap1x"+num2str(i)
		thiserrory="gap1y"+num2str(i)
		Duplicate/O errormodelx1 $thiserrorx
		Duplicate/O errormodely1 $thiserrory
		$thiserrorx[]+=xgap1BKFA[i]
		$thiserrory[]+=ygap1BKFA[i]
		rot_vector(thiserrorx,thiserrory,anglegapinner[i]-90,xgap1BKFA[i],ygap1BKFA[i])
		appendtograph $thiserrory vs $thiserrorx
//		thiserrorx="gap2x"+num2str(i)
//		thiserrory="gap2y"+num2str(i)
//		Duplicate/O errormodelx2 $thiserrorx
//		Duplicate/O errormodely2 $thiserrory
//		$thiserrorx[]+=xgap2BKFA[i]
//		$thiserrory[]+=ygap2BKFA[i]
//		rot_vector(thiserrorx,thiserrory,anglegapinner[i]-90,xgap2BKFA[i],ygap2BKFA[i])
//		appendtograph $thiserrory vs $thiserrorx
//		ModifyGraph rgb($thiserrory)=(65535,43690,0)		
		i+=1
	While(i<dimsize(indexgapinner,0))
	i=0
	Do
		thiserrorx="gap3x"+num2str(i)
		thiserrory="gap3y"+num2str(i)
		Duplicate/O errormodelx2 $thiserrorx
		Duplicate/O errormodely2 $thiserrory
		$thiserrorx[]+=xgap3BKFA[i]
		$thiserrory[]+=ygap3BKFA[i]
		rot_vector(thiserrorx,thiserrory,anglegapoutter[i]-90,xgap3BKFA[i],ygap3BKFA[i])
		appendtograph $thiserrory vs $thiserrorx
		ModifyGraph rgb($thiserrory)=(0,0,65535)			
		i+=1
	While(i<dimsize(indexgapoutter,0))		
End
//*******************************************************************************************************************************
Proc polarerrorBKFAatM()
	pauseupdate;Silent 1
	String thiserrorx,thiserrory
	Variable i
	Dowindow/F Graph_polarM
	i=0
	Do
		thiserrorx="gapMx"+num2str(i)
		thiserrory="gapMy"+num2str(i)
		Duplicate/O errormodelx1 $thiserrorx
		Duplicate/O errormodely1 $thiserrory
		$thiserrorx[]+=GapatMx[i]
		$thiserrory[]+=GapatMy[i]
		rot_vector(thiserrorx,thiserrory,angleFSBKFAatM[i]-90,GapatMx[i],GapatMy[i])
		appendtograph $thiserrory vs $thiserrorx
		ModifyGraph rgb($thiserrory)=(2,39321,1)
		i+=1
	While(i<dimsize(indexgapinner,0))
End
//*******************************************************************************************************************************
Proc FindgapangleBKFA(nameFS)   //not finished
	String nameFS
	Prompt nameFS,"Name of FS:"
	Pauseupdate
	Silent 1
	String cutname
	String NTPwave
	String nameedc
	String namepara
	String namegap1,namegap1err
	String namegap2,namegap2err
	String namew1,namew1err
	String namew2,namew2err
	Variable i,j
	Variable/G NTP_num	
	Variable condition
	NTPwave="NTP"+num2str(NTP_num)
	namegap1=nameFS+"gap1"
	namegap2=nameFS+"gap2"
	namegap1err=nameFS+"gap1err"
	namegap2err=nameFS+"gap2err"	
	namew1=nameFS+"w1"
	namew2=nameFS+"w2"
	namew1err=nameFS+"werr"
	namew2err=nameFS+"werr"	
	Make/O/N=0 $namegap1
	Make/O/N=0 $namegap2
	Make/O/N=0 $namegap1err
	Make/O/N=0 $namegap2err	
	Make/O/N=0 $namew1
	Make/O/N=0 $namew2
	Make/O/N=0 $namew1err
	Make/O/N=0 $namew2err	
	i=0
	Do
		print i
		condition=1
		j=0
		Do
			If($NTPwave[j]==i)
				condition=0
			Endif
			j+=1
		While(j<dimsize($NTPwave,0))
		If(condition==1)
			nameedc="symEDC_kf"+num2str(i)
			namepara=nameFS+"_para"
			Make/O/N=9 $namepara
			if(i==0)
				$namepara[0]=0.8
				$namepara[1]=-0.02
				$namepara[2]=0.01
				$namepara[5]=0.005		
				$namepara[3]=1.6e-05
				$namepara[4]=-0.014
				$namepara[6]=2.4e-06
				$namepara[7]=-0.005
				$namepara[8]=0.002
				Else
				//	$namepara[]=oldpara[p]	
			Endif
			Make/O/T/N=4 T_Constraints
			T_Constraints[0]={namepara+"[4]>-0.02"}
			T_Constraints[1]={namepara+"[4]<-0.007"}
			T_Constraints[2]={namepara+"[7]<-0.002"}
			T_Constraints[3]={namepara+"[7]>-0.01"}			
			FuncFit/H="000000000"/N/Q sym1FDplus2Lor $namepara $nameedc(-0.06,0.06) /D /C=T_Constraints
			Insertpoints dimsize($namegap1,0),1,$namegap1
			Insertpoints dimsize($namegap1err,0),1,$namegap1err
			Insertpoints dimsize($namegap2,0),1,$namegap2
			Insertpoints dimsize($namegap2err,0),1,$namegap2err
			Insertpoints dimsize($namew1,0),1,$namew1
			Insertpoints dimsize($namew1err,0),1,$namew1err
			Insertpoints dimsize($namew2,0),1,$namew2
			Insertpoints dimsize($namew2err,0),1,$namew2err
			$namegap1[dimsize($namegap1,0)-1]=-1000*$namepara[4]
			$namegap2[dimsize($namegap2,0)-1]=-1000*$namepara[7]
			$namegap1err[dimsize($namegap1,0)-1]=1000*W_sigma[4]
			$namegap2err[dimsize($namegap2,0)-1]=1000*W_sigma[7]
			$namew1[dimsize($namew1,0)-1]=1000*$namepara[5]
			$namew2[dimsize($namew2,0)-1]=1000*$namepara[8]
			$namew1err[dimsize($namew1,0)-1]=1000*W_sigma[5]
			$namew2err[dimsize($namew2,0)-1]=1000*W_sigma[8]			
			Duplicate/O $namepara oldpara
		Endif		
		i+=1
	While(i<dimsize(original_theta,0))	
	killwaves oldpara
End
//*******************************************************************************************************************************
Function funcfind1angleBKFA(xvalue,yvalue)
	Variable xvalue
	Variable yvalue
	Pauseupdate;Silent 1
	Variable angle
	angle=atan(yvalue/xvalue)*180/pi
	if((xvalue>=0)&&(yvalue<=0))
		angle=atan(yvalue/xvalue)*180/pi+360
	Endif	
	if((xvalue<=0)&&(yvalue>=0))
		angle=atan(yvalue/xvalue)*180/pi+180
	Endif	
	if((xvalue<=0)&&(yvalue<=0))
		angle=atan(yvalue/xvalue)*180/pi+180
	Endif	
	Return angle 	
End
//*******************************************************************************************************************************
Proc makematedckfBKFA()
	Pauseupdate
	Silent 1
	String thisname
	Variable i
	Make/O/N=(20,dimsize(symEDC_kf0,0)) matkf
	setscale/P y,dimoffset(symEDC_kf0,0),dimdelta(symEDC_kf0,0),""matkf
	i=0
	Do
		thisname="symEDC_kf"+num2str(indexgapinner[i])
		matkf[i][]=$thisname[q]
		i+=1
	While(i<20)
	Display;appendimage matkf
End	
//*******************************************************************************************************************************
Proc makematedckfBKFAout()
	Pauseupdate
	Silent 1
	String thisname
	Variable i
	Make/O/N=(dimsize(indexgapoutter,0),dimsize(symEDC_kf0,0)) matkfout
	setscale/P y,dimoffset(symEDC_kf0,0),dimdelta(symEDC_kf0,0),""matkfout
	i=0
	Do
		thisname="symEDC_kf"+num2str(indexgapoutter[i])
		matkfout[i][]=$thisname[q]
		i+=1
	While(i<dimsize(matkfout,0))
	Display;appendimage matkfout
End	
//*******************************************************************************************************************************
Proc funcfindangleBKFA()
	Pauseupdate
	Silent 1
	Variable i
	Make/O/N=(dimsize(original_theta,0)) angleFSBKFA
	i=0
	Do
		angleFSBKFA[i]=funcfind1angleBKFA(kx_final[i],ky_final[i])
		i+=1
	While(i<dimsize(original_theta,0))
	Duplicate/O angleFSBKFA numberFSBKFA
	numberFSBKFA[]=p
	edit angleFSBKFA,numberFSBKFA
	sort angleFSBKFA,angleFSBKFA,numberFSBKFA
End 
//*******************************************************************************************************************************
Proc BKFA_Fit1FD2L_Analysis(slicenum,ncomb,band)
	Variable slicenum
	Variable ncomb
	String band
	Prompt slicenum,"Enter the slice:"
	Prompt ncomb,"Number of EDCs to combine:"
	Prompt band,"Band (alpha,beta, gamma):"
	Pauseupdate
	Silent 1
	String thisname
	String iwave
	String Twave
	String namepara
	String nameposition1,nameposition2
	String namewidth1,namewidth2
	String namepositionerr1,namepositionerr2
	String namewidtherr1,namewidtherr2
	String constrainttext
	String thisfitname
	String thiscut
	String nameofwindow
	Variable i,j
	variable xstart,xend
	Variable jstart,jend
	Variable Vavg
	Variable maxposition
	Variable leftHH,rightHH
//	If(xCsr(A)<0)
//		xstart=xCsr(A)
//		xend=-xCsr(A)
//		Else
//			xstart=-xCsr(A)
//			xend=xCsr(A)
//	Endif		
	xstart=-0.125
	xend=-xstart
	Twave="Temperaturelist"
	nameposition1=band+"slice"+num2str(slicenum)+"lor2p1"
	namepositionerr1=nameposition1+"_err"
	namewidth1="width_"+band+"slice"+num2str(slicenum)+"lor2p1"
	namewidtherr1=namewidth1+"_err"
	nameposition2=band+"slice"+num2str(slicenum)+"lor2p2"
	namepositionerr2=nameposition2+"_err"
	namewidth2="width_"+band+"slice"+num2str(slicenum)+"lor2p2"
	namewidtherr2=namewidth2+"_err"	
	Make/O/N=(dimsize($Twave,0)) $nameposition1
	Make/O/N=(dimsize($Twave,0)) $namewidth1
	Make/O/N=(dimsize($Twave,0)) $namepositionerr1
	Make/O/N=(dimsize($Twave,0)) $namewidtherr1	
	Make/O/N=(dimsize($Twave,0)) $nameposition2
	Make/O/N=(dimsize($Twave,0)) $namewidth2
	Make/O/N=(dimsize($Twave,0)) $namepositionerr2
	Make/O/N=(dimsize($Twave,0)) $namewidtherr2
	nameofwindow="graph_"+band+"_slice"+num2str(slicenum)
	Display;Dowindow/C $nameofwindow	
	i=0
	Do
		thisname=band+"_T"+num2str($Twave[i])+"slice"+num2str(slicenum)
		thisfitname="f"+thisname
		thiscut="cut"+num2str(phiindex[i])
		jstart=slicenum-(ncomb/2)
		jend=slicenum+(ncomb/2)
		IF(jstart<0)
			jstart=0
		Endif
		If(jend>dimsize($thiscut,0)-1)
			jend=dimsize($thiscut,0)-1
		Endif
		Make/O/N=(dimsize($thiscut,1)) thistempwave
		Setscale/P x,dimoffset($thiscut,1),dimdelta($thiscut,1),""thistempwave
		thistempwave[]=0
		j=jstart
		Do
			thistempwave[]+=$thiscut[j][p]
			j+=1
		While(j<jend+1)
		Vavg=mean(thistempwave,pnt2x(thistempwave,0),pnt2x(thistempwave,10))
		thistempwave[]/=Vavg
		sym_one_EDC("thistempwave",16.825)
		Duplicate/O sym_thistempwave $thisname
		Killwaves sym_thistempwave,thistempwave	
		namepara="para_"+band+"_"+"T"+num2str($Twave[i])+"slice"+num2str(slicenum)+"_lor2"
		Wavestats/Q/R=(xstart,0) $thisname
		Make/O/N=10 $namepara
		Dowindow/F tableparameters
		appendtotable $namepara		
		if(i==0)
//			$namepara[0]=0.8
//			$namepara[1]=-0.02
//			$namepara[2]=0.01
//			$namepara[5]=0.01		
//			$namepara[3]=V_max*0.01^2*0.3
//			$namepara[4]=V_maxloc
//			$namepara[6]=V_max*0.0005^2*0.2
//			$namepara[7]=V_maxloc+0.005
//			$namepara[8]=0.005
			$namepara[0]=1
			$namepara[1]=-0.02
			$namepara[2]=0.01
			$namepara[5]=0.01		
			$namepara[3]=0.000116
			$namepara[4]=-0.04
			$namepara[6]=3.2e-03
			$namepara[7]=-0.005
			$namepara[8]=0.001
			$namepara[9]=0.2
			Else
				$namepara[]=oldpara[p]
		Endif
		Make/O/T/N=4 T_Constraints
//		constrainttext=
		T_Constraints[0]={namepara+"[4]>-0.1"}
		T_Constraints[1]={namepara+"[4]<0"}
		T_Constraints[2]={namepara+"[7]<0"}
		T_Constraints[3]={namepara+"[7]>-0.03"}
		FuncFit/H="0000000000"/N/Q sym1FDplus2asLor $namepara $thisname(xstart,xend) /D /C=T_Constraints
		$nameposition1[i]=ABS($namepara[4])
		$namewidth1[i]=$namepara[5]                   //peak 1 is not the SC peak
		$namepositionerr1[i]=W_sigma[4]
		$namewidtherr1[i]=W_sigma[5]
		$nameposition2[i]=ABS($namepara[7])
//		$namewidth2[i]=$namepara[8]
		$namepositionerr2[i]=W_sigma[7]
		$namewidtherr2[i]=W_sigma[8]
		Duplicate/O $namepara oldpara
		Duplicate/O $thisname $thisfitname
		$thisfitname[]=sym1FDplus2asLor($namepara,dimoffset($thisfitname,0)+p*dimdelta($thisfitname,0))
		Make/O/N=4 temppara
		temppara[0]=$namepara[6]
		temppara[1]=$namepara[7]
		temppara[2]=$namepara[8]
		temppara[3]=$namepara[9]
		Make/O/N=(3*dimsize($thisfitname,0)) find0wave 
		Setscale/P x,dimoffset($thisfitname,0),dimdelta($thisfitname,0)/3,""find0wave		
		find0wave[]=OneasLor(temppara,dimoffset(find0wave,0)+p*dimdelta(find0wave,0))
		Wavestats/Q find0wave
		maxposition=V_maxloc	
		find0wave[]-=V_max/2
		find0wave[]=ABS(find0wave)
		Wavestats/Q/R=(dimoffset(find0wave,0),maxposition) find0wave
		leftHH=V_minloc
		Wavestats/Q/R=(maxposition,0) find0wave	
		rightHH=V_minloc	
		Killwaves find0wave,temppara
		$namewidth2[i]=ABS(rightHH-leftHH)/2	
		$namewidtherr2[i]=W_sigma[8]*$namewidth2[i]/ABS($namepara[8])
		Dowindow/F $nameofwindow
		Appendtograph $thisname;appendtograph $thisfitname
		ModifyGraph rgb($thisfitname)=(0,0,65535)				
		i+=1
	While(i<dimsize(phiindex,0))
	Dowindow/F tableparameters
	appendtotable $nameposition1
	appendtotable $namewidth1
	appendtotable $namepositionerr1
	appendtotable $namewidtherr1	
	appendtotable $nameposition2
	appendtotable $namewidth2
	appendtotable $namepositionerr2
	appendtotable $namewidtherr2	
	Display $nameposition1 vs $Twave
	Appendtograph $namewidth1 vs $Twave
	ModifyGraph rgb($namewidth1)=(0,0,65535)
	ErrorBars $nameposition1 Y,wave=($namepositionerr1,$namepositionerr1)
	ErrorBars $namewidth1 Y,wave=($namewidtherr1,$namewidtherr1)
	ModifyGraph mode=4,marker($nameposition1)=8
	ModifyGraph marker($namewidth1)=5
	Appendtograph $nameposition2 vs $Twave
	Appendtograph $namewidth2 vs $Twave
	ModifyGraph rgb($namewidth2)=(0,0,65535)
	ErrorBars $nameposition2 Y,wave=($namepositionerr2,$namepositionerr2)
	ErrorBars $namewidth2 Y,wave=($namewidtherr2,$namewidtherr2)
	ModifyGraph mode=4,marker($nameposition2)=8
	ModifyGraph marker($namewidth2)=5
	killwaves oldpara
End

//*******************************************************************************************************************************
Proc BKFAgapatM(indexwave,gapwave,nametogive)
	String indexwave="waveofindexes"
	String gapwave="waveofgaps"
	String nametogive
	Prompt indexwave,"Wave of indexes:"
	Prompt gapwave,"Wave for gap:"
	Prompt nametogive,"Base name for results:"	
	Pauseupdate;silent 1
	String newnamegap
	String newnameindex
	String nameangle
	String namex
	String namey
	String nametable
	Variable i
	Variable ratio
	newnameindex=nametogive+"_index"
	newnamegap=nametogive+"_gap"
	nameangle=nametogive+"_angle"
	namex=nametogive+"_x"
	namey=nametogive+"_y"
	nametable=nametogive+"_table"
	Duplicate/O $indexwave $newnameindex
	Duplicate/O $gapwave $newnamegap
	Make/O/N=(dimsize($indexwave,0)) $nameangle
	Make/O/N=(dimsize($indexwave,0)) $namex
	Make/O/N=(dimsize($indexwave,0)) $namey
	If(wintype(nametable)==0)
		Edit $newnameindex,$newnamegap,$nameangle,$namex,$namey
		Dowindow/C $nametable
		Else
			Dowindow/F $nametable
	Endif
	//First step: find the angle
	i=0
	Do
		ratio=ky_final[$newnameindex[i]]/(kx_final[$newnameindex[i]]+1)
		if((ky_final[$newnameindex[i]]>=0)&&((kx_final[$newnameindex[i]]+1)>=0))
			$nameangle[i]=atan(ratio)*180/pi
		Endif
		if((ky_final[$newnameindex[i]]>=0)&&((kx_final[$newnameindex[i]]+1)<0))
			$nameangle[i]=atan(ratio)*180/pi+180
		Endif
		if((ky_final[$newnameindex[i]]<=0)&&((kx_final[$newnameindex[i]]+1)<=0))
			$nameangle[i]=atan(ratio)*180/pi+180
		Endif
		if((ky_final[$newnameindex[i]]<=0)&&((kx_final[$newnameindex[i]]+1)>0))
			$nameangle[i]=atan(ratio)*180/pi+360
		Endif
		i+=1
	While(i<dimsize($indexwave,0))
	Sort $nameangle, $nameangle, $newnameindex, $newnamegap
	//Convert into polar form
	i=0
	Do
		$namex[i]=$newnamegap[i]*cos($nameangle[i]*pi/180)
		$namey[i]=$newnamegap[i]*sin($nameangle[i]*pi/180)		
		i+=1
	While(i<dimsize($indexwave,0))
	Display $namey vs $namex
End	
//*******************************************************************************************************************************
Function BKFA_adjust_EF(matname,correctwave)
	Wave matname
	Wave correctwave
	PauseUpdate;Silent 1
	Variable i
	Variable EFenergy
	variable maxAu
	Variable minAu
	Variable numofpntsless
	Variable Emin,Emax
	Wavestats/Q correctwave
	EFenergy=V_avg
	maxAu=V_max
	minAu=V_min
	Emin=dimoffset(matname,1)+(V_max-V_avg)
	Emax=dimoffset(matname,1)+(dimsize(matname,1)-1)*dimdelta(matname,1)-(V_avg-V_min)
	numofpntsless=Floor((maxAu-minAu)/dimdelta(matname,1))
	Make/O/N=(dimsize(matname,0),dimsize(matname,1)-numofpntsless) tempmatrix
	Setscale/P x,dimoffset(matname,0),dimdelta(matname,0),""tempmatrix
	Setscale/I y,Emin,Emax,""tempmatrix
	tempmatrix[][]=0
	i=0
	Do
		Make/O/N=(dimsize(matname,1)) thiswavex
		Make/O/N=(dimsize(matname,1)) thiswavey
		thiswavex[]=dimoffset(matname,1)+p*dimdelta(matname,1)-(correctwave[i]-EFenergy)
		thiswavey[]=matname[i][p]
		tempmatrix[i][]=interp(dimoffset(tempmatrix,1)+q*dimdelta(tempmatrix,1),thiswavex,thiswavey)
		i+=1
	While(i<dimsize(matname,0))
	Duplicate/O tempmatrix matname
	Killwaves tempmatrix,thiswavex,thiswavey
End	
//*******************************************************************************************************************************
Proc BKFA_adjust_EF_all()
	PauseUpdate;silent 1
	String thisdata
	Variable i
	i=1
	Do
		thisdata="data"+num2str(i)
		BKFA_adjust_EF($thisdata,AuEF_smth_L)
		i+=1
	While(i<dimsize(File_name,0))
End
//*******************************************************************************************************************************
Proc simulBKFA()
	PauseUpdate;Silent 1
	Variable i
	Variable Gammaw,Gamma0,alpha
	Variable Ek,epsilonk,k
	Variable u,v
	Variable Gap
	Make/O/N=1000 paraband_unoc
	Setscale/I x,-7,17,""paraband_unoc
	paraband_unoc[]=0.00065*((dimoffset(paraband_oc,0)+p*dimdelta(paraband_oc,0))^2-2*5.3*(dimoffset(paraband_oc,0)+p*dimdelta(paraband_oc,0))+5.3^2)-0.0165
	Duplicate/O paraband_unoc paraband_x
	paraband_x[]=dimoffset(paraband_unoc,0)+p*dimdelta(paraband_unoc,0)
	Duplicate/O paraband_unoc paraband_oc
	paraband_oc[]*=-1
	Make/O/N=(1000,1000) Akw
	Setscale/I x,-7,17,""Akw
	Setscale/I y,-0.05,0.05,""Akw	
	Gamma0=0.003
	alpha=0.01
	Gap=0.0125
	i=0
	Do
		if(mod(i,200)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,paraband_x,paraband_oc)
		Gammaw=Gamma0+alpha*ABS(epsilonk)
		Ek=sqrt(epsilonk^2+gap^2)
		v=0.5*(1-epsilonk/Ek)
		u=1-v
		Akw[i][]=(1/pi)*(u*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)-Ek)^2+Gammaw^2)+v*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)+Ek)^2+Gammaw^2))	
//		Akw[i][]+=(1/pi)*(v*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)-Ek)^2+Gammaw^2)+u*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)+Ek)^2+Gammaw^2))
		i+=1
	While(i<dimsize(Akw,0))
	Display;appendimage Akw
	ModifyImage Akw ctab= {*,*,Terrain,0}
	appendtograph paraband_oc
	appendtograph paraband_unoc
	ModifyGraph lstyle(paraband_unoc)=3
	ModifyGraph lstyle(paraband_oc)=3
	ModifyGraph lsize(paraband_unoc)=3	
	ModifyGraph lsize(paraband_oc)=3	
	ModifyGraph rgb(paraband_oc)=(0,0,0)
	SetAxis left dimoffset(Akw,1),dimoffset(Akw,1)+(dimsize(Akw,1)-1)*dimdelta(Akw,1)
End
//*******************************************************************************************************************************
Proc simulBugolioubov(curvex,curvey,Gap,Gamma0,alpha)
	String curvex
	String curvey
	Variable gap=0.0125
	Variable Gamma0
	Variable alpha
	Prompt curvex,"Enter the name of the x wave:"
	Prompt curvey,"Enter the name of the y wave:"	
	Prompt gap,"Enter the superconducting gap Delta (meV)"
	Prompt Gamma0,"Im sigma 0:"
	Prompt alpha,"alpha in: Im sigma 0+alpha|omega|:"	
	PauseUpdate;Silent 1
	String unoc
	Variable i
	Variable Gammaw
	Variable Ek,epsilonk,k
	Variable u,v
	unoc="unoc_"+curvey
	Duplicate/O $curvey $unoc
	$unoc[]*=-1
	Make/O/N=(1000,1000) Akw
	Setscale/I x,$curvex[0],$curvex[dimsize($curvex,0)-1],""Akw
	Wavestats/Q $curvey
	If(abs(V_min)>abs(V_max))
		Setscale/I y,-2*abs(V_min),2*abs(V_min),""Akw
		Else
			Setscale/I y,-1.2*abs(V_max),1.2*abs(V_max),""Akw
	Endif		
//	Gamma0=0.003
//	alpha=0.01
//	Gap=0.0125
	i=0
	Do
		if(mod(i,200)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,$curvex,$curvey)
		Gammaw=Gamma0+alpha*ABS(epsilonk)
		Ek=sqrt(epsilonk^2+gap^2)
		v=0.5*(1-epsilonk/Ek)
		u=1-v
		Akw[i][]=(1/pi)*(u*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)-Ek)^2+Gammaw^2)+v*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)+Ek)^2+Gammaw^2))	
//		Akw[i][]+=(1/pi)*(v*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)-Ek)^2+Gammaw^2)+u*Gammaw/((dimoffset(Akw,1)+q*dimdelta(Akw,1)+Ek)^2+Gammaw^2))
		i+=1
	While(i<dimsize(Akw,0))
	Display;appendimage Akw
	ModifyImage Akw ctab= {*,*,Terrain,0}
	appendtograph $curvey vs $curvex
	appendtograph $unoc vs $curvex
	ModifyGraph lstyle($unoc)=3
	ModifyGraph lstyle($curvey)=3
	ModifyGraph lsize($unoc)=3	
	ModifyGraph lsize($curvey)=3	
	ModifyGraph rgb($curvey)=(0,0,0)
	SetAxis left dimoffset(Akw,1),dimoffset(Akw,1)+(dimsize(Akw,1)-1)*dimdelta(Akw,1)
End

//*******************************************************************************************************************************
Proc simulBugolioubovplusmode(curvex,curvey,Gap,mode,lambda,gamma0,alpha,Eresolution,kresolution)
	String curvex
	String curvey
	Variable gap=0.012
	Variable mode=0.09
	Variable lambda
	Variable Gamma0=0.2
	Variable alpha=0.4
	Variable Eresolution
	Variable kresolution
	Prompt curvex,"Enter the name of the x wave:"
	Prompt curvey,"Enter the name of the y wave:"	
	Prompt gap,"Enter the superconducting gap Delta (meV)"
	Prompt Mode,"Mode energy:"
	Prompt lambda,"Coupling constant lambda:"
	Prompt Gamma0,"Im sigma 0:"
	Prompt alpha,"alpha in: Im sigma 0+alpha|omega|:"	
	Prompt Eresolution,"Energy resolution:"		
	Prompt Eresolution,"Momentum resolution:"			
	PauseUpdate;Silent 1
	String unoc
	Variable i,j
//	Variable Gammaw
	Variable Ek,epsilonk,k
	Variable u,v
	Variable offself,deltaself
	Variable thisw
	Variable/C cOmega,cmode,cGap
	unoc="unoc_"+curvey
	Duplicate/O $curvey $unoc
	$unoc[]*=-1
	Make/O/N=(5000,5000) Akw
	Setscale/I x,$curvex[0],$curvex[dimsize($curvex,0)-1],""Akw
	Wavestats/Q $curvey
	If(abs(V_min)>abs(V_max))
		Setscale/I y,-2*abs(V_min),2*abs(V_min),""Akw
		Else
			Setscale/I y,-2*abs(V_max),2*abs(V_max),""Akw
	Endif
	Make/O/N=(dimsize(Akw,1)) imself
	Setscale/P x, dimoffset(Akw,1),dimdelta(Akw,1),""imself
	Make/O/N=(10*dimsize(Akw,1)) longimself
	Setscale/P x, 5*dimoffset(Akw,1),dimdelta(Akw,1),""longimself	
	Duplicate/O imself realself
	realself[]=0
	deltaself=dimdelta(longimself,0)
	offself=dimoffset(longimself,0)
	cGap=Cmplx(Gap,0)
	cmode=Cmplx(mode,0)
	Calcselfmode(realself,imself,longimself,deltaself,offself,mode,cmode,cGap,lambda,Gamma0,alpha)
	Display imself,realself
	ModifyGraph rgb(realself)=(0,0,65535)
	Print "FIling A(k,w)"
	FillAkwinSCstate3(Akw,$curvex,$curvey,realself,imself,Gap)
	SimulkEresolution(Akw,Eresolution,kresolution)
	Display;appendimage Akw
	ModifyImage Akw ctab= {*,*,Terrain,0}
	appendtograph $curvey vs $curvex
	appendtograph $unoc vs $curvex
	ModifyGraph lstyle($unoc)=3
	ModifyGraph lstyle($curvey)=3
	ModifyGraph lsize($unoc)=3	
	ModifyGraph lsize($curvey)=3	
	ModifyGraph rgb($curvey)=(0,0,0)
	SetAxis left dimoffset(Akw,1),dimoffset(Akw,1)+(dimsize(Akw,1)-1)*dimdelta(Akw,1)
	print "maudite ostie de banane"	
End


Function Calcselfmode(realself,imself,longimself,deltaself,offself,mode,cmode,cGap,lambda,Gamma0,alpha)
	Wave realself
	Wave imself
	Wave longimself
	Variable deltaself
	Variable offself
	Variable mode
	Variable/C cmode
	Variable/C cGap
	Variable lambda
	Variable Gamma0
	Variable alpha
	PauseUpdate;Silent 1
	String toexecute
	Variable/C cOmega
	Variable i
	Print "Calculating the IM {Selfenergy}"
	i=0
	Do
		cOmega=Cmplx(i*deltaself+offself,0)
		if(mod(i,5000)==0)
			print i,"/",dimsize(longimself,0)-1
		Endif
		IF(i*deltaself+offself<0)
			longimself[i]=((pi*lambda*mode/2)*real((cOmega+cmode)/sqrt((cOmega+cmode)^2-cGap^2)))-(Gamma0+alpha*(i*deltaself+offself)^2)
//			realself[i]=calcrealself_i(realself,i*deltaself+offself,cmode,cgap,lambda)
			Else
				longimself[i]=-((pi*lambda*mode/2)*real((cOmega-cmode)/sqrt((cOmega-cmode)^2-cGap^2)))-(Gamma0+alpha*(i*deltaself+offself)^2)
		Endif
		if(longimself[i]>0)
			longimself[i]=0
		Endif
		i+=1
	While(i<dimsize(longimself,0))
//	imself[]=-ABS(imself[p])
	Duplicate/O longimself thiswave
	HilbertTransform/Z/DEST=realself thiswave
	smooth/E=3/B=3 3, realself
	killwaves thiswave
	realself[]*=1
	Setscale/P x, dimoffset(longimself,0),dimdelta(longimself,0),""realself
	toexecute="transform2equiv_waves(\"imself\",\"longimself\")"
	Execute toexecute
	Duplicate/O longimself imself
	toexecute="transform2equiv_waves(\"imself\",\"realself\")"
	Execute toexecute
	Killwaves longimself	
End

Function FillAkw(Akw,curvex,curvey,realself,imself,cGap)
	Wave Akw
	Wave curvex
	Wave curvey
	Wave realself
	Wave imself
	VAriable/C cGap
	PauseUpdate;Silent 1
	Variable i
	Variable k
	Variable epsilonk
	VAriable/C cdimdelta,cdimoffset,cepsilonk
	i=0
	Do
		if(mod(i,200)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,curvex,curvey)
		Akw[i][]=(1/pi)*(-(imself[q])/((dimoffset(Akw,1)+q*dimdelta(Akw,1)-epsilonk-realself[q])^2+imself[q]^2))	
//		Make/C/O/N=(dimsize(imself,0)) cself
//		Setscale/P x, dimoffset(Akw,1),dimdelta(Akw,1),""cself		
//		cself[]=Cmplx(realself[p],imself[p])
//		Make/C/O/N=(dimsize(imself,0)) Gwatk
//		Setscale/P x, dimoffset(Akw,1),dimdelta(Akw,1),""Gwatk
//		cdimdelta=CMPLX(dimdelta(Akw,1),0)
//		cdimoffset=CMPLX(dimoffset(Akw,1),0)
//		cepsilonk=CMPLX(epsilonk,0)
//		Gwatk[]=(1/(2*pi))*(cmplx(p,0)*cdimdelta+cdimoffset-cself[p]+epsilonk)/((cmplx(p,0)*cdimdelta+cdimoffset-cself[p])^2-cgap^2*(1-cself[p]/(cmplx(p,0)*cdimdelta+cdimoffset))^2-cepsilonk^2)
//		Akw[i][]=(1/pi)*Imag(Gwatk[q])				
		i+=1
	While(i<dimsize(Akw,0))	
End

Function FillAkwinSCstate(Akw,curvex,curvey,realself,imself,cGap)
	Wave Akw
	Wave curvex
	Wave curvey
	Wave realself
	Wave imself
	VAriable/C cGap
	PauseUpdate;Silent 1
	Variable i
	Variable k
	Variable epsilonk
	VAriable/C cdimdelta,cdimoffset,cepsilonk
	Variable/C ci
	Make/O/C/N=(dimsize(imself,0)) cself
	Setscale/P x, dimoffset(imslef,0),dimdelta(imself,0),""cself
	cself[]=Cmplx(realself[p],imself[p])
	ci=CMPLX(0,0.000001)
	i=0
	Do
		if(mod(i,200)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,curvex,curvey)
		Akw[i][]=-imag((CMPLX(dimoffset(Akw,1)+q*dimdelta(Akw,1),0)+CMPLX(epsilonk,0)+cself[q])/(CMPLX(dimoffset(Akw,1)+q*dimdelta(Akw,1),0)^2-cGap^2-(CMPLX(epsilonk,0)+cself[q])^2+ci))/pi
		i+=1
	While(i<dimsize(Akw,0))	
End

Function FillAkwinSCstate2(Akw,curvex,curvey,realself,imself,Gap)
	Wave Akw
	Wave curvex
	Wave curvey
	Wave realself
	Wave imself
	VAriable Gap
	PauseUpdate;Silent 1
	Variable i
	Variable k
	Variable epsilonk
	Duplicate/O realself Ek
	Duplicate/O realself uk
	Duplicate/O realself vk
	Ek[]=0
	i=0
	Do
		if(mod(i,2)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,curvex,curvey)
		Ek[]=sqrt((epsilonk+realself[p])^2+Gap^2)
		vk[]=0.5*(1-(epsilonk+realself[p])/Ek[p])
		uk[]=1-vk[p]
		Akw[i][]=-(1/pi)*(-uk[q]*imself[q]/((dimoffset(Akw,1)+i*dimdelta(Akw,1)-Ek[q])^2+imself[q]^2)-vk[q]*imself[q]/((dimoffset(Akw,1)+i*dimdelta(Akw,1)+Ek[q])^2+imself[q]^2))
		i+=1
	While(i<dimsize(Akw,0))
	killwaves uk,vk,Ek
End

Function FillAkwinSCstate3(Akw,curvex,curvey,realself,imself,Gap)
	Wave Akw
	Wave curvex
	Wave curvey
	Wave realself
	Wave imself
	VAriable Gap
	Variable Eresolution
	PauseUpdate;Silent 1
	Variable i
	Variable k
	Variable epsilonk
	Variable omega
	Make/O/C/N=(dimsize(realself,0)) Zofw
	Setscale/P x,dimoffset(realself,0),dimdelta(realself,0),""Zofw
	Make/O/N=(dimsize(realself,0)) omegawave
//	Make/O/C/N=(dimsize(realself,0)) omegawave	
	Setscale/P x,dimoffset(realself,0),dimdelta(realself,0),""omegawave
//	omegawave[]=CMPLX(p*dimdelta(Akw,1)+dimoffset(Akw,1),0)
	omegawave[]=p*dimdelta(Akw,1)+dimoffset(Akw,1)
	i=0
	Do
		omega=dimoffset(realself,0)+i*dimdelta(realself,0)
		IF(omega==0)
			omega=dimdelta(realself,0)/1000
		Endif
		Zofw[]=CMPLX(1-realself[p]/omega,-imself[p]/omega)
//		If(omega<0)
//			Zofw[]=CMPLX(1-realself[p]/omega,-imself[p]/omega)
//			Else
//				Zofw[]=CMPLX(1+realself[p]/omega,imself[p]/omega)
//		Endif
		i+=1
	While(i<dimsize(realself,0))
	i=0
	Do
		Make/O/N=(dimsize(Akw,1)) thiswave
		Setscale/P x,dimoffset(Akw,1),dimdelta(Akw,1),""thiswave
		if(mod(i,200)==0)
			print i,"/",dimsize(Akw,0)-1
		Endif
		k=dimoffset(Akw,0)+i*dimdelta(Akw,0)
		epsilonk=interp(k,curvex,curvey)
		thiswave[]=(1/pi)*imag((Zofw[p]*omegawave[p]+epsilonk)/(Zofw[p]^2*(omegawave[p]^2-Gap^2)-epsilonk^2))
		Thiswave[]=abs(thiswave[p])
		Akw[i][]=thiswave[q]
		i+=1
	While(i<dimsize(Akw,0))
	killwaves thiswave,gausswave
End

Function SimulkEresolution(mat,Eresolution,kresolution)
	Wave mat
	Variable Eresolution
	Variable kresolution
	Pauseupdate;Silent 1
	Variable i
	Duplicate/O mat Akw_E
	Duplicate/O mat Akw_k
	Akw_E[][]=0
	Akw_k[][]=0	
	Make/O/N=(dimsize(mat,1)) gausswave
	Setscale/P x,dimoffset(mat,1),dimdelta(mat,1),""gausswave
	gausswave[]=exp(-(p*dimdelta(gausswave,0)+dimoffset(gausswave,0))^2/Eresolution^2)
	i=0
	Do
		Make/O/N=(dimsize(mat,1)) Thiswave
		Setscale/P x,dimoffset(mat,1),dimdelta(mat,1),""Thiswave
		Thiswave[]=mat[i][p]
		Convolve/A gausswave,thiswave
		Akw_E[i][]=thiswave[q]		
		i+=1
	While(i<dimsize(mat,0))
	If(kresolution<0)
		Akw_k[][]=1
	Endif
	If(kresolution>0)
		Make/O/N=(dimsize(mat,0)) gausswave
		Setscale/P x,dimoffset(mat,0),dimdelta(mat,0),""gausswave
		gausswave[]=exp(-(p*dimdelta(gausswave,0)+dimoffset(gausswave,0))^2/kresolution^2)
		i=0
		Do
			Make/O/N=(dimsize(mat,0)) Thiswave
			Setscale/P x,dimoffset(mat,0),dimdelta(mat,0),""Thiswave
			Thiswave[]=mat[p][i]
			Convolve/A gausswave,thiswave
			Akw_k[][i]=thiswave[p]		
			i+=1
		While(i<dimsize(mat,1))
	Endif
	mat[][]=Akw_E[p][q]*Akw_k[p][q]
	killwaves thiswave,Akw_E,Akw_k
End


Function calcrealself_i(realself,energy,cmode,cgap,lambda)
	Wave realself
	Variable energy
	Variable/C cmode
	Variable/C cgap
	Variable lambda
	PauseUpdate;Silent 1
	Variable i
	Variable/C cvalue
	Variable/C thisE
	Variable/C cdelta,cdeltaE
	Variable/C cenergy
	Variable/C ci
	Variable value
	Variable/C numerator
	Variable/C denominator
	ci=Cmplx(0,0.00001)
	cenergy=Cmplx(energy,0)
	cdeltaE=Cmplx(dimdelta(realself,0),0)
	cvalue=Cmplx(0,0)
	i=0
	Do
		numerator=Cmplx(0,0)
		denominator=Cmplx(0,0)
		thisE=Cmplx(dimoffset(realself,0)+(i+1/2)*dimdelta(realself,0),0)
		numerator=cdeltaE*(cenergy+thisE)
		denominator=(cmode^2-thisE^2-ci)*sqrt((cenergy+thisE)^2-cgap^2)
		cvalue+=numerator/denominator
		i+=1
	While(i<dimsize(realself,0))
	value=Real(cvalue)*Real(cmode)*lambda*(-1/2)
	return value
End

//*******************************************************************************************************************************
Proc Drawcone()
	Pauseupdate;Silent 1
	String thisname,thisnamex,thisnamey
	Variable i,j,thistheta,angle
	Make/O/N=(101*101) conez
	Make/O/N=(101*101) conex
	Make/O/N=(101*101) coney
	angle=5*pi/180	
	i=0
	Do
		j=0
		Do
			thistheta=2*pi*j/100
			conez[(i*101)+j]=-1+2*i/100   //cone from -1 to 1
			conex[(i*101)+j]=(-1+2*i/100)*tan(angle)*cos(thistheta)
			coney[(i*101)+j]=(-1+2*i/100)*tan(angle)*sin(thistheta)
			j+=1
		While(j<101)
		i+=1
	While(i<101)
	conez[]-=0.3
	Duplicate/O conex conex1
	Duplicate/O conex conex2
	Duplicate/O conex conex3
	Duplicate/O conex conex4
	Duplicate/O conex conex5
	Duplicate/O conex conex6
	Duplicate/O conex conex7
	Duplicate/O conex conex8
	Duplicate/O conex conex9
	Duplicate/O conex conex10
	Duplicate/O conex conex11
	Duplicate/O conex conex12
	Duplicate/O conex conex13
	Duplicate/O conex conex14
	Duplicate/O conex conex15
	Duplicate/O conex conex16		
	Duplicate/O coney coney1
	Duplicate/O coney coney2
	Duplicate/O coney coney3
	Duplicate/O coney coney4
	Duplicate/O coney coney5
	Duplicate/O coney coney6
	Duplicate/O coney coney7
	Duplicate/O coney coney8
	Duplicate/O coney coney9
	Duplicate/O coney coney10
	Duplicate/O coney coney11
	Duplicate/O coney coney12
	Duplicate/O coney coney13
	Duplicate/O coney coney14
	Duplicate/O coney coney15
	Duplicate/O coney coney16
	conex1[]=conex[p]+1.2
	coney1[]=coney[p]
	conex2[]=conex[p]+0.8
	coney2[]=coney[p]
	conex3[]=conex[p]-1.2
	coney3[]=coney[p]
	conex4[]=conex[p]-0.8
	coney4[]=coney[p]
	conex5[]=conex[p]
	coney5[]=coney[p]+1.2
	conex6[]=conex[p]
	coney6[]=coney[p]+0.8
	conex7[]=conex[p]
	coney7[]=coney[p]-1.2
	conex8[]=conex[p]
	coney8[]=coney[p]-0.8
	conex9[]=conex[p]+1
	coney9[]=coney[p]+0.2
	conex10[]=conex[p]+1
	coney10[]=coney[p]-0.2
	conex11[]=conex[p]-1
	coney11[]=coney[p]+0.2
	conex12[]=conex[p]-1
	coney12[]=coney[p]-0.2
	conex13[]=conex[p]+0.2
	coney13[]=coney[p]+1
	conex14[]=conex[p]-0.2
	coney14[]=coney[p]+1
	conex15[]=conex[p]+0.2
	coney15[]=coney[p]-1
	conex16[]=conex[p]-0.2
	coney16[]=coney[p]-1
	i=1
	Do
		thisname="cone"+num2str(i)
		thisnamex="conex"+num2str(i)
		thisnamey="coney"+num2str(i)
		Make/O/N=(dimsize(conez,0),3) $thisname
		$thisname[][0]=$thisnamex[p]
		$thisname[][1]=$thisnamey[p]
		$thisname[][2]=conez[p]		
		i+=1
	While(i<17)
End
//*******************************************************************************************************************************
Proc Fe_resonance(work_function)
	Variable work_function
	Prompt work_function,"Enter the work function"
	Pauseupdate;Silent 1
	String thisdata
	String thiswave
	Variable i,j=0
	Variable max1
	variable e1,e2
	thisdata="data"+num2str(Fe_index[0])
	Make/O/N=(dimsize(Fe_index,0),Dimsize($thisdata,1)) Fe_matrix
	Setscale/P x,Fe_hv[0],Fe_hv[1]-Fe_hv[0],""Fe_matrix
	Setscale/P y,dimoffset($thisdata,1)+work_function-Fe_hv[0],dimdelta($thisdata,1),""Fe_matrix
	Duplicate/O Fe_flux1 Fe_norm
	Fe_norm[]=(Fe_flux1[p]+Fe_flux2[p])/2
	Fe_matrix[][]=0
	Wavestats/Q $thisdata
	max1=V_max
	Display 
	i=0
	Do
		thisdata="data"+num2str(Fe_index[i])
		thiswave="hv"+num2str(Fe_hv[i])
		Make/O/N=(dimsize(Fe_matrix,1)) $thiswave
		Setscale/P x,dimoffset(Fe_matrix,1),dimdelta(Fe_matrix,1),""$thiswave
		$thiswave[]=0
		j=0	
		Do
			$thiswave[]+=$thisdata[j][p]
			j+=1
		While(j<dimsize($thisdata,0))
		e2=dimoffset($thiswave,0)+(dimsize($thiswave,0)-1)*dimdelta($thiswave,0)
		e1=e2-15*dimdelta($thiswave,0)
		Wavestats/Q/R=(e1,e2) $thiswave
		sub_blineedc_pi(thiswave,15)
		$thiswave[]/=V_avg		
//		$thiswave[]/=(Fe_norm[i]*V_max*Fe_scans[i])
		Fe_matrix[i][]=$thiswave[q]
		appendtograph $thiswave		
		i+=1
	While(i<dimsize(Fe_index,0))
	Display;appendimage Fe_matrix
End
//*******************************************************************************************************************************
Proc Fe_resonance_long(work_function)
	Variable work_function
	Prompt work_function,"Enter the work function"
	Pauseupdate;Silent 1
	String thisdata
	String thiswave
	Variable i,j=0
	Variable max1
	variable e1,e2
	Duplicate/O Fe_flux1l Fe_norml
	Fe_norml[]=(Fe_flux1l[p]+Fe_flux2l[p])/2
	Display 
	i=0
	Do
		thisdata="data"+num2str(Fe_indexl[i])
		thiswave="hvl"+num2str(Fe_hvl[i])
		Make/O/N=(dimsize($thisdata,1)) $thiswave
		Setscale/P x,dimoffset($thisdata,1)+work_function-Fe_hvl[i],dimdelta($thisdata,1),""$thiswave
		$thiswave[]=0
		j=0	
		Do
			$thiswave[]+=$thisdata[j][p]
			j+=1
		While(j<dimsize($thisdata,0))
		e2=dimoffset($thiswave,0)+(dimsize($thiswave,0)-1)*dimdelta($thiswave,0)
		e1=e2-15*dimdelta($thiswave,0)
		Wavestats/Q/R=(e1,e2) $thiswave
		sub_blineedc_pi(thiswave,15)
		$thiswave[]/=V_avg		
//		$thiswave[]/=(Fe_norml[i]*V_max*Fe_scansl[i])
		appendtograph $thiswave		
		i+=1
	While(i<dimsize(Fe_indexl,0))
End
//*******************************************************************************************************************************
Proc Add_bottom(from,to,exception)
	Variable From
	Variable to
	String exception
	Prompt from,"From"
	Prompt to,"To"
	Prompt exception,"Name of wave:"
	Pauseupdate;Silent 1
	String thisdata
	Variable i,j
	Variable condition
	thisdata="data"+num2str(from)
	Duplicate/O $thisdata resultmat
	resultmat[][]=0
	i=from
	Do
		thisdata="data"+num2str(i)
		condition=1
		j=0
		Do
			if($exception[j]==i)
				condition=0
			Endif
			j+=1
		While(j<dimsize($exception,0))
		if(condition==1)
			resultmat[][]+=$thisdata[p][q]
		Endif
		i+=1
	While(i<to+1)
	Make/O/N=(dimsize(resultmat,0)) NKwave
	NKwave[]=0
	i=0//dimsize(resultmat,1)-1
	print i
	j=0
	Do
		NKwave[]+=resultmat[p][i]
		i+=1
		j+=1
	While(j<10)
	wavestats/Q NKwave
	NKwave[]/=V_avg
	Display NKwave
End
//*******************************************************************************************************************************
Proc Add_above(from,to,exception,number_of_points)
	Variable From
	Variable to
	String exception="nowave"
	Variable number_of_points
	Prompt from,"From"
	Prompt to,"To"
	Prompt exception,"Name of wave:"
	Prompt number_of_points,"Number of points:"
	Pauseupdate;Silent 1
	String thisdata
	Variable i,j
	Variable condition
	thisdata="data"+num2str(from)
	Duplicate/O $thisdata resultmat
	resultmat[][]=0
	If(cmpstr("nowave",exception)==0)
		Make/O/N=0 nowave
	Endif
	i=from
	Do
		thisdata="data"+num2str(i)
		condition=1
		j=0
		Do
			if($exception[j]==i)
				condition=0
			Endif
			j+=1
		While(j<dimsize($exception,0))
		if(condition==1)
			resultmat[][]+=$thisdata[p][q]
		Endif
		i+=1
	While(i<to+1)
	Make/O/N=(dimsize(resultmat,0)) NKabove
	NKabove[]=0
	i=dimsize(resultmat,1)-1
	print i
	j=0
	Do
		NKabove[]+=resultmat[p][i]
		i-=1
		j+=1
	While(j<number_of_points)    //20
	wavestats/Q NKabove
	NKabove[]/=V_avg
	Display NKabove
	If(cmpstr("nowave",exception)==0)
		killwaves nowave
	Endif	
End
//*******************************************************************************************************************************
Proc Add_all(from,to,exception)
	Variable From
	Variable to
	String exception="nowave"
	Prompt from,"From"
	Prompt to,"To"
	Prompt exception,"Name of wave:"
	Pauseupdate;Silent 1
	String thisdata
	Variable i,j
	Variable condition
	thisdata="data"+num2str(from)
	Duplicate/O $thisdata resultmat
	resultmat[][]=0
	i=from
	Do
		thisdata="data"+num2str(i)
		condition=1
		if(Cmpstr(exception,"nowave")!=0)
			j=0
			Do
				if($exception[j]==i)
					condition=0
				Endif
				j+=1
			While(j<dimsize($exception,0))
		Endif
		if(condition==1)
			resultmat[][]+=$thisdata[p][q]
		Endif
		i+=1
	While(i<to+1)
	Make/O/N=(dimsize(resultmat,0)) NKall
	NKall[]=0
	i=dimsize(resultmat,1)-1
	print i
	j=0
	Do
		NKall[]+=resultmat[p][j]
//		i-=1
		j+=1
	While(j<50)dimsize(resultmat,1))
	wavestats/Q NKall
	NKall[]/=V_avg
	Display NKall
End
//*******************************************************************************************************************************
Proc FeTeTdep(T1index,T2index, combined,shownumber, Flevel)
	Variable T1index
	Variable T2index
	Variable combined
	Variable shownumber
	Variable Flevel
	Prompt T1index,"Index of T1"
	Prompt T2index,"Index of T2"
	Prompt combined,"number of EDCs to combine:"
	Prompt shownumber,"Show every ...:"
	Prompt Flevel, "Fermi level:"
	Pauseupdate;Silent 1
	String name1,name2
	String this1,this2
	Variable i,ifirst,ilast,j
	name1="TK"+num2str(Kvector[T1index])
	name2="TK"+num2str(Kvector[T2index])	
	Display
	i=0
	Do
		this1=name1+"_"+num2str(i)
		this2=name2+"_"+num2str(i)	
		Make/O/N=(dimsize($name1,1)) $this1
		Make/O/N=(dimsize($name2,1)) $this2
		$this1[]=0
		$this2[]=0
		Setscale/P x,dimoffset($name1,1)-Flevel,dimdelta($name1,1),""$this1
		Setscale/P x,dimoffset($name2,1)-Flevel,dimdelta($name2,1),""$this2
		if(Floor(i-(combined-1)/2)<0)
			ifirst=0
			Else
				ifirst=Floor(i-(combined-1)/2)
		Endif
		If(ifirst+combined>	dimsize($name1,0)-1)
			ilast=dimsize($name1,0)-1
			Else
				ilast=ifirst+combined
		Endif
		j=0
		Do
			$this1[]+=$name1[ifirst+j][p]
			$this2[]+=$name2[ifirst+j][p]
			j+=1
		While(ifirst+j<=ilast)
		$this1[]/=(j-1)
		$this2[]/=(j-1)
		Wavestats/Q/R=[0,10] $this1
		$this1[]/=V_avg
		Wavestats/Q/R=[0,10] $this2		
		$this2[]/=V_avg
		Appendtograph $this1,$this2
		ModifyGraph rgb($this1)=(0,0,65535)							
		i+=shownumber
	While(i<dimsize($name1,0))
	Legend/C/N=text0/J/B=1/F=0/A=MC "\Z14\\s("+this1+") "+num2str(Kvector[T1index])+" K\r\\s("+this2+") "+num2str(Kvector[T2index])+" K"
End
End
//*******************************************************************************************************************************
Proc FeTeTdepslice(thisslice, combined,Flevel)
	Variable thisslice
	Variable combined
	variable Flevel
	Prompt thisslice,"Slice:"
	Prompt combined,"number of EDCs to combine:"
	Prompt Flevel, "Flevel:"
	Pauseupdate;Silent 1
	String name1
	String this1,legendstring
	Variable i,ifirst,ilast,j
	name1="TK"+num2str(Kvector[0])
	Make/O/N=(dimsize(Kvector,0),dimsize($name1,1)) FeTeTdepslicematrix
	Setscale/P x,0,1,""FeTeTdepslicematrix
	Setscale/P y,dimoffset($name1,1)-Flevel,dimdelta($name1,1),""FeTeTdepslicematrix
	Make/O/N=(dimsize($name1,1)) ttempvec
	Setscale/P x,dimoffset($name1,1)-Flevel,dimdelta($name1,1),""ttempvec	 	
	legendstring="\Z12\\s("+"TK"+num2str(Kvector[0])+"_"+num2str(thisslice)+") "+num2str(Kvector[0])+" K"
	Display
	i=0
	Do
		name1="TK"+num2str(Kvector[i])
		this1=name1+"_"+num2str(thisslice)
		Make/O/N=(dimsize($name1,1)) $this1
		$this1[]=0
		Setscale/P x,dimoffset($name1,1)-Flevel,dimdelta($name1,1),""$this1
		if(i!=0)
			legendstring+="\r\Z12\\s("+this1+") "+num2str(Kvector[i])+" K"
		Endif
		if(Floor(thisslice-(combined-1)/2)<0)
			ifirst=0
			Else
				ifirst=Floor(thisslice-(combined-1)/2)
		Endif
		If(ifirst+combined>	dimsize($name1,0)-1)
			ilast=dimsize($name1,0)-1
			Else
				ilast=ifirst+combined
		Endif
		j=0
		Do
			$this1[]+=$name1[ifirst+j][p]
			j+=1
		While(ifirst+j<=ilast)
		$this1[]/=(j-1)
		Wavestats/Q/R=[0,10] $this1
		$this1[]/=V_avg
		Appendtograph $this1
		Duplicate/O $this1 thistempvec
		transform2equiv_waves("ttempvec","thistempvec")
		FeTeTdepslicematrix[i][]=thistempvec[q]
		i+=1
	While(i<dimsize(Kvector,0))
	color_edc()
	Legend/C/N=text0/J/B=1/F=0/A=MC legendstring
	Display;appendimage FeTeTdepslicematrix
End
//*******************************************************************************************************************************
Proc ellipse4silver()
	Pauseupdate;Silent 1
	Variable i,j
	Make/O/N=(301,301) back4silver
	Setscale/I x,-150,150,""back4silver
	Setscale/I y,-150,150,""back4silver
	back4silver[]=NaN
	Make/O/N=201 el1x
	Make/O/N=201 el2x
	Make/O/N=201 el1y
	Make/O/N=201 el2y
	el1x[]=(400/4)*cos(2*pi*p/200)
	el1y[]=(400/16)*sin(2*pi*p/200)
	el2x[]=(400/16)*cos(2*pi*p/200)
	el2y[]=(400/4)*sin(2*pi*p/200)
	Display;appendimage back4silver
	appendtograph el1y vs el1x
	appendtograph el2y vs el2x
	i=0
	Do
		j=0
		Do
			
			j+=1
		While(j<dimsize(back4silver,1))
		i+=1
	While(i<dimsize(back4silver,0))
							 	
End
//*******************************************************************************************************************************
Proc sm_allcuts()
	Pauseupdate;Silent 1
	string cutname,sname
	Variable i,j
	
	i=0
	Do
		cutname="cut"+num2str(phiindex[i])
		sname=cutname+"VS"
		smoothmat_k(cutname,5,5,1)
		Duplicate/O $cutname,$sname
		i+=1
	while(i<dimsize(phiindex,0))
End
//*******************************************************************************************************************************
Proc labelT()
	Pauseupdate;Silent 1
	String thisstring,thissecondstring,thisfulstring
	Variable i
	thissecondstring="\""
	print thissecondstring
	i=0
	Do
		thisstring="\\Z14"+num2str(templistlabel[i])+" K"
		thisfulstring="TextBox/C/N=text"+num2str(i)+"/F=0/B=1/A=MC "+"\""+thisstring+"\""
		Execute thisfulstring
		i+=1
	while(i<dimsize(templistlabel,0))
End
//*******************************************************************************************************************************
Proc adjust_meV()
	Pauseupdate;Silent 1
	String thisname	
	Variable i
	i=395
	Do
		thisname="Ecut0deg_5_"+num2str(i)+"_391_644"
		Smooth/E=3/B=3 3,$thisname
		Setscale/P x, dimoffset($thisname,0)*1000,dimdelta($thisname,0)*1000,""$thisname
		i+=5
	while(i<641)
End
//*******************************************************************************************************************************
Proc adjust_col()
	Pauseupdate;Silent 1
	String thisname	
	Variable i
	i=395
	Do
		thisname="Ecut0deg_5_"+num2str(i)+"_391_644"
		ModifyGraph rgb($thisname)=(65535,0,0)
		i+=5
	while(i<641)
End
//*******************************************************************************************************************************
Proc sm_mdc()
	Pauseupdate;Silent 1
	String thisname	
	Variable i
	i=87
	Do
		thisname="mcut0deg_3_"+num2str(i)+"_392_644"
		Smooth/E=3/B=3 3, $thisname
//		ModifyGraph rgb($thisname)=(65535,0,0)
		i+=3
	while(i<165)
End
//*******************************************************************************************************************************
Proc load_conefigs()
	Pauseupdate;Silent 1
	String thisname	
	Variable i
	i=-30
	Do
		If(i<0)
			thisname="cone_"+num2str(ABS(i))+"deg"
			Else
				thisname="cone"+num2str(ABS(i))+"deg"
		Endif
		File2wave(thisname)
		i+=15
	while(i<121)
End
//*******************************************************************************************************************************
Proc plot_cone25K()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	Variable i
	i=-30
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"deg"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"deg"				
				nameofwindow=thisname+"_graph"
		Endif
//		Display; appendimage $thisname
		Dowindow/F $nameofwindow
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		CutNaNedges(thisname)
//		wave2filenokill(thisname)		
		ModifyImage $thisname ctab= {0,0.0006819511764,ColdWarm,0}
		ModifyGraph fSize=12,manTick(left)={0,40,0,0},manMinor(left)={3,0}
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={4,0}
		ModifyGraph noLabel=1
//		Label left "\\Z18\\F'arial'E-E\\BF\\M\\Z18\\F'arial' (meV)"
//		Label bottom "\\Z18\\F'arial'Momentum (\\F'symbol'p\\Z18\\F'arial'/a)"
		SetAxis left -100,55
		If(dimoffset($thisname,0)<-0.25)
			SetAxis bottom -0.25,0.25
			Else
				SetAxis bottom *,0.25
		Endif			
		ModifyGraph height=180
		ModifyGraph width={perUnit,250,bottom}
		SetDrawEnv xcoord= bottom,ycoord= left,linefgc= (65535,65535,65535),dash= 3
		DrawLine -0.25,0,0.25,0
		TextBox/C/N=text0/B=1/F=0/A=MT/X=0/Y=0 "\\K(65535,0,0)\\Z22\\F'arial'"+num2str(i)+"¼"
		Dowindow/C $nameofwindow
		i+=15
	While(i<121)
//*******************************************************************************************************************************
Proc plot_cone25KVD()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	Variable i
	i=-30
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"degVD"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"degVD"				
				nameofwindow=thisname+"_graph"
		Endif
//		Display; appendimage $thisname
		Dowindow/F $nameofwindow
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		CutNaNedges(thisname)
//		wave2filenokill(thisname)		
		ModifyImage $thisname ctab= {-1.789447197e-06,0,Terrain,1}
		ModifyGraph fSize=12,manTick(left)={0,40,0,0},manMinor(left)={3,0}
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={4,0}
		ModifyGraph noLabel=1
//		Label left "\\Z18\\F'arial'E-E\\BF\\M\\Z18\\F'arial' (meV)"
//		Label bottom "\\Z18\\F'arial'Momentum (\\F'symbol'p\\Z18\\F'arial'/a)"
		SetAxis left -100,55
		If(dimoffset($thisname,0)<-0.25)
			SetAxis bottom -0.25,0.25
			Else
				SetAxis bottom *,0.25
		Endif			
		ModifyGraph height=180
		ModifyGraph width={perUnit,250,bottom}
		SetDrawEnv xcoord= bottom,ycoord= left,linefgc= (65535,65535,65535),dash= 3
		DrawLine -0.25,0,0.25,0
		TextBox/C/N=text0/B=1/F=0/A=MT/X=0/Y=0 "\\K(65535,0,0)\\Z22\\F'arial'"+num2str(i)+"¼"
		Dowindow/C $nameofwindow
		i+=15
While(i<121)
//*******************************************************************************************************************************
Proc plot_cone25KHD()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	Variable i
	i=0
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"degHD"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"degHD"				
				nameofwindow=thisname+"_graph"
		Endif
//		Display; appendimage $thisname
		Dowindow/F $nameofwindow
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		CutNaNedges(thisname)
//		wave2filenokill(thisname)		
		ModifyImage $thisname ctab= {*,0,Terrain,1}
		ModifyGraph fSize=12,manTick(left)={0,40,0,0},manMinor(left)={3,0}
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={4,0}
		ModifyGraph noLabel=1
//		Label left "\\Z18\\F'arial'E-E\\BF\\M\\Z18\\F'arial' (meV)"
//		Label bottom "\\Z18\\F'arial'Momentum (\\F'symbol'p\\Z18\\F'arial'/a)"
		SetAxis left -100,55
		If(dimoffset($thisname,0)<-0.25)
			SetAxis bottom -0.25,0.25
			Else
				SetAxis bottom *,0.25
		Endif			
		ModifyGraph height=180
		ModifyGraph width={perUnit,250,bottom}
		SetDrawEnv xcoord= bottom,ycoord= left,linefgc= (65535,65535,65535),dash= 3
		DrawLine -0.25,0,0.25,0
		TextBox/C/N=text0/B=1/F=0/A=MT/X=0/Y=0 "\\K(65535,65535,65535)\\Z22\\F'arial'"+num2str(i)+"¼"
		ModifyGraph noLabel(bottom)=0
		ModifyGraph fSize(bottom)=14
		Dowindow/C $nameofwindow
		i+=15
While(i<91)

//*******************************************************************************************************************************
Proc plot_colorangle25KHD()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	Variable i
	i=0
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"degVD"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"degVD"				
				nameofwindow=thisname+"_graph"
		Endif
//		Display; appendimage $thisname
		Dowindow/F $nameofwindow
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		CutNaNedges(thisname)
//		wave2filenokill(thisname)		

//		Label left "\\Z18\\F'arial'E-E\\BF\\M\\Z18\\F'arial' (meV)"
//		Label bottom "\\Z18\\F'arial'Momentum (\\F'symbol'p\\Z18\\F'arial'/a)"
		TextBox/C/N=text0/B=1/F=0/A=MT/X=0/Y=0 "\\K(65535,65535,0)\\Z22\\F'arial'"+num2str(i)+"¼"
//		ModifyGraph noLabel(bottom)=0
//		ModifyGraph fSize(bottom)=14
//		Dowindow/C $nameofwindow
		i+=15
While(i<91)
//*******************************************************************************************************************************
Proc readjusth_IVH()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	Variable i
	i=0
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"deg"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"deg"				
				nameofwindow=thisname+"_graph"
		Endif
		Dowindow/F $nameofwindow
		SetAxis left -100,35
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"degVD"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"degVD"				
				nameofwindow=thisname+"_graph"
		Endif
		Dowindow/F $nameofwindow
		SetAxis left -100,35
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"degHD"
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"degHD"				
				nameofwindow=thisname+"_graph"
		Endif
		Dowindow/F $nameofwindow
		SetAxis left -100,35		
		i+=15
While(i<91)
//*******************************************************************************************************************************
Proc sm_edc()
	Pauseupdate;Silent 1
	String thisname	
	Variable i
	i=40
	Do
		thisname="Econe90deg_5_"+num2str(i)+"_37_220"
		$thisname[]*=1000
	//	Smooth/E=3/B=3 3, $thisname
//		ModifyGraph rgb($thisname)=(65535,0,0)
		i+=5
	while(i<221)
End
//*******************************************************************************************************************************
Proc loadnplot()
	PauseUpdate;Silent 1
	string thisname
	String nameofwindow
	String thisnameHD
	Variable i
	i=0
	Do
		IF(i<0)
			thisname="cone_"+num2str(ABS(i))+"deg"
			thisnameHD="cone_"+num2str(ABS(i))+"degHD"			
			nameofwindow=thisname+"_graph"
			Else
				thisname="cone"+num2str(ABS(i))+"deg"				
				thisnameHD="cone"+num2str(ABS(i))+"degHD"				
				nameofwindow=thisname+"_graph"
		Endif
//		file2wave(thisname)
		derivmat(thisname,9,9,2)
//		Display; appendimage $thisnameHD
//		Dowindow/F $nameofwindow
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		CutNaNedges(thisname)
//		wave2filenokill(thisname)		

//		Label left "\\Z18\\F'arial'E-E\\BF\\M\\Z18\\F'arial' (meV)"
//		Label bottom "\\Z18\\F'arial'Momentum (\\F'symbol'p\\Z18\\F'arial'/a)"
//		TextBox/C/N=text0/B=1/F=0/A=MT/X=0/Y=0 "\\K(65535,65535,0)\\Z22\\F'arial'"+num2str(i)+"¼"
//		ModifyGraph noLabel(bottom)=0
//		ModifyGraph fSize(bottom)=14
		Dowindow/C $nameofwindow
		i+=5
While(i<91)
//*******************************************************************************************************************************
Function func_double_elipse(para,x) : fitfunc
	Wave para
	Variable x
	Pauseupdate;Silent 1
	Variable result
	If(x<=90)
		result=sqrt((para[0]*cos(x*pi/180))^2+(para[1]*sin(x*pi/180))^2)
		Else
			result=sqrt((para[3]*cos(x*pi/180))^2+(para[1]*sin(x*pi/180))^2)
	Endif
	Return result
End
//*******************************************************************************************************************************
Proc double_elipse(waveangle,wavesize)
	String waveangle
	String wavesize
	Prompt waveangle,"Enter the wave with the angles"
	Prompt wavesize,"Enter the wave with the sizes"
	Pauseupdate;Silent 1
	Variable i,thisangle
	Make/O/N=3 paraelipse
	paraelipse[0]=18
	paraelipse[1]=18
	paraelipse[2]=18
	FuncFit/H="000" func_double_elipse paraelipse  $wavesize  /X={$waveangle}
	edit paraelipse
	Make/O/N=361 elipsex
	Make/O/N=361 elipsey
	i=0
	Do
		thisangle=360*i/360
		if((90<thisangle)&&(thisangle<270))
			elipsex[i]=paraelipse[2]*cos(thisangle*pi/180)
			elipsey[i]=paraelipse[1]*sin(thisangle*pi/180)
			Else
				elipsex[i]=paraelipse[0]*cos(thisangle*pi/180)
				elipsey[i]=paraelipse[1]*sin(thisangle*pi/180)
		Endif
		i+=1
	While(i<dimsize(elipsex,0))
//	display elipsey vs elipsex		
End
//*******************************************************************************************************************************
Proc put_error_bars_on_VF()
	Pauseupdate;Silent 1
	String newnamex,newnamey
	Variable i
	i=0
	Do
		newnamex="Eoriginalx"+num2str(i)
		newnamey="Eoriginaly"+num2str(i)
		Duplicate/O modelx $newnamex
		Duplicate/O modely $newnamey
		rot_vector(newnamex,newnamey,angleofslopeoriginal[i]+90,0,0)
		$newnamex[]+=xoriginal[i]
		$newnamey[]+=yoriginal[i]
//		appendtograph $newnamey vs $newnamex				
		i+=1
	While(i<dimsize(xoriginal,0))
	i=0
	Do
		newnamex="Esymx"+num2str(i)
		newnamey="Esymy"+num2str(i)
		Duplicate/O modelx $newnamex
		Duplicate/O modely $newnamey
		rot_vector(newnamex,newnamey,angleofslopesym[i]+90,0,0)
		$newnamex[]+=xsym[i]
		$newnamey[]+=ysym[i]
//		appendtograph $newnamey vs $newnamex				
		i+=1
	While(i<dimsize(xsym,0))	
End
//*******************************************************************************************************************************
Function DrawconeBFA()
	Pauseupdate;Silent 1
	Wave elipseangle
	Wave elipsex
	Wave elipsey
	String toexecute
	Variable thisangle
	Variable i,j
	Variable VF
	Make/O/N=51 tempz
	tempz[]=-25+p*25/50
	Make/O/N=0 xcone
	Make/O/N=0 ycone
	Make/O/N=0 zcone	
	i=0
	Do
		thisangle=elipseangle[i]
		VF=-sqrt(elipsex[i]^2+elipsey[i]^2)*1.1
		Duplicate/O tempz tempx
		Duplicate/O tempz tempy
		tempx[]=tempz[p]*cos(thisangle*pi/180)/VF
		tempy[]=tempz[p]*sin(thisangle*pi/180)/VF
		Insertpoints 0,dimsize(tempz,0),xcone
		Insertpoints 0,dimsize(tempz,0),ycone
		Insertpoints 0,dimsize(tempz,0),zcone		
		xcone[0,dimsize(tempz,0)-1]=tempx[p]
		ycone[0,dimsize(tempz,0)-1]=tempy[p]								
		zcone[0,dimsize(tempz,0)-1]=tempz[p]								
		i+=1
	While(i<dimsize(elipseangle,0))
	Killwaves tempz,tempx,tempy
	Display;AppendXYZContour zcone vs {xcone,ycone}
	Make/O/N=(300,300) thecone
	Setscale/I x,-0.075,0.075,""thecone
	Setscale/I y,-0.075,0.075,""thecone
	thecone[][]=Contourz("","zcone",0,dimoffset(thecone,0)+dimdelta(thecone,0)*p,dimoffset(thecone,1)+dimdelta(thecone,1)*q)
	toexecute="zeronan(\"thecone\")"	
	Execute toexecute
//	i=0
//	Do
//		if(mod(i,100)==0)
//			print i,"/",dimsize(thecone,0)-1
//		Endif
//		j=0
//		Do
//			IF(thecone[i][j]<-20)
//				thecone[i][j]=NaN
//			Endif
//			j+=1
//		While(j<dimsize(thecone,1))
//		i+=1
//	While(i<dimsize(thecone,0))
	Display;appendimage thecone 
End
//*******************************************************************************************************************************
Function remove20cone()
	Pauseupdate;Silent 1
	Wave thecone
	Variable thisangle
	Variable i,j
	Variable VF
	i=0
	Do
		if(mod(i,100)==0)
			print i,"/",dimsize(thecone,0)-1
		Endif
		j=0
		Do
			IF(thecone[i][j]<-20.2)
				thecone[i][j]=NaN
			Endif
			j+=1
		While(j<dimsize(thecone,1))
		i+=1
	While(i<dimsize(thecone,0))
	Display;appendimage thecone 
End
//*******************************************************************************************************************************
Proc makereversecone()
	Pauseupdate;Silent 1
	Duplicate/O thecone theconeR
	theconeR[][]-=1
	theconeR[][]*=-1
	theconeR[][]+=1
	Setscale/P x,-dimoffset(thecone,0),-dimdelta(thecone,0),""theconeR
End
//*******************************************************************************************************************************
Proc readcontour()
	Pauseupdate;Silent 1
	Variable i
	i=0
	Do
		Cursor/P A,'thecone=-8',i	
		readcsr()
		i+=1
	While(i<391)
End
//*******************************************************************************************************************************
Proc Makearcshadow(matname,csize,cwidth,arc1,arc2)
	string matname
	Variable csize
	Variable cwidth
	Variable arc1
	Variable arc2
	Prompt matname,"Enter the name of the matrix"
	Prompt csize,"Size of the circle"
	Prompt cwidth,"Width"
	Prompt arc1,"From"
	Prompt arc2,"To"
	Pauseupdate;Silent 1
	Variable i,j,angle
	Variable distance
	Variable thisx,thisy
	func_Makearcshadow($matname,csize,cwidth,arc1,arc2)
End
//*******************************************************************************************************************************
Function func_Makearcshadow(matname,csize,cwidth,arc1,arc2)
	Wave matname
	Variable csize
	Variable cwidth
	Variable arc1
	Variable arc2
	Pauseupdate;Silent 1
	Variable i,j,angle
	Variable distance
	Variable thisx,thisy
	print csize,cwidth,arc1,arc2
	angle=Round(arc1)
	Do
		if(Mod(angle,10)==0)
			print angle
		Endif
		thisx=csize*cos(angle*pi/180)
		thisy=csize*sin(angle*pi/180)	
		i=0
		Do
			j=0
			Do
				distance=(dimoffset(matname,0)+i*dimdelta(matname,0)-thisx)^2+(dimoffset(matname,1)+j*dimdelta(matname,1)-thisy)^2
				IF(distance<cwidth*cwidth)
					matname[i][j]=1
				Endif
				j+=1
			While(j<dimsize(matname,1))
			i+=1
		While(i<dimsize(matname,0))
		angle+=1
	While(angle<arc2)
End
//*******************************************************************************************************************************
Proc temp33()
	Pauseupdate;Silent 1
	string thisname,thisname1
	Variable i,j
	i=0
	Do
		thisname="EGM25K_5_2_"+num2str(i)+"_0_66"
		smooth/E=3/B=2 2,$thisname
		i+=2
	While(i<67)
End
//*******************************************************************************************************************************
Proc temp34()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	Variable i,j
	j=0						
	i=0
	Do
		thisname="M_"+num2str(i)
		thisname1="M_"+num2str(i)+"sym"
//		Setscale/P y,dimoffset($thisname,1)*1000,dimdelta($thisname,1)*1000,""$thisname
//		namewin="Graph"+num2str(j)
//		Dowindow/F $namewin
//		ModifyImage $thisname ctab= {*,*,ColdWarm,0}
//		SetAxis bottom -0.45,*
//		SetAxis left -150,30
//		namewin=thisname+"_Graph"
//		Dowindow/C $namewin
		Shift_and_sym_edc_matrix_far(thisname,0)
		ModifyImage $thisname1 ctab= {*,*,ColdWarm,0}
		SetAxis bottom -0.45,*
		SetAxis left -150,150
		namewin=thisname1+"_Graph"
		Dowindow/C $namewin
		derivmat(thisname,5,5,1)
		SetAxis bottom -0.45,*
		SetAxis left -150,30
		namewin=thisname+"VD_Graph"
		Dowindow/C $namewin
		derivmat(thisname1,5,5,1)
		SetAxis bottom -0.45,*
		SetAxis left -150,150
		namewin=thisname1+"VD_Graph"
		Dowindow/C $namewin								
		i+=5
		j+=1
	While(i<46)
End
//*******************************************************************************************************************************
Proc temp35()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)
//		thisname1="M_"+num2str(i)+"sym"
		namewin=thisname+"_Graph"
		Dowindow/F $namewin
		ModifyGraph width={perUnit,200,bottom},height={perUnit,1.5,left}
		ModifyGraph manTick(left)={0,50,0,0},manMinor(left)={4,0};DelayUpdate
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={3,0}
		ModifyGraph fSize=14
		ModifyGraph noLabel=0		
		i+=5
	While(i<46)
End
//*******************************************************************************************************************************
Proc temp36()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)
		thisname1="M_"+num2str(i)+"sym"
		namewin=thisname1+"_Graph"
		Dowindow/F $namewin
		ModifyGraph width={perUnit,200,bottom},height={perUnit,1.5,left}
		ModifyGraph manTick(left)={0,50,0,0},manMinor(left)={4,0};DelayUpdate
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={3,0}
		ModifyGraph fSize=14
		ModifyGraph noLabel=0		
		i+=5
	While(i<46)
End
//*******************************************************************************************************************************
Proc temp37()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)+"VD"
		thisname1="M_"+num2str(i)+"sym"
		namewin=thisname+"_Graph"
		Dowindow/F $namewin
		ModifyGraph width={perUnit,200,bottom},height={perUnit,1.5,left}
		ModifyGraph manTick(left)={0,50,0,0},manMinor(left)={4,0};DelayUpdate
		ModifyGraph manTick(bottom)={0,0.2,0,1},manMinor(bottom)={3,0}
		ModifyGraph fSize=14
		ModifyGraph noLabel=0		
		i+=5
	While(i<46)
End
//*******************************************************************************************************************************
Proc temp38()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	String thisEDC,thisEDCsym
	Variable i,j
	Display
	i=0
	Do
		thisname="M_"+num2str(i)
		thisname1="M_"+num2str(i)+"sym"
		thisEDC=thisname+"_Lambda"
		thisEDCsym=thisname1+"_Lambda"		
		comb_krange(thisname,thisEDC,-0.25,0.05)
		Appendtograph $thisEDC
		comb_krange(thisname1,thisEDCsym,-0.25,0.05)
		i+=5
	While(i<46)
	Display
	i=0
	Do
		thisname1="M_"+num2str(i)+"sym"
		thisEDCsym=thisname1+"_Lambda"		
		Appendtograph $thisEDCsym
		i+=5
	While(i<46)
End
//*******************************************************************************************************************************
Proc temp39()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	String thisEDC,thisEDCsym
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)
		thisname1="M_"+num2str(i)+"sym"
		thisEDC=thisname+"_Lambda"
		Wavestats/Q $thisEDC
		$thisEDC[]/=V_avg
		i+=5
	While(i<46)

End
//*******************************************************************************************************************************
Proc temp40()
	Pauseupdate;Silent 1
	string thisname,thisname1,namewin
	String thisEDC,thisEDCsym
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)
		thisname1="M_"+num2str(i)+"sym"
		thisEDC=thisname+"_Lambda"
		Wavestats/Q $thisEDC
		$thisEDC[]/=V_avg
		i+=5
	While(i<46)
End
//*******************************************************************************************************************************
Function temp41()
	PauseUpdate;Silent 1
	Wave mat3dk
	Variable i,j
	i=0
	Do
		If(mod(i,50)==0)
			print i,"/",dimsize(mat3dk,0)
		Endif
		j=0
		Do
			Make/O/N=(dimsize(mat3dk,2)) thistemp
			Setscale/P x,dimoffset(mat3dk,2),dimdelta(mat3dk,2),""thistemp
			thistemp[]=mat3dk[i][j][p]
			Wavestats/Q thistemp
			If(V_numNans==0)
				mat3dk[i][j][]/=V_avg
				Else
					mat3dk[i][j][]=NaN
			Endif
			j+=1
		While(j<dimsize(mat3dk,1))
		i+=1
	While(i<dimsize(mat3dk,0))	
	killwaves thistemp
End
//*******************************************************************************************************************************
Proc temp42()
	PauseUpdate;Silent 1
	String thisname
	Variable i,j
	i=0
	Do
		thisname="M_"+num2str(i)+"_Lambda"
		wave2filenokill(thisname)
		thisname="M_"+num2str(i)+"LEG"
		wave2filenokill(thisname)		
		i+=5
	While(i<46)	
End
//*******************************************************************************************************************************
Proc temp45()
	PauseUpdate;Silent 1
	String thisname
	Variable i,j
	Display
	i=0
	Do
		thisname="M_"+num2str(i)+"_Lambda"
		file2wave(thisname)
		thisname="M_"+num2str(i)+"LEG"
		file2wave(thisname)
		appendtograph $thisname		
		i+=5
	While(i<46)	
End
//*******************************************************************************************************************************
Proc temp47()
	PauseUpdate;Silent 1
	String thisname
	Variable i,j
	Make/O/N=(dimsize(map25Kdown,0),601)  mapsym
	Setscale/P x,dimoffset(map25Kdown,0),dimdelta(map25Kdown,0),""mapsym
	Setscale/I y,dimoffset(map25Kdown,1),-dimoffset(map25Kdown,1),""mapsym
	mapsym[][0,300]=	interp2D(map25Kdown,dimoffset(mapsym,0)+p*dimdelta(mapsym,0),dimoffset(mapsym,1)+q*dimdelta(mapsym,0))
	mapsym[][301,*]=	interp2D(map25Kdown,dimoffset(mapsym,0)+p*dimdelta(mapsym,0),dimoffset(mapsym,1)+(600-q)*dimdelta(mapsym,0))	
	Display;appendimage mapsym
End
//*******************************************************************************************************************************
Function temp43(mat3dkfirstVD)
	Wave mat3dkfirstVD
	PauseUpdate;Silent 1
	Variable i,j
	i=0
	Do
		j=0
		Do
			Make/O/N=(dimsize(mat3dkfirstVD,2)) thisEDC
			thisEDC[]=mat3dkfirstVD[i][j][p]
			smooth/E=3/B=3 3, thisEDC
			differentiate thisEDC
			mat3dkfirstVD[i][j][]=thisEDC[r]
			j+=1
		While(j<dimsize(mat3dkfirstVD,1))
		i+=1
	While(i<dimsize(mat3dkfirstVD,0))	
End
//*******************************************************************************************************************************
Proc put_curved_thicksH(name,Large_step,putfrom,putto,arclarge,smallnum,updateput)
	String name
	Variable Large_step
	Variable putfrom
	Variable putto
	Variable arclarge=5
	Variable smallnum=4
	Variable updateput
	Prompt name,"Give a name"
	Prompt Large_step,"Enter the stepsize"
	Prompt putfrom,"Minimum horizontal"
	Prompt putto,"Max horizontal"
	Prompt arclarge,"Thicks size (degrees)"
	Prompt smallnum,"Number of small thicks per big ones"
	Prompt updateput,"Mode", popup "Update;Put"
	Pauseupdate;Silent 1
	String thisnamex,thisnamey,thissmallx,thissmally
	Variable i,j
	Variable numlargeR,numlargeL
	Variable numsmallL,numsmallR
	Variable size
	Variable distancepersmall
	//Positive part
	Make/O/N=55 modelthickx
	Make/O/N=55 modelthicky
	Make/O/N=27 modelsmallthickx
	Make/O/N=27 modelsmallthicky
	modelthickx[]=cos((p-24)*(pi/180)*arclarge/24)
	modelthicky[]=sin((p-24)*(pi/180)*arclarge/24)	
	modelsmallthickx[]=cos((p-13)*(pi/180)*arclarge/(4*13))
	modelsmallthicky[]=sin((p-13)*(pi/180)*arclarge/(4*13))	
	numlargeR=Round((putto-mod(putto,Large_step))/Large_step)
	distancepersmall=Large_step/(smallnum+1)	
	numsmallR=Round((putto-mod(putto,distancepersmall))/distancepersmall)
	i=1
	Do
		size=i*Large_step
		thisnamex=name+"_H"+num2str(i)+"x"
		thisnamey=name+"_H"+num2str(i)+"y"
		Duplicate/O modelthickx $thisnamex
		Duplicate/O modelthicky $thisnamey
		$thisnamex[]*=size
		$thisnamey[]*=size
		If(updateput==2)
			appendtograph $thisnamey vs $thisnamex
			ModifyGraph rgb($thisnamey)=(0,0,0)
		Endif				
		i+=1
	While(i<numlargeR+1)
	i=1
	Do
		size=i*distancepersmall
		thisnamex=name+"_sH"+num2str(i)+"x"
		thisnamey=name+"_sH"+num2str(i)+"y"
		Duplicate/O modelsmallthickx $thisnamex
		Duplicate/O modelsmallthicky $thisnamey
		$thisnamex[]*=size
		$thisnamey[]*=size
		If(mod(i,smallnum+1)!=0)
			If(updateput==2)
				appendtograph $thisnamey vs $thisnamex
				ModifyGraph rgb($thisnamey)=(0,0,0)
			Endif				
		Endif
		i+=1
	While(i<numsmallR+1)
	//Negative part
	Make/O/N=55 modelthickx
	Make/O/N=55 modelthicky
	Make/O/N=27 modelsmallthickx
	Make/O/N=27 modelsmallthicky
	modelthickx[]=cos(((p-24)*arclarge/24+180)*(pi/180))
	modelthicky[]=sin(((p-24)*arclarge/24+180)*(pi/180))
	modelsmallthickx[]=cos(((p-13)*arclarge/(4*13)+180)*(pi/180))
	modelsmallthicky[]=sin(((p-13)*arclarge/(4*13)+180)*(pi/180))
	numlargeL=Round((putfrom-mod(putfrom,Large_step))/Large_step)
	i=-1
	Do
		size=Abs(i*Large_step)
		thisnamex=name+"_HN"+num2str(i)+"x"
		thisnamey=name+"_HN"+num2str(i)+"y"
		Duplicate/O modelthickx $thisnamex
		Duplicate/O modelthicky $thisnamey
		$thisnamex[]*=size
		$thisnamey[]*=size
		If(mod(i,smallnum+1)!=0)
			If(updateput==2)
				appendtograph $thisnamey vs $thisnamex
				ModifyGraph rgb($thisnamey)=(0,0,0)
			Endif				
		Endif		
		i-=1
	While(i>numlargeL-1)
	Killwaves modelthickx,modelthicky,	modelsmallthickx, modelsmallthicky
End

Proc backin360(name1)
	String name1
	Prompt name1,"Enter name with angle"
	Pauseupdate;Silent 1
	Variable i
	i=0
	Do
		if($name1[i]>=360)
			$name1[i]-=360
		Endif
		i+=1
	While(i<dimsize($name1,0))	
End

Proc saveBFAcuts()
	Pauseupdate;Silent 1
	string thisname
	Variable i
	i=28
	Do
		thisname="BFA"+num2str(i)
		wave2filenokill(thisname)
		i+=1
	While(i<76)	
End

Proc loadBFAcuts()
	Pauseupdate;Silent 1
	string thisname
	Variable i
	i=28
	Do
		thisname="BFA"+num2str(i)
		file2wave(thisname)
		i+=1
	While(i<76)	
End

Proc BFA_corrposition(fixslice)
	Variable fixslice
	Prompt fixslice, "Enter the final slice position"
	Pauseupdate;Silent 1
	String thisname,nameoffirst
	Variable i
	nameoffirst="data"+num2str(imageindex[0])	
	i=0
	Do
		thisname="data"+num2str(imageindex[i])
		Setscale/P x,dimoffset($thisname,0)-(positionwave[i]-fixslice)*dimdelta($thisname,0),dimdelta($thisname,0),""$thisname
		If(i!=0)
			transform2equiv_mat(nameoffirst,thisname)
		Endif
		i+=1
	While(i<dimsize(imagephi,0))
End

Proc plotGMcalc()
	Pauseupdate;Silent 1
	String thisname
	Variable i
	i=23
	Do
		thisname="band"+num2str(i)
		Duplicate/O $thisname this1
		Duplicate/O $thisname this2
		Duplicate/O $thisname this3		
		Duplicate/O $thisname this4		
		Duplicate/O simplebandx bandx1
		Duplicate/O simplebandx bandx2
		Duplicate/O simplebandx bandx3
		Duplicate/O simplebandx bandx4		
		bandx2[]*=-1
		Sort bandx2, bandx2, this2
		bandx4[]*=-1
		Sort bandx4, bandx4, this4		
		Concatenate/O/Kill {this1,this2,this3,this4}, $thisname		
		i+=2
	While(i<38)
	bandx3[]+=2
	bandx4[]+=2
	Concatenate/O/Kill {bandx1,bandx2,bandx3,bandx4}, bandx
End

Proc EDC_GvsM()
	Pauseupdate;Silent 1
	String thisname,Mname,Gname
	Variable i
	Display;Dowindow/C GandM
	Display;Dowindow/C Monly
	Display;Dowindow/C Gonly
	Make/O/N=(19,206) Mmatonly
	Make/O/N=(19,206) Gmatonly		
	i=9
	Do
		thisname=hvcuts4kz[i]
		Gname=thisname+"G"
		Mname=thisname+"M"		
		comb_krange(thisname,Gname,0,0.08)
		comb_krange(thisname,Mname,1,0.08)	
		If(i==9)
			Duplicate/O $Gname thistempref
			Mmatonly[0][]=$Mname[q]
			Gmatonly[0][]=$Gname[q]
			Setscale/P x,47,1,""Mmatonly
			Setscale/P y,dimoffset(thistempref,0),dimdelta(thistempref,0),""Mmatonly			
			Setscale/P x,47,1,""Gmatonly	
			Setscale/P y,dimoffset(thistempref,0),dimdelta(thistempref,0),""Gmatonly												
			Else
				Duplicate/O $Gname thistempG
				Duplicate/O $Mname thistempM
				transform2equiv_waves("thistempref","thistempM")
				transform2equiv_waves("thistempref","thistempG")
				Mmatonly[i-9][]=thistempM[q]
				Gmatonly[i-9][]=thistempG[q]				
		Endif				
		Dowindow/F GandM
		Appendtograph $Gname
		Appendtograph $Mname
		ModifyGraph rgb($Mname)=(0,0,65535)
		Dowindow/F Monly
		Appendtograph $Mname
		Dowindow/F Gonly
		Appendtograph $Gname		
		i+=1
	While(i<dimsize(hvcuts4kz,0))
	Display;appendimage Gmatonly
	Display;appendimage Mmatonly	
	killwaves thistempref,thistempM,thistempG
End

Proc Symall()
	Pauseupdate;Silent 1
	String thisname
	Variable i
	i=0
	Do
		thisname="data"+num2str(add_data_index[i])
		Shift_and_sym_edc_matrix_far(thisname,16.8248)
		i+=1
	While(i<dimsize(add_data_index,0))
End

Proc numbernorm(numbpoints)
	Variable numbpoints
	Prompt numbpoints,"Enter the number of points"
	Pauseupdate;Silent 1
	Variable/G gv_groupNum
	String thisname
	Variable valuenorm
	Variable i
	thisname="data"+num2str(gv_groupNum)
	print thisname
	Make/O/N=(dimsize($thisname,0)) thiswave
	Setscale/P x,dimoffset($thisname,0),dimdelta($thisname,0),""thiswave
	thiswave[]=0
	i=0
	Do
		thiswave[]+=$thisname[p][dimsize($thisname,1)-1-i]
		i+=1
	While (i>numbpoints)
	Wavestats/Q thiswave
	valuenorm=V_avg
	print valuenorm
	sub_bline_pi(numbpoints)
//	$thisname[][]/=valuenorm
End

Proc Copynamehv()
	Pauseupdate;Silent 1
	String thisname,newname,n4EDC
	Variable valuenorm
	Variable i
	Display
	i=0
	Do
		thisname="Data"+num2str(hvofcutname[i])+"_k"
		newname="eV"+num2str(hvofcut[i])+"_k"
		n4EDC=newname+"G"
		Duplicate/O $thisname $newname
		comb_krange(newname,n4EDC,0,0.02)
		appendtograph $n4EDC
		i+=1
	While(i<dimsize(hvofcut,0))
End

Proc highlight1(matname)
	String matname
	Pauseupdate;Silent 1
	Variable i,j
	Variable index0
	//find index of 0 along 
	index0=-dimoffset($matname,1)/(dimdelta($matname,1))
	Make/O/N=(dimsize($matname,0),2*index0+1) Mat4highlight
	Setscale/P x, dimoffset($matname,0),dimdelta($matname,0),""Mat4highlight
	Setscale/I y, dimoffset($matname,1),-dimoffset($matname,1),""Mat4highlight
	i=0
	Do
		print i/dimsize(Mat4highlight,0)
		j=0
		Do
			If(dimoffset(Mat4highlight,1)+j*dimdelta(Mat4highlight,1)<0)
				Mat4highlight[i][j]=interp2D($matname,dimoffset($matname,0)+i*dimdelta($matname,0),dimoffset($matname,1)+j*dimdelta($matname,1))
				Else
					Mat4highlight[i][j]=interp2D($matname,dimoffset($matname,0)+i*dimdelta($matname,0),-(dimoffset($matname,1)+j*dimdelta($matname,1)))
			Endif				
			j+=1
		While(j<dimsize(Mat4highlight,1))
		i+=1
	While(i<dimsize(Mat4highlight,0))
	Display;appendimage Mat4highlight
End

//*******************************************************************************************************************************
Proc remove_peak_2order()
	Pauseupdate;Silent 1
	String thisdata,thisolddata
	Variable i,jfrom, jto
	thisdata="data"+num2str(41)
	thisolddata="data"+num2str(41)+"_old"
	Duplicate/O $thisdata $thisolddata
	jfrom=680
	jto=dimsize($thisdata,1)-1
	i=0
	Do
		Make/O/N=(dimsize($thisdata,1)) thiswave
		Setscale/P x,dimoffset($thisdata,1),dimoffset($thisdata,1),""thiswave
		thiswave[]=$thisdata[i][p]
		CurveFit/Q/NTHR=0/TBOX=0 lor  thiswave[jfrom,jto] /D
		Duplicate/O thiswave newwave
		newwave[]=W_coef[0]+W_coef[1]/((pnt2x(newwave,p)-W_coef[2])^2+W_coef[3])
		$thisdata[i][]-=newwave[q]
		i+=1
	While(i<dimsize($thisdata,0))
	killwaves thiswave,newwave
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc PlotVBatpoint_vs_hv(prefix,listindex,hv4VB,workwave,position, range)
	String prefix
	String listindex
	String hv4VB
	String workwave
	Variable position
	Variable range
	Prompt prefix, "Prefix:"	
	Prompt listindex, "Wave of index:"
	Prompt hv4VB, "Wave of hv:"
	Prompt workwave, "Wave of work functions:"
	Prompt position, "Center (angle or k):"
	Prompt range, "Range of integration (angle or k):"
	Pauseupdate;Silent 1
	String thisdata,thiswave,nameoffirst,matname
	Variable i
	matname="Mat4"+prefix
	Display
	i=0
	Do
		thisdata="data"+num2str($listindex[i])
		thiswave=prefix+num2str($hv4VB[i])+"_eV"
		comb_krange(thisdata,thiswave,position,range)
		Setscale/P x, dimoffset($thiswave,0)-$hv4VB[i]+$workwave[i],dimdelta($thiswave,0),""$thiswave
		if(i==0)
			nameoffirst=thiswave
			Make/O/N=(dimsize($hv4VB,0),dimsize($nameoffirst,0)) $matname
			Setscale/P x, $hv4VB[0], $hv4VB[1]-$hv4VB[0],""$matname
			Setscale/P y, dimoffset($nameoffirst,0), dimdelta($nameoffirst,0),""$matname	
			$matname[0][]=$nameoffirst[q]		
			Else
				transform2equiv_waves(nameoffirst,thiswave)
				$matname[i][]=$thiswave[q]
		Endif
		Appendtograph $thiswave
		i+=1
	While(i<dimsize($hv4VB,0))
	Display;appendimage $matname
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc Halfslit(from,to)
	Variable from
	Variable to
	Prompt from,"From"
	Prompt to,"To"
	Pauseupdate;Silent 1
	String thisdata
	Variable i
	i=from
	Do
		thisdata="Data"+num2str(i)
		Setscale/P x,-16.2,dimdelta($thisdata,0),""$thisdata
		i+=1
	While(i<to+1)
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc combine2MDCs(from,to)
	Variable from
	Variable to
	Prompt from,"From"
	Prompt to,"To"
	Pauseupdate;Silent 1
	String thisdata
	Variable i
	i=from
	Do
		thisdata="Data"+num2str(i)
		new_kres_pi(thisdata,2,1)
		i+=1
	While(i<to+1)
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc Normwithlong()
	Pauseupdate;Silent 1
	String thisdata,thiswave,nameoffirst,matname
	Variable i
	i=0
	Do
		gv_groupnum=indexnormL[i]
		ConvtOne()
		open_onedata_pi(5,0,0,1,"",10,1)
		Duplicate/O NK curve4norm
		Wavestats/Q curve4norm
		curve4norm[]/=V_avg
		gv_groupnum=indexnormS[i]
		ConvtOne()
		open_onedata_pi(4,0,0,1,"curve4norm",10,1)		
		i+=1
	While(i<dimsize(indexnormL,0))
	killwaves curve4norm
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc makingEDCgamma()
	Pauseupdate;Silent 1
	String thiswave
	Variable i
	Display
	i=0
	Do
		thiswave="Gamma"+num2str(dimoffset(imageforslicer,0)+i*dimdelta(imageforslicer,0))+"eV"
		Make/O/N=(dimsize(imageforslicer,1)) $thiswave
		Setscale/P x, dimoffset(imageforslicer,1)-0.018,dimdelta(imageforslicer,1),""$thiswave
		$thiswave[]=imageforslicer[i][p]
		appendtograph $thiswave	
		i+=1
	While(i<dimsize(imageforslicer,0))
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc temp1001()
	Pauseupdate;Silent 1
	String thisdata
	Variable i,indexdown,indexup
	i=0
	Do
		thisdata=hvcuts4kz[i]
		indexdown=round(((EFvals4kz[i]-1)-dimoffset($thisdata,1))/dimdelta($thisdata,1))
		indexup=round(((EFvals4kz[i]+0.07)-dimoffset($thisdata,1))/dimdelta($thisdata,1))		
		normcut(thisdata,indexdown,indexup)
		i+=1
	While(i<dimsize(EFvals4kz,0))
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc normmat3d(name)
	String name
	Prompt name,"Enter the name of the matrix"
	Pauseupdate;Silent 1
	Variable i,j
	i=0
	Do
		if(mod(i,5)==0)
			print i,"/",dimsize($name,0)
		Endif
		j=0
		Do
			Make/O/N=(dimsize($name,1)) thiswave
			thiswave[]=$name[i][p][j]
			Wavestats/Q thiswave
			thiswave[]/=V_avg
			$name[i][][j]=thiswave[q]
			j+=1
		While(j<dimsize($name,2))
		i+=1
	While(i<dimsize($name,0))
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Proc makebold(matname,curvenamex,curvenamey,width)
	String matname
	String curvenamex
	String curvenamey	
	Variable width
	Prompt matname,"Enter the name of the matrix"
	Prompt curvenamex, "Enter the name of the curve in x"
	Prompt curvenamey, "Enter the name of the curve in y"	
	Prompt width, "Enter the Gaussian width"		
	Pauseupdate;Silent 1
//	Variable i,j,bestpoint, bestdistance
	Variable norm0
	Duplicate/O $curvenamex distance
	Make/O/N=(dimsize($matname,0)) profilecurve
	Setscale/P x,0,dimdelta($matname,0),""profilecurve
	profilecurve[]=Gauss(dimoffset(profilecurve,0)+p*dimdelta(profilecurve,0),0,width)
	norm0=profilecurve[0]
	profilecurve[]/=norm0
	Duplicate/O profilecurve xwaveprofile
	xwaveprofile[]=dimoffset(profilecurve,0)+p*dimdelta(profilecurve,0)
	$matname[][]=0
	Func_makebold($matname,$curvenamex,$curvenamey,profilecurve,xwaveprofile,distance)
//	i=0
//	Do
//		IF(mod(i,50)==0)
//			print i
//		Endif	
//		j=0
//		Do
//			distance[]=($curvenamex[p]-(dimoffset($matname,0)+i*dimdelta($matname,0)))^2+($curvenamey[p]-(dimoffset($matname,1)+j*dimdelta($matname,1)))^2
//			wavestats/Q distance
//			bestpoint=V_minloc
//			bestdistance=sqrt(V_min)
//			$matname[i][j]=interp(bestdistance,xwaveprofile,$profilecurve)
//			j+=1
//		While(j<dimsize($matname,1))
//		i+=1
//	While(i<dimsize($matname,0))
End
//*******************************************************************************************************************************

//*******************************************************************************************************************************
Function Func_makebold(matname,curvenamex,curvenamey,profilecurve,xwaveprofile,distance)
	Wave matname
	Wave curvenamex
	Wave curvenamey	
	Wave profilecurve
	Wave xwaveprofile
	Wave distance	
	Pauseupdate;Silent 1
	Variable i,j,bestpoint, bestdistance
	i=0
	Do
		IF(mod(i,50)==0)
			print i
		Endif	
		j=0
		Do
			distance[]=(curvenamex[p]-(dimoffset(matname,0)+i*dimdelta(matname,0)))^2+(curvenamey[p]-(dimoffset(matname,1)+j*dimdelta(matname,1)))^2
			wavestats/Q distance
			bestpoint=V_minloc
			bestdistance=sqrt(V_min)
			matname[i][j]=interp(bestdistance,xwaveprofile,profilecurve)
			j+=1
		While(j<dimsize(matname,1))
		i+=1
	While(i<dimsize(matname,0))
End
//*******************************************************************************************************************************
Make/O/N=0 surfx_x;Make/O/N=0 surfx_y;Make/O/N=0 surfy_x;Make/O/N=0 surfy_y

//*******************************************************************************************************************************
Proc interpcurve(wave4x,wave4y,matname)
	String wave4x
	String wave4y
	String matname
	Prompt wave4x,"Enter the name of the xwave"
	Prompt wave4y, "Enter the name of the ywave"
	Prompt matname, "Enter the name of the background natrix"	
	Pauseupdate;Silent 1
	Variable shiftx,shifty
	Make/O/N=0 surfx_x;Make/O/N=0 surfx_y;Make/O/N=0 surfy_x;Make/O/N=0 surfy_y
	func_give_area1($wave4x,$wave4y,surfx_x,surfx_y,dimdelta($matname,0),dimsize($matname,0))
	shiftx=(surfx_x[0]-$wave4x[0])
	shifty=(surfx_y[0]-$wave4y[0])
	surfx_y[]-=shifty
	surfx_x[]-=shiftx		
End
//*******************************************************************************************************************************

