!*********************************************************************!
! Code to perform classical dynamics on a Morse potential             ! 
!*********************************************************************!

      program oscillator 

      implicit none

      integer :: i,j,k
      integer :: Nsteps

      real*8 :: q0,q,qdot0,qdot,qddot,nu
      real*8 :: E,T,V,Eanal 
      real*8 :: dt,time
      real*8 :: omega,a,De,mass,zpe_scaling
      real*8,parameter :: pi=dacos(-1.d0)

! Read initial conditions and parameters

      open(unit=101,file="input",status='old')
      read(101,*) !Initial conditions (quanta)
      read(101,*) nu
      read(101,*) !Time step
      read(101,*) dt
      read(101,*) !Number of steps
      read(101,*) Nsteps
      read(101,*) !Parameters
      read(101,*) omega,mass,zpe_scaling
      close(101)
! a is negative to have the plateaux on the right side

      De=38293.d0/4400.d0 !H2-like parameter
      !a=-2*pi*omega*dsqrt(mass/(2.d0*De))
      a=-omega*dsqrt(mass/(2.d0*De))
      q0=0.d0
      Eanal=omega*(nu+0.5d0)-((omega*(nu+0.5d0))**2.d0)/(4.d0*De)
      qdot0=zpe_scaling*dsqrt(Eanal/2.d0)
      write(*,*) "E", "p0"
      write(*,*) Eanal, qdot0


! Velocity-Verlet dynamics

      open(unit=666,file="energy_plot.dat",status='unknown')
      open(unit=777,file="phase_space.dat",status='unknown')
      q=q0
      time=0.d0
      qdot = qdot0
      call gradient(omega,a,De,q,qdot,qddot)
      call potential(omega,a,De,q,qdot,V)
      E = (qdot**2)/2.d0 + V
      write(666,*) time, E
      write(777,*) q, qdot
      do i = 1,Nsteps
         time = i*dt
         q = q + qdot*dt + 0.5d0*qddot*dt*dt
         qdot = qdot + 0.5d0*qddot*dt
         call gradient(omega,a,De,q,qdot,qddot)
         qdot = qdot + 0.5d0*qddot*dt
         call potential(omega,a,De,q,qdot,V)
         E = (qdot**2)/2.d0 + V
         write(666,*) time, E
         write(777,*) q, qdot 
      end do
      close(666)
      close(777)

      end program oscillator

!**********************************************************************
      
      subroutine potential(omega,a,De,q,qdot,V)

      real*8 :: omega,a,De
      real*8 :: q,qdot
      real*8 :: q1,qdot1
      real*8 :: V,V1

      q1=q
      qdot1=qdot
      V1=De*(1-exp(a*q1))**2.d0
      V=V1
      continue      

      end subroutine potential

!**********************************************************************
   
      subroutine gradient(omega,a,De,q,qdot,qddot)

      real*8 :: omega,a,De,esp
      real*8 :: q,qdot,qddot
      real*8 :: q1,qdot1,qddot1
      
      q1=q
      qdot1=qdot
      esp=a*q1
      qddot1=-2.d0*a*De*(exp(2*esp)-exp(esp))
      qddot=qddot1
      continue

      end subroutine gradient




      
