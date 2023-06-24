pro on20221208_shock_parameters
  del_data, '*'
  mu0=1.256637*1.d-6
  ev2J = 1.602176462*1.d-19
  kk = 1.3806503*1.d-23
  mp = 1.6726 * 1.d-27;;;proton mass in kg
  me = 9.1094 * 1.d-31;;;electron mass in kg
  cc = 2.9979*1.d8;;;ligth speed
  mms_init
  !mms.local_data_dir = 'D:\data\mms\'
  pi=3.1415926535
  probes='1'
  level='l2'
  data_rate_b='brst'
  data_rate_p='brst
  files='D:\FT_whistler_shock\'$
    & if ~file_test(files) then file_mkdir, files
  ;;;------------------------
trange=['2017-12-01/14:13:10','2017-12-01/14:13:30']
  vtiming=126.9
  shock_normal=[-0.98, 0.17,  0.02]





trange=['2018-01-09/08:34:50','2018-01-09/08:35:00']
  vtiming=262.0
  shock_normal=[-0.95,0.28,  0.06]




  ;;;------------------------------------------------------------------------
  v_shock_sc=vtiming*shock_normal
  ;;;load data----------------------------------------------------
  mms_load_fgm, probe = probe, level = level, data_rate = data_rate_b, $
    trange = trange, versions = version_numbers
  mms_load_fpi, probe = probe, datatype = ['dis-moms'], level = level, $
    data_rate = 'brst', trange = trange
  mms_load_fpi, probe = probe, datatype = ['des-moms'], level = level, $
    data_rate = data_rate_p, trange = trange
  ;;;-----------------------
  tinterpol, 'mms1_fgm_b_gse_brst_l2_btot','mms1_dis_numberdensity_brst',newname='btot_i'
  tinterpol, 'mms1_des_numberdensity_brst','mms1_dis_numberdensity_brst',newname='ne_i'
  tinterpol,'mms1_des_prestensor_gse_brst','mms1_dis_numberdensity_brst',newname='e_pth_i'
  tinterpol, 'mms1_des_temppara_brst','mms1_dis_numberdensity_brst',newname='e_temppara_i'
  tinterpol, 'mms1_des_tempperp_brst','mms1_dis_numberdensity_brst',newname='e_tempperp_i'
  ;;;;---------------------------------
  ;;;;;;;;;theta bn--------------------------------------------------------------------------
  split_vec,'mms1_fgm_b_gse_brst_l2_bvec'
  get_data,'mms1_fgm_b_gse_brst_l2_bvec_x',data=bx_data
  get_data,'mms1_fgm_b_gse_brst_l2_bvec_y',data=by_data
  get_data,'mms1_fgm_b_gse_brst_l2_bvec_z',data=bz_data
  bx=bx_data.y
  by=by_data.y
  bz=bz_data.y
  time=bx_data.x
  length_data=size(bx,/n_elements)
  theta_bn_arr=[]
  for i=0,length_data-1,1 do begin
    bvec=[bx[i],by[i],bz[i]]
    theta_bn = (shock_normal[0]*bvec[0] + shock_normal[1]*bvec[1] + shock_normal[2]*bvec[2])/$
      (norm(shock_normal)*norm(bvec))
    ;theta_bn_mms = DOT_PRODUCT(shock_normal, bvec_mms )
    theta_bn_i = acos(theta_bn) * 180/!pi
    if theta_bn_i gt 90.0 then theta_bn_i = 180 - theta_bn_i
    theta_bn_arr=[theta_bn_arr,theta_bn_i]
    ;print,i
  endfor
  store_data,'theta_bn',data={x:time,y:theta_bn_arr}
  ylim,'theta_bn',[0,90]
  options,'theta_bn',thick=2,ytitle='Theta_Bn';ysubtitle='!4r!x!lBn'
  ;;;---------------------------
  get_data,'mms1_dis_temppara_brst',data=i_temppara_data
  get_data,'mms1_dis_tempperp_brst',data=i_tempperp_data
  i_temp_eV=1./3.*(i_temppara_data.y+2.*i_tempperp_data.y)
  i_temp_k=i_temp_eV*ev2J/kk
  vs=0.12*sqrt(i_temp_k+1.28*1.d5);;;in km/s
  split_vec,'mms1_dis_bulkv_gse_brst'
  get_data,'mms1_dis_bulkv_gse_brst_x',data=vx_data
  get_data,'mms1_dis_bulkv_gse_brst_y',data=vy_data
  get_data,'mms1_dis_bulkv_gse_brst_z',data=vz_data
  vx = vx_data.y;;;ion bulky velocity in km/s
  vy = vy_data.y
  vz = vz_data.y
  vn=[]
  for i=0, size(vx,/n_elements)-1,1 do begin
    v_up_sc=[vx[i],vy[i],vz[i]]
    v_up_srf=v_up_sc-v_shock_sc
    vni=v_up_srf[0]*shock_normal[0] + v_up_srf[1]*shock_normal[1] +v_up_srf[2]*shock_normal[2]
    vn=[vn,vni]
  endfor
  get_data,'btot_i',data=btot_data
  btot=btot_data.y
  get_data,'ne_i',data=den_data
  den=den_data.y
  ;;;--
  index_btot = where(btot_data.x ge time_double(trange[0]) and $
    btot_data.x le time_double(trange[1]))
  index_dis = where(vx_data.x ge time_double(trange[0]) and $
    vx_data.x le time_double(trange[1]))
  ;;;---
  btot_tr=btot[index_btot]
  vn_tr=vn[index_dis]
  den_tr=den[index_dis]
  va=2.181*1.d16*(den_tr*1.d6)^(-0.5)*btot_tr*1.d-9*1.d-3
  Ma=vn_tr/va
  index_nan = where(Ma le 1)
  Ma[index_nan]='nan'
  store_data,'Ma',data={x:den_data.x[index_dis],y:Ma}
  store_data,'Va',data={x:den_data.x[index_dis],y:va}
  ;;;--------
  btotal=btot_data.y
  pbnPa=((btotal*1.d-9)^2/(2*mu0))*1.d9;;;;magnetic pressure in nPa
  ;  get_data,'e_pth_i',data=e_pth_data
  ;  pthnPa=e_pth_data.y[*,0]
  ;  beta_electron=pthnPa/pbnPa
  ;  store_data,'beta_electron',data={x:btot_data.x,y:beta_electron}
  get_data,'e_temppara_i',data=e_temppara_data
  get_data,'e_tempperp_i',data=e_tempperp_data
  get_data,'ne_i',data=num_e
  e_temp_eV=1./3.*(e_temppara_data.y+2.*e_tempperp_data.y)
  pthnPa_2=num_e.y*1.d6*e_temp_eV*ev2J*1.d9
  beta_electron=pthnPa_2/pbnPa
  store_data,'beta_electron',data={x:btot_data.x,y:beta_electron}
  ;;;;;;;----------------------------------------------------------------------------------------
  store_data,'density',data=['mms1_dis_numberdensity_brst',$
    'mms1_des_numberdensity_brst']
  options,'density',colors=['c','m'],labflag=-1
  store_data,'temp_ion',data=['mms1_dis_temppara_brst',$
    'mms1_dis_tempperp_brst']
  options,'temp_ion',colors=['b','c'],ytitle=['Temp [eV]'],ylog=0,labflag=-1
  store_data,'temp_electron',data=['mms1_des_temppara_brst',$
    'mms1_des_tempperp_brst']
  options,'temp_electron',colors=['m','k'],ytitle=['Temp [eV]'],ylog=0,labflag=-1

  ;ylim, 'mms1_des_numberdensity_brst',[7,50]
  options,'mms1_fgm_b_gse_brst_l2',colors=['bcmk'],ytitle=['B'],labels=['Bx GSE', 'By GSE', 'Bz GSE','B tot'],labflag=-1
  options,'mms1_fgm_b_gse_brst_l2_bvec',colors=['bcm'],ytitle=['B'],labels=['Bx GSE', 'By GSE', 'Bz GSE'],labflag=-1
  options,'mms1_fgm_b_gse_brst_l2_btot',ylog=0,colors='k',ytitle=['B'];,thick=2
  options,'mms1_des_numberdensity_brst',ylog=0,colors='m',ytitle=['Density'],labflag=1;,thick=2
  options,'mms1_fgm_b_gse_brst_l2',colors='bcmk',$
    ytitle=['B'],labels=['Bx GSE', 'By GSE', 'Bz GSE', '|B|'],labflag=-1
  options, 'mms1_scm_acb_gse_scb_brst_l2',colors='bcm',$
    ytitle=['B scm']
  options,  'mms1_edp_dce_gse_brst_l2',colors='bcm',labflag=-1,$
    ytitle=['E edp']
  options,'mms1_dis_bulkv_gse_brst',colors='bcm',labflag=-1,$
    ytitle=['V ions']
  options,'mms1_edp_dce_par_epar_brst_l2',ytitle=['E edp']
  ylim,'mms1_scm_acb_gse_scb_brst_l2',[-5,5]
  ylim,['mms1_edp_dce_gse_brst_l2',$
    'mms1_edp_dce_par_epar_brst_l2'],[-8,8]
  ;;;-------------------------------------------------------------------------------
  window,1,xsize=800,ysize=900
  tplot,['mms1_fgm_b_gse_brst_l2',$
    'density',$
    'mms1_dis_bulkv_gse_brst',$
    'theta_bn',$
    'Ma',$
    'mms1_dis_energyspectr_omni_brst',$
    'mms1_des_energyspectr_omni_brst'], $
    window=1,$
    trange = trange
  timebar,45,color = 0, linestyle=2,varname=['theta_bn'],databar=1
  timebar,3,color = 0, linestyle=2,varname=['Ma'],databar=1
  ;;;-----------------------------
  makepng,files+'mms1_FT_shock_'+time_string(trange[0],format=2)
  stop
  ;;;on 20221019
  TRANGE_UP=['2017-12-01/14:13:15','2017-12-01/14:13:20']
  ;TRANGE_UP=['2017-12-01/14:41:03','2017-12-01/14:41:08']
  ;TRANGE_UP=['2017-12-17/17:53:22','2017-12-17/17:53:27']
  ;trange_up=['2017-12-18/12:56:52','2017-12-18/12:56:57']
  ;trange_up=['2017-12-26/04:58:27','2017-12-26/04:58:37']
  ;trange_up=['2017-12-29/19:11:36','2017-12-29/19:11:41']
  trange_up=['2018-01-09/08:34:54','2018-01-09/08:34:59']
  ;trange_up=['2018-01-12/02:59:57','2018-01-12/03:00:07']
  ;trange_up=['2018-01-31/23:17:21','2018-01-31/23:17:26']
  ;trange_up=['2018-02-04/10:38:13','2018-02-04/10:38:18']
  ;trange_up=['2018-02-17/19:46:33','2018-02-17/19:46:38']
  ;trange_up=['2018-02-20/13:45:53','2018-02-20/13:46:03']
  ;trange_up=['2018-02-21/11:36:45','2018-02-21/11:36:50']
  ;trange_UP=['2018-03-30/08:42:32','2018-03-30/08:42:42']
  ;trange_up=['2018-10-25/02:10:30','2018-10-25/02:10:35']
  ;trange_up=['2018-12-10/04:20:03','2018-12-10/04:20:08']
  ;trange_up=['2018-12-10/04:41:49','2018-12-10/04:41:59']
  ;trange_up=['2018-12-10/05:49:55','2018-12-10/05:50:00']
  ;trange_up=['2018-12-10/06:28:56','2018-12-10/06:29:01']
  ;trange_up=['2018-12-14/03:32:36','2018-12-14/03:32:42']
  ;trange_up=['2019-01-05/17:40:30','2019-01-05/17:40:40']
  ;trange_up=['2019-01-18/21:03:55','2019-01-18/21:04:00']
  ;trange_up=['2019-12-06/05:13:55','2019-12-06/05:14:05']
  ;trange_up=['2020-02-21/19:24:50','2020-02-21/19:25:00']
  ;trange_up=['2020-03-03/06:12:58','2020-03-03/06:13:08']
  ;trange_up=['2020-03-04/03:42:22','2020-03-04/03:42:27']
  ;trange_up=['2020-03-07/13:28:00','2020-03-07/13:28:10']
  ;trange_up=['2020-03-21/15:43:39','2020-03-21/15:43:44']
  ;trange_up=['2020-03-21/17:41:20','2020-03-21/17:41:30']
  ;trange_up=['2019-01-30/04:39:28','2019-01-30/04:39:33']
  ;trange_up=['2020-03-20/19:47:30','2020-03-20/19:47:35']
  ;trange_up=['2021-01-12/02:51:57','2021-01-12/02:52:02']
  ;trange_up=['2021-03-20/16:00:02','2021-03-20/16:00:07']
  ;;;;---------------------------------------------------------------------------------
  get_data,'mms1_des_numberdensity_brst',data=ne_data
  get_data,'mms1_des_numberdensity_err_brst',data=ne_err_data
  get_data,'mms1_des_temppara_brst',data=temppara_e_data
  get_data,'mms1_des_tempperp_brst',data=tempperp_e_data
  index_ne_up=where(ne_data.x gt time_double(trange_up[0]) and $
    ne_data.x lt time_double(trange_up[1]))
  den_e=ne_data.y[index_ne_up]
  den_err=ne_err_data.y[index_ne_up]
  temp_ee=1./3.*(temppara_e_data.y+2.*tempperp_e_data.y)
  temp_e=temp_ee[index_ne_up]
  get_data,'mms1_fgm_b_gse_brst_l2',data=b_data
  ;;;;--------------------
  get_data,'beta_electron',data=beta_e_data
  index_beta_e_up=where(beta_e_data.x gt time_double(trange_up[0]) and $
    beta_e_data.x lt time_double(trange_up[1]))
  beta_electron=beta_e_data.y[index_beta_e_up]
  ;;;--------
  index_up_b=where(b_data.x gt time_double(trange_up[0]) and $
    b_data.x lt time_double(trange_up[1]))
  bx=b_data.y[*,0]
  by=b_data.y[*,1]
  bz=b_data.y[*,2]
  bt=b_data.y[*,3]
  bx_up=bx[index_up_b]
  by_up=by[index_up_b]
  bz_up=bz[index_up_b]
  bt_up=bt[index_up_b]
  bvec_up_ave=[mean(bx_up),mean(by_up),mean(bz_up)]
  btot_up_ave=mean(bt_up)
  ;;;-------------
  get_data,'mms1_dis_bulkv_gse_brst',data=v_data
  index_up_v=where(v_data.x gt time_double(trange_up[0]) and $
    v_data.x lt time_double(trange_up[1]))
  vx=v_data.y[*,0]
  vy=v_data.y[*,1]
  vz=v_data.y[*,2]
  vx_up=vx[index_up_v]
  vy_up=vy[index_up_v]
  vz_up=vz[index_up_v]
  vvec_up_ave=[mean(vx_up),mean(vy_up),mean(vz_up)]
  ;;;------------
  get_data,'theta_bn',data=theta_bn_data
  index_up_bn=where(theta_bn_data.x gt time_double(trange_up[0]) and $
    theta_bn_data.x lt time_double(trange_up[1]))
  theta_bn=theta_bn_data.y[index_up_bn]
  get_data,'Ma',data=ma_data
  get_data,'Va',data=va_data
  index_up_ma=where(ma_data.x gt time_double(trange_up[0]) and $
    ma_data.x lt time_double(trange_up[1]))
  ma=ma_data.y[index_up_ma]
  va=va_data.y[index_up_ma]
  ;;;;--------------
  get_data,'mms1_fgm_b_gse_brst_l2_btot',data=btot
  index_bt=where(btot.x gt time_double(trange[0]) and $
    btot.x lt time_double(trange[1]))
  b_shock=max(btot.y[index_bt])
  print,'Density upstream the FB shock---------'
  print,mean(den_e)
  print,'Density err upstream the FB shock-----'
  print,mean(den_err)
  print,'Electron temperature upstream the FB shock--'
  print,mean(temp_e)
  ;  print,'Electron temperature err upstream the FB shock-----'
  ;  print,stddev(temp_e)
  print,'Electron beta upstream the FB shock---'
  print,mean(beta_electron)
  ;  print,'Electron beta err upstream the FB shock---'
  ;  print,stddev(beta_electron)
  print,'B field upstream the FT shock---------'
  print,bvec_up_ave
  print,btot_up_ave
  ;print,'Velocity upstream the FT shock--------'
  ;print,vvec_up_ave
  print,'Upsteam theta_bn of the FT shock------'
  print,mean(theta_bn)
  print,'Upstream theta_bn err of the FT shock----'
  print,stddev(theta_bn)
  print,'Upstream Alfven speed-----------------'
  print,mean(va)
  ;  print,'Upstream Alfven speed err-------------'
  ;  print,stddev(va)
  print,'Upstream Alfven Mach number of the FT shock--'
  print,mean(ma,/nan)
  print,'Upstream Alfven Mach number err of the FT shock----'
  print,stddev(ma,/nan)
  print,'Maximum of the shock-------------------'
  print,b_shock
  ;;;;----------------
  ;stop
  index_arr=[index_ne_up,index_up_b,index_up_v,index_up_bn, index_up_ma]
  print,index_arr
  stop
end