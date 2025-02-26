c:**********************************************
c:*   AUTHOR:                                  *
c:*      Evan Westwood                         *
c:*      Applied Research Laboratories         *
c:*      The University of Texas at Austin     *
c:*      P. O. Box 8029                        *
c:*      Austin, TX  78713-8029                *
c:**********************************************
c: *******************************
c: *     REVISION (1996):        *
c: *         E M G  GROUP        *
c: *     S A C L A N T C E N     *
c: *******************************
                                                 
      subroutine opt_read
c
c: Reads option file.
c
      implicit none
      include 'Parms_com'
      include 'i_o_opt_com'
      include 'i_o_2_com'
c
      integer*4 NFFT_FMC
      integer*4 nline,iierr
      integer*4 IOP

      character*64 eline

c: Local variables:

      data eline/'INVALID INPUT IN OPT FILE: '/
c
      nline=0
      iierr=0
      iigeom=1
      ver_no= 1.0
      IOP= 16
      iicw=2
      iikpl= 0
      iirc= 0
      n_env= 0
      iirx= 1
      cphmin= 0.0
      cphmax= 0.0
c      cphmin= 1480.0
c      cphmax= 2000.0
      rmax= 0.0
c added for SAGA test 21/11/99
      rmax=1000.e0
      phfac= 4
      db_cut= 50
      iifb= 0
      iidiag= 0
c        call check_val_r4(cphmin,-1.e0,1.e10,eline,27,nline,
c     .      'cphmin',6,iierr)
c        call check_val_r4(cphmax,-89.99e0,1.e10,eline,27,nline,
c     .      'cphmax',6,iierr)
c        call check_val_r4(rmax,0.e0,1.e10,eline,27,nline,
c     .      'rmax',4,iierr)
c        call check_val_r4(phfac,0.e0,512.e0,eline,27,nline,
c     .      'phfac',5,iierr)
c        call check_val_r4(db_cut,0.e0,120.e0,eline,27,nline,
c     .      'db_cut',6,iierr)
c        call check_val_i(iirx,0,2,eline,27,nline,'iirx',4,iierr)
c        call check_val_i(iifb,0,100,eline,27,nline,'iifb',4,iierr)
c
      iifft= 1
cfmc  iiout   = Output BB Eigenvalues and Functions (same options as iifft above);
      iiout= 0
cfmc   iift    = Freq Traj(ASCII); iimt = Mode Traj(ASCII); 
      iift= 0
cfmc    iimt= ????
      iimt= 0
cfmc  iidc    = Disp Curves (0=no,1=vg,2=vph,3=both); 
      iidc= 0

      call check_val_r4(fsbb,0.e0,1.e10,eline,27,nline,
     .         'fsbb',4,iierr)
      call check_val_r4(Tw,-1.e10,131072e0,eline,27,nline,
     .         'nfft/Tw',7,iierr)
      call check_val_r4(fmin,1.e-3,fmax,eline,27,nline,
     .         'fmin',4,iierr)
      call check_val_r4(fmax,fmin,fsbb/2.e0,eline,27,nline,
     .         'fmax',4,iierr)
c      call check_val_i(iifft,0,2,eline,27,nline,'iifft',5,iierr)
c      call check_val_i(iiout,0,2,eline,27,nline,'iiout',5,iierr)
c      call check_val_i(iift,0,1,eline,27,nline,'iift',4,iierr)
c      call check_val_i(iimt,0,1,eline,27,nline,'iimt',4,iierr)
c      call check_val_i(iidc,0,3,eline,27,nline,'iidc',4,iierr)
c      if(iifft*iiout .ne. 0 .and. iifft .ne. iiout) then
c        print *,'Require iifft=iiout when iifft>0 and iiout>0.'
c        print *,'Assuming zs,zr,r to be read according to iifft.'
c        iiout=iifft
c      endif
c
c
c fbv      if(iigeom .eq. 2) call arr_geom(iierr) This subroutine should not be used.
c
      if(iierr .eq. 1) then
         print *,' '
         print *,'Execution terminating.  Check input option file '//
     .      'for error(s).'
         stop
      endif
      return
      end
ccc
      subroutine check_val_i(val,val_lo,val_hi,eline,le,nline,
     .   vname,lv,iierr)
c
c: Checks integer input val to see if it is in the range of allowable 
c: values, val_lo to val_hi.
c
      implicit none
      integer*4 val,val_lo,val_hi,nline,le,lv,iierr
      character*64 eline,vname
c
      if(val .lt. val_lo .or. val .gt. val_hi) then
         iierr=1
         print *,' '
         print *,eline(1:le),' LINE # ',nline
         print *,'VARIABLE NAME = ',vname(1:lv),'; VALID RANGE = ',
     .      val_lo,' ,',val_hi
         print *,'ENTERED VALUE = ',val
      endif
c
      return
      end
ccc
      subroutine check_val_r4(val,val_lo,val_hi,eline,le,nline,
     .   vname,lv,iierr)
c
c: Checks real*8 input val to see if it is in the range of allowable 
c: values, val_lo to val_hi.
c
      implicit none
      real*4 val,val_lo,val_hi
      integer*4 nline,le,lv,iierr
      character*64 eline,vname
c
      if(val .lt. val_lo .or. val .gt. val_hi) then
         iierr=1
         print *,' '
         print *,eline(1:le),' LINE # ',nline
         print *,'VARIABLE NAME = ',vname(1:lv),'; VALID RANGE = ',
     .      val_lo,' ,',val_hi
         print *,'ENTERED VALUE = ',val
      endif
c
      return
      end
ccc
      subroutine check_val_r8(val,val_lo,val_hi,eline,le,nline,
     .   vname,lv,iierr)
c
c: Checks real*8 input val to see if it is in the range of allowable 
c: values, val_lo to val_hi.
c
      implicit none
      real*8 val,val_lo,val_hi
      integer*4 nline,le,lv,iierr
c      character*64 eline,vname
      character vname(lv)
      character eline(le)
c
      if(val .lt. val_lo .or. val .gt. val_hi) then
         iierr=1
         print *,' '
         print *,eline(1:le),' LINE # ',nline
         print *,'VARIABLE NAME = ',vname(1:lv),'; VALID RANGE = ',
     .      val_lo,' ,',val_hi
         print *,'ENTERED VALUE = ',val
      endif
c
      return
      end
ccc
