pro on2023june13_ion_pa_gyro_spec
  files='D:\AAA_results\'$
    & if ~file_test(files) then file_mkdir, files
  mms_init
  !mms.local_data_dir = 'D:\data\mms\'
  probes = ['1']
  ;
  trange=['2017-12-18/12:56:40','2017-12-18/12:57:00']
  trange_up=['2017-12-18/12:56:48','2017-12-18/12:57:00']
  ;
  trange=['2018-02-04/10:38:00','2018-02-04/10:38:40']
  trange_up=['2018-02-04/10:38:13','2018-02-04/10:38:20']
  
  trange=['2018-02-21/11:36:20','2018-02-21/11:37:21']
  trange_up=['2018-02-21/11:36:47','2018-02-21/11:37:00']

trange=['2019-01-18/21:03:50','2019-01-18/21:04:12']
trange_up=['2019-01-18/21:03:58','2019-01-18/21:04:12']


trange=['2021-01-12/01:19:55','2021-01-12/01:20:30']
trange_up=['2021-01-12/01:20:02','2021-01-12/01:20:10']


trange=['2021-03-20/19:29:30','2021-03-20/19:30:00']
trange_up=['2021-03-20/19:29:38','2021-03-20/19:30:00']

trange=['2021-02-27/12:57:45','2021-02-27/12:58:23']
trange_up=['2021-02-27/12:57:50','2021-02-27/12:58:23']

trange=['2021-03-20/19:29:30','2021-03-20/19:30:00']
trange_up=['2021-03-20/19:29:40','2021-03-20/19:30:00']

;trange=['2021-12-07/13:24:10','2021-12-07/13:24:35']
;trange_up=['2021-12-07/13:24:18','2021-12-07/13:24:35']

  mms_load_fgm, probe = probes, level = 'l2', data_rate = 'brst', $
    trange = trange, tplotnames=['mms1_fgm_b_gse_brst_l2_bvec','mms1_fgm_b_gse_brst_l2']
  mms_load_fpi, probe = probes, datatype = ['dis-moms'], level = 'l2', $
    data_rate = 'brst', trange = trange
  mms_load_mec, probe = probe, $
    datatype = ['epht89d'], trange = trange
  mms_load_scm, probe=probes, datatype='scsrvy', level='l2', $
    trange=trange, data_rate='srvy'

  ;  ;
  ;
  tsmooth2,'mms1_fgm_b_gse_brst_l2_bvec',400,newname='mms1_fgm_b_gse_brst_l2_bvec_sm'
  get_data,'mms1_fgm_b_gse_brst_l2_bvec',data=b_gse_vec
  arr_bgse_vec=b_gse_vec.y
  arr_time=b_gse_vec.x
  index_up = where(arr_time ge time_double(trange_up[0]) and $
    arr_time le time_double(trange_up[1]))
  arr_bgse_vec_up=arr_bgse_vec(index_up,*)
  arr_bx=arr_bgse_vec_up(*,0)
  arr_by=arr_bgse_vec_up(*,1)
  arr_bz=arr_bgse_vec_up(*,2)
  bx_up=mean(arr_bx)
  by_up=mean(arr_by)
  bz_up=mean(arr_bz)
  ;
  size_data=size(arr_bgse_vec,/dimensions)
  arr_bup_vec=MAKE_ARRAY(size_data,/DOUBLE, VALUE = 0)
  arr_bup_vec[*,0]=bx_up
  arr_bup_vec[*,1]=by_up
  arr_bup_vec[*,2]=bz_up

  store_data,'bup',data={x:arr_time,y:arr_bup_vec}
  options,'bup', $
    YSUBTITLE='[nT]',$
    labels=['Bx GSE','By GSE','Bz GSE'],$
    colors=[2, 4, 6],  $
    labflag=1,$
    YTITLE='Bxyz Up'
  options, /def, 'bup', 'data_att.coord_sys', 'gse'
  ;
  ;
;  mms_part_getspec, probe='1', instrument='fpi', $
;    species='i', data_rate='brst', level='l2',energy=[100,700], $
;    outputs=['pa'],trange = trange,$
;    mag_name='bup',$
;    suffix='_re'
;  mms_part_getspec, probe='1', instrument='fpi', $
;    species='i', data_rate='brst', level='l2',energy=[700,5000], $
;    outputs=['pa'],trange = trange,$
;    mag_name='bup',$
;    suffix='_sw'

  mms_part_getspec, probe='1', instrument='fpi', $
    species='i', data_rate='brst', level='l2', $
    outputs=['pa'],trange = trange,$
    mag_name='bup'
    
    mms_part_getspec, probe='1', instrument='fpi', $
    species='i', data_rate='brst', level='l2', $
    outputs=['gyro'],trange = trange,$
    mag_name='bup',$
    /subtract_bulk,$
    vel_name='mms1_dis_bulkv_gse_brst'
  ;
;  options,'mms1_dis_dist_brst_pa_sw', $
;    YSUBTITLE='[deg]',$
;    YTITLE='Solar wind ions'
;    ;
;    options,'mms1_dis_dist_brst_pa_re', $
;    YSUBTITLE='[deg]',$
;    YTITLE='RE from FT shock'
    ;
  ;ylim,['mms1_fgm_b_gse_brst_l2','bup'],[-17,36]
  window,0,xsize=1800,ysize=1000
  !p.charsize = 2.0 & !p.charthick = 1.5 & !p.font = 1
  time_stamp, /off
  tplot, ['mms1_fgm_b_gse_brst_l2',$
    'bup',$
    'mms1_scm_acb_gse_scsrvy_srvy_l2',$
    'mms1_dis_energyspectr_omni_brst',$
;    'mms1_dis_dist_brst_pa_sw',$
;    'mms1_dis_dist_brst_pa_re'],$
    'mms1_dis_dist_brst_pa',$
    'mms1_dis_dist_brst_gyro'],$
    trange=trange,window=0
  makepng, files+'mms1_ions_spec_pa_'+time_string(trange[0],format=2)+$
    time_string(trange[1],format=2)
    
    window,1,xsize=1800,ysize=1000
  time_stamp, /off
  ;tplot_multiaxis,$
  tplot,$
    ['mms1_fgm_b_gse_brst_l2',$
    'mms1_dis_energyspectr_omni_brst',$
    'mms1_scm_acb_gse_scsrvy_srvy_l2',$
    'mms1_dis_energyspectr_px_brst',$
    'mms1_dis_energyspectr_mx_brst',$
    'mms1_dis_energyspectr_py_brst',$
    'mms1_dis_energyspectr_my_brst',$
    'mms1_dis_energyspectr_pz_brst',$
    'mms1_dis_energyspectr_mz_brst'],$
    ;'mms1_scm_acb_gse_scb_brst_l2'],$
    window=1,VERSION=5,trange=trange
  makepng, files+'ion_dist_'+time_string(trange[0],format=2)+$
    time_string(trange[1],format=2)
  stop
end