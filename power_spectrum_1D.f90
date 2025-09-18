!*********************************************************************!
! Code to compute classical VDOS                                      !
!*********************************************************************!

      program powerspectrum1D

      implicit none

      integer :: i,j,k 
      integer :: Nstep,Wstep

      real*8 :: omega_start,omega_stop
      real*8 :: q,qdot,cvv,cxx
      real*8 :: dt,time_i,omega,omega_step
      real*8, dimension(:), allocatable :: pvec, qvec

      complex*16, parameter :: ui = (0.d0,1.d0)
      complex*16 :: fourier, ftcvv, ftcxx
      real*8 :: pwr_spec_t

!.....Read Input......................................................

      open(unit=101,file="FT_input",status='old')
      read(101,*) !Number of steps, step size
      read(101,*) Nstep, dt
      read(101,*) !Omega: Start Stop Step
      read(101,*) omega_start, omega_stop, omega_step
      close(101)

      Wstep = (omega_stop-omega_start)/omega_step
      Wstep = int(Wstep)
      allocate(pvec(Nstep+1),qvec(Nstep+1))

      pvec(:) = 0.d0

!.....Fourier transform...............................................

      open(unit=102,file="phase_space.dat",status='old')
      ! time averaged:
      open(unit=666,file="power_spectrum_p.dat",status='unknown')
      open(unit=777,file="power_spectrum_q.dat",status='unknown')
      ! not time averaged
      !open(unit=888,file="real_FTCvv.dat",status='unknown')
      !open(unit=999,file="real_FTCxx.dat",status='unknown')
      omega=0.d0

      do i = 1,Nstep+1 !passo 0
         read(102,*) q, qdot
         pvec(i) = qdot
         qvec(i) = q
      end do
      close(102)
!.....Momenta..........................................................
      do j = 1,Wstep
         omega = omega_start + dfloat(j-1)*omega_step
         fourier = (0.d0,0.d0) 
         ftcvv = (0.d0,0.d0)
         !Time average
         do i= 1,Nstep+1
            time_i = dt*dfloat(i-1)
            fourier = fourier + pvec(i)*cdexp(ui*omega*time_i)
         end do
         pwr_spec_t = fourier*dconjg(fourier)/(2.d0*time_i)
         write(666,*) omega, pwr_spec_t
         !Not time average
         !do i= 1,Nstep+1-1500 !ciclo su t
         !   time_i = dt*dfloat(i-1)
         !   do k = 1,1500 !ciclo su t1
         !      cvv = cvv + pvec(k)*pvec(k+i-1)/(dfloat(2000)*dt)
         !   end do
         !   ftcvv = ftcvv + cvv*cdexp(ui*omega*time_i)
         !end do
         !write(888,*) omega, realpart(ftcvv)
      end do
      close(666)
      !close(888)
!.....Positions........................................................
      do j = 1,Wstep
         omega = omega_start + dfloat(j-1)*omega_step
         fourier = (0.d0,0.d0) 
         ftcxx = (0.d0,0.d0)
         !Time average
         do i= 1,Nstep+1
            time_i = dt*dfloat(i-1)
            fourier = fourier + qvec(i)*cdexp(ui*omega*time_i)
         end do
         pwr_spec_t = fourier*dconjg(fourier)/(2.d0*time_i)
         write(777,*) omega, pwr_spec_t
         !Not time average
         !do i= 1,Nstep+1-1500 !ciclo su t
         !   time_i = dt*dfloat(i-1)
         !   do k = 1,1500 !ciclo su t1
         !      cxx = cxx + qvec(k)*qvec(k+i-1)/(dfloat(2000)*dt)
         !   end do
         !   ftcxx = ftcxx + cxx*cdexp(ui*omega*time_i)
         !end do
         !write(999,*) omega, realpart(ftcxx)
      end do
      close(777)
      !close(999)

      deallocate(pvec,qvec)

      end program powerspectrum1D 
