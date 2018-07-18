#pragma rtGlobals=1		// Use modern global access method.



function GoldFitting(dos,Tem)//dos is the wave to fit, Tem is the experimental Temperature.
	
	wave dos
	variable Tem
	
	string fit_info,width_info
	variable startx,starty,endx,endy
	
	if(cmpstr(csrinfo(a),"")&&cmpstr(csrinfo(b),"")) //if both cursors are on the graph, then use the cursor range.
		startx=hcsr(a)
		starty=vcsr(a)
		endx=hcsr(b)
		endy=vcsr(b)
	else														//if not both cursors on, use the full range.
		startx=dimoffset(dos,0)
		starty=dos(startx)
		endx=dimoffset(dos,0)+(dimsize(dos,0)-1)*dimdelta(dos,0)
		endy=dos(endx)
	endif

		
	Make/N=6/D/O Wfit			//the fit coeffecient wave.
	Wfit[0]=(startx+endx)/2		//fermi level.
	Wfit[1]=Tem					//fit temperature.
//	Wfit[2]=starty					//the Y value of the below Ef line when x=0
//	Wfit[3]=-abs((endy-starty)/(endx-startx))	//the slope of the below Ef line.
//	Wfit[4]=endy					//the Y value of the above Ef line when x=0
//	Wfit[5]=Wfit[3]				//the slope of the above Ef line.
	
	//just find Wfit
	wave W_coef  
	CurveFit/Q line, dos(16.841,16.854)/D// the result return in a wave by default w_coef
	Wfit[4]=W_coef[0]
	Wfit[5]=W_coef[1]
		
	CurveFit/Q line, dos(16.815,16.834)/D
	Wfit[2]=W_coef[0]-Wfit[4]
	Wfit[3]=W_coef[1]-Wfit[5]
	
//	duplicate/o dos t_dos
//	differentiate t_dos
//	wavestats/q t_dos
//	wfit[0]=v_minloc
//	killwaves t_dos
	
	FuncFit/Q line_fermi Wfit dos(startx, endx) /D
	FuncFit/Q line_fermi Wfit dos(startx, endx) /D			//fitting two times has its advantage.

	
	fit_info="E\BF\M="+num2str(floor(wfit[0]))+"."+stringfromlist(1,num2str(wfit[0]-floor(wfit[0])),".")+" eV\rT\BExp\M="+num2str(Tem)+" K\rT\BFit\M="+num2str(Wfit[1])+" K"
	//TextBox/C/N=E_tot="+num2str(.318*sqrt(Wfit[1]*Wfit[1]))+" meV" +"\r"+"\F'Symbol'D\F'Arial'E\Bins\M="+num2str(.318*sqrt(Wfit[1]*Wfit[1]-Tem*Tem))+" meV"Ê
   TextBox/C/N=text0/F=0/A=MC "Resolution (meV) = "+num2str(.318*sqrt(Wfit[1]*Wfit[1]-Tem*Tem))+"\r"+"EF (eV) = "+num2str(floor(wfit[0]))+"."+stringfromlist(1,num2str(wfit[0]-floor(wfit[0])),".")+" eV\r"
	print fit_info+"\r\r"+ "\F'Symbol'D\F'Arial'E\Btot\M="+num2str(.318*sqrt(Wfit[1]*Wfit[1]))+" meV" +"\r"+"\F'Symbol'D\F'Arial'E\Bins\M="+num2str(.318*sqrt(Wfit[1]*Wfit[1]-Tem*Tem))+" meV"
//	print "The resolution at temperature T is defined as: the FWHM of the Gauss fitting of the derivative of fermi function."
	wave tmp_ef_res
	tmp_ef_res[0]=.318*sqrt(Wfit[1]*Wfit[1]-Tem*Tem)
	tmp_ef_res[1]=Wfit[0]

end
	
	
	
function GoldFittingp(dos,Tem) //the same with fitgold(dos,Tem), only different is user need to guess all the initial values of the six parameters.
	
	wave dos
	variable Tem
	variable wfit2,wfit3,wfit4,wfit5,wfit0,wfit1
	prompt Wfit0, "fermi level"
	prompt Wfit1, "fitting temperature"
	prompt Wfit2, "below Ef line's Y value when x=0"
	prompt Wfit3, "the slope of the below Ef line"
	prompt Wfit4, "above Ef line's Y value when x=0"
	prompt Wfit5, "the slope of the above Ef line"
	
	string fit_info,width_info
	variable startx,starty,endx,endy
		
	Make/N=6/D/O Wfit
		
	if(cmpstr(csrinfo(a),"")&&cmpstr(csrinfo(b),""))
		startx=hcsr(a)
		starty=vcsr(a)
		endx=hcsr(b)
		endy=vcsr(b)
	else
		startx=dimoffset(dos,0)
		starty=dos(startx)
		endx=dimoffset(dos,0)+(dimsize(dos,0)-1)*dimdelta(dos,0)
		endy=dos(endx)
	endif
	
		
	Make/N=6/D/O Wfit			//the fit coeffecient wave.
	
	
	Wfit0=(startx+endx)/2		//fermi level.
	Wfit1=Tem					//fit temperature.
	Wfit2=starty					//the Y value of the below Ef line when x=0
	Wfit3=-abs((endy-starty)/(endx-startx))	//the slope of the below Ef line.
	Wfit4=endy					//the Y value of the above Ef line when x=0
	Wfit5=Wfit3				//the slope of the above Ef line.
	
	duplicate/o dos t_dos
	differentiate t_dos
	wavestats/q t_dos
	wfit[0]=v_minloc
	killwaves t_dos

	doprompt "fitting parameters",wfit0,wfit1,wfit2,wfit3,wfit4,wfit5

	
	Wfit={wfit0,wfit1,wfit2,wfit3,wfit4,wfit5}
	
		
	FuncFit/Q line_fermi Wfit dos(startx, endx) /D
	FuncFit/Q line_fermi Wfit dos(startx, endx) /D

	
	fit_info="E\BF\M="+num2str(floor(wfit[0]))+"."+stringfromlist(1,num2str(wfit[0]-floor(wfit[0])),".")+" eV\rT\BExp\M="+num2str(Tem)+" K\rT\BFit\M="+num2str(Wfit[1])+" K"
	//TextBox/C/N=fit_info Êfit_info+"\r\r"+ "\F'Symbol'D\F'Arial'E\Btot\M="+num2str(.318*sqrt(Wfit[1]*Wfit[1]))+" meV" +"\r"+"\F'Symbol'D\F'Arial'E\Bins\M="+num2str(.318*sqrt(Wfit[1]*Wfit[1]-Tem*Tem))+" meV"Ê

	print "The resolution at temperature T is defined as: the FWHM of the Gauss fitting of the derivative of fermi function."
	
end

function line_fermi(Wfit,x)//function used to fit. Both below and above Ef are used lines, not constant.

	wave Wfit
	variable x
	
	return (Wfit[2]+Wfit[3]*x)/(exp((x-Wfit[0])/(1.38e-23*Wfit[1]/1.6e-19))+1)+Wfit[4]+Wfit[5]*x
	
end