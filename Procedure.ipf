#pragma rtGlobals=1		// Use modern global access method.

Proc FermiFit_multi(dataname,tem)
	String dataname
	Variable tem
	Variable i
	Make/N=2/O tmp_ef_res
	Make/O/N=(DimSize($dataname,0)) $dataname+"_res"
	SetScale/P x,DimOffset($dataname,0),DimDelta($dataname,0), $dataname+"_res"
	Make/O/N=(DimSize($dataname,0)) $dataname+"_ef"
	SetScale/P x,DimOffset($dataname,0),DimDelta($dataname,0), $dataname+"_ef"
	
	Make/O/N=(DimSize($dataname,1)) edctmp
	SetScale/P x,DimOffset($dataname,1),DimDelta($dataname,1), edctmp
	
	i=0
	Do 
		edctmp[]=$dataname[i][p]	
		GoldFitting(edctmp,tem)//from GoldFit_Peng
		$dataname+"_res"[i]=tmp_ef_res[0]
		$dataname+"_ef"[i]=tmp_ef_res[1]
		i+=1
	While(i<DimSize($dataname,0))
	display $dataname+"_res"
	display $dataname+"_ef"
End 



Proc Graph1Style() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z width=255.118,height=198.425
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror=2
	ModifyGraph/Z fSize=14
	ModifyGraph/Z btLen=4
EndMacro

Proc Graph3Style() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z width=368.504,height=198.425
	ModifyGraph/Z mode[0]=3
	ModifyGraph/Z marker[0]=8
	ModifyGraph/Z lSize[1]=1.5
	ModifyGraph/Z rgb[0]=(13107,13107,13107)
	ModifyGraph/Z msize[0]=2
	ModifyGraph/Z tick(left)=3,tick(bottom)=2
	ModifyGraph/Z mirror=2
	ModifyGraph/Z noLabel(left)=1
	ModifyGraph/Z fSize=14
	ModifyGraph/Z btLen=4
EndMacro
