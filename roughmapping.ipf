#pragma rtGlobals=1		/// Use modern global access method.
roughmapping(data_num_start,Data_num_end,Phi_angle_start,Angle_delta)


function RoughMapping(datafrom,datato,anglefrom,angledelta)

	Variable datafrom,datato,anglefrom,angledelta
	string cutname
	cutname="data"+num2str(datafrom)
	make/n=(datato-datafrom+1,dimsize($cutname,1),dimsize($cutname,0))/o mat3d
	setscale/p x,anglefrom,angledelta,mat3d
	setscale/p z,dimoffset($cutname,0),dimdelta($cutname,0),mat3d
	setscale/p y,dimoffset($cutname,1),dimdelta($cutname,1),mat3d
	
	variable i
	for(i=datafrom;i<=datato;i+=1)
		cutname="data"+num2str(i)
		duplicate/o $cutname t_temp
		mat3d[i-datafrom][][]=t_temp[r][q]
	endfor
	variable/g mappingdataend=datato
	
	killwaves t_temp
	
	if(Wintype("mat3d_fs_ploter")==0)
		Execute "initmat3d()"	
		Execute "mat3d_fs_ploter()"	
		Execute "initmat3d()"	
		Else
			Dowindow/F mat3d_fs_ploter
			Execute "mat3d_eplot()"
	Endif	
end