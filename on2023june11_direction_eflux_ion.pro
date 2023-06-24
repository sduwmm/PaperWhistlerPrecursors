pro on2023june11_direction_eflux_ion
  files = 'D:\AAA_results\'$
    & if ~file_test(files) then file_mkdir, files
   
    
  del_data,'*'
  mms_init
  !mms.local_data_dir = 'D:\data\mms\'
  probe = ['1']
  
  
  ;trange=['2023-01-23/03:20','2023-01-23/03:45']
  
  ;trange=['2023-01-23/06:31:13','2023-01-23/06:42:23']
  ;trange=['2023-01-23/06:09:00','2023-01-23/06:12:03']

  ;trange=['2017-12-18/12:55:13','2017-12-18/12:57:43']
  ;trange=['2017-12-18/12:56:40','2017-12-18/12:57:43']

  ;trange=['2018-02-04/10:37:00','2018-02-04/10:38:40']
  ;trange=['2018-02-04/10:38:00','2018-02-04/10:38:40']
  ;trange=['2018-02-21/11:34:23','2018-02-21/11:37:23']
  ;trange=['2018-02-21/11:36:20','2018-02-21/11:37:23']

;  trange=['2019-01-18/21:03:13','2019-01-18/21:04:13']
;  trange=['2019-12-06/05:12:10','2019-12-06/05:15:00']
 ;trange=['2019-12-06/05:13:40','2019-12-06/05:15:00']

;  trange=['2020-03-20/19:46:33','2020-03-20/19:47:40']
;  trange=['2020-03-20/19:47:20','2020-03-20/19:47:45']

  ;trange=['2021-01-12/01:19:00','2021-01-12/01:20:30']
  ;trange=['2021-01-12/01:19:50','2021-01-12/01:20:20']
;  trange=['2021-02-27/12:57:00','2021-02-27/12:58:23']
 ;trange=['2021-02-27/12:57:40','2021-02-27/12:58:00']
 
 ;trange=['2021-02-27/12:56:03','2021-02-27/12:58:23']
;  trange=['2021-03-20/15:57:13','2021-03-20/16:01:00']
;  trange=['2021-03-20/15:59:50','2021-03-20/16:01:00']
;  trange=['2021-03-20/19:28:33','2021-03-20/19:30:00']
;  trange=['2021-12-07/13:23:43','2021-12-07/13:24:33']
;  trange=['2021-12-07/13:24:10','2021-12-07/13:24:35']



;trange=['2018-01-09/08:34:23','2018-01-09/08:35:13']

trange=['2017-12-18/12:56:40','2017-12-18/12:57:00']

  mms_load_fgm, probe = probe, level = 'l2', data_rate = 'brst', $
    trange = trange,/time_clip
  mms_load_fpi, probe = probe, datatype = ['dis-moms'], level = 'l2', $
    data_rate = 'brst', trange = trange;electron moment; number density
  ;mms_load_scm, probe=probe, datatype='scb', level='l2', trange=trange, data_rate='brst'
  mms_load_scm, probe=probe, datatype='scsrvy', level='l2', trange=trange, data_rate='srvy'
  
  ;ylim,'mms1_dis_energyspectr_*',100,11000
  ;ylim,'mms1_dis_energyspectr_*',100,20000

  window,0,xsize=1800,ysize=1000
  time_stamp, /off
  ;tplot_multiaxis,$
  tplot,$
    ['mms1_fgm_b_gse_brst_l2',$
    'mms1_dis_energyspectr_omni_brst',$
    'mms1_scm_acb_gse_scsrvy_srvy_l2',$
    ;'mms1_dis_energyspectr_px_brst',$
    ;'mms1_dis_energyspectr_mx_brst',$
    'mms1_dis_energyspectr_py_brst',$
    'mms1_dis_energyspectr_my_brst',$
    'mms1_dis_energyspectr_pz_brst',$
    'mms1_dis_energyspectr_mz_brst'],$
    ;'mms1_scm_acb_gse_scb_brst_l2'],$
    window=0,VERSION=5,trange=trange
  makepng, files+'ion_dist_'+time_string(trange[0],format=2)+$
    time_string(trange[1],format=2)
    
  stop
end