------------------------------------------------------------
Creo Simulate Structure Version P-60-33:spg
Diagnostic Log
Sun Dec 12, 2021   04:43:42
------------------------------------------------------------

Begin Creating Database for Design Study
Sun Dec 12, 2021   04:43:42

Begin Integrated Mode Error Checking
Sun Dec 12, 2021   04:43:43

Begin Generating Elements
Sun Dec 12, 2021   04:43:43

Begin Integrated Mode Error Checking
Sun Dec 12, 2021   04:44:04

Begin Engine Bookkeeping
Sun Dec 12, 2021   04:44:05

Begin Analysis: "Analysis2"
Sun Dec 12, 2021   04:44:06

Using Sparse Solver

Begin Mass Calculation
Sun Dec 12, 2021   04:44:07

Begin P-Loop Pass 1
Sun Dec 12, 2021   04:44:09

Begin Processing Multi-Point Constraints
Sun Dec 12, 2021   04:44:12

Begin Matrix Profile Minimization
Sun Dec 12, 2021   04:44:47

Begin Element Calculations, Pass 1
Sun Dec 12, 2021   04:44:48

Begin Global Matrix Assembly, Pass 1
Sun Dec 12, 2021   04:44:51

Begin Equation Solve, Pass 1
Sun Dec 12, 2021   04:44:51

Number of equations: 209959
Average bandwidth:   517.594
Maximum bandwidth:   3527
Size of global matrix profile (mb): 869.389
Number of terms in global matrix profile: 108673612   
Minimum recommended solram for direct solver: 50

Size of element file (mb): 195.312
Maximum element matrix size (kb): 14.64
Average element matrix size (kb): 14.64

NOTES:
Solver RAM allocation can be done with a single parameter,
called solram.  If the Creo Simulate Structure/Thermal
engine is the only memory-intensive application running on
your computer, performance will usually be best if you set
solram equal to half of your machine RAM.  For example,
solram 512 is a good choice for a machine with 1024 MB of RAM.

If you are running other memory-intensive applications on
your computer, decrease the solram allocation accordingly.
For example, set solram to 0.25 times machine RAM if you are
running two large applications at once.  However, you often
can run two large jobs faster one after another than if you
try to run both jobs at once.

The purpose of solram is to reduce the amount of disk I/O.
If you set solram too high, performance will usually suffer,
even on machines with very large RAM, because there will not
be enough machine RAM for other important data.  For
example, Creo Simulate allocates many large, non-solver
memory areas that will cause excessive swapping unless you
leave enough spare machine RAM.  You must also leave enough
RAM for the operating system to do disk caching.  Disk
caching improves filesystem performance by holding file data
in RAM for faster access.  Setting solram to half machine
RAM is usually the best compromise between reducing the
amount of disk I/O, and leaving enough machine RAM for disk
caching and for other data.

If you set solram too low, performance will suffer because
Creo Simulate must transfer data between machine RAM and
disk files many more times than with a larger setting.
For example, performance may degrade significantly if you
set solram to 0.1 times machine RAM or less.  A preferable
minimum is 0.25 times machine RAM.

The available swap space on your machine must be greater
than the maximum memory usage of your job.  The available
disk space on your machine must be greater than the maximum
disk usage of your job.  You can monitor the resource usage
of your job in the log (stt) file.  Your job may fail if
your machine does not have enough available disk space or
swap space, or if the maximum memory usage of your job is
greater than the memory limits set for your operating
system.

Begin Load Calculations
Sun Dec 12, 2021   04:45:01

Begin Post-Processing Calculations, Pass 1
Sun Dec 12, 2021   04:45:01

Begin Convergence Check Pass 1
Sun Dec 12, 2021   04:45:05

Begin Strain Energy Calculations
Sun Dec 12, 2021   04:45:07

Begin P-Loop Pass 2
Sun Dec 12, 2021   04:45:08

Begin Processing Multi-Point Constraints
Sun Dec 12, 2021   04:45:13

Begin Matrix Profile Minimization
Sun Dec 12, 2021   04:47:28

Begin Element Calculations, Pass 2
Sun Dec 12, 2021   04:47:29

Begin Global Matrix Assembly, Pass 2
Sun Dec 12, 2021   04:47:44

Begin Equation Solve, Pass 2
Sun Dec 12, 2021   04:47:44

Number of equations: 223881
Average bandwidth:   541.658
Maximum bandwidth:   3471
Size of global matrix profile (mb): 970.135
Number of terms in global matrix profile: 121266898   
Minimum recommended solram for direct solver: 48

Size of element file (mb): 222.703
Maximum element matrix size (kb): 255.024
Average element matrix size (kb): 16.6932

Begin Load Calculations
Sun Dec 12, 2021   04:48:08

Begin Post-Processing Calculations, Pass 2
Sun Dec 12, 2021   04:48:08

Begin Convergence Check Pass 2
Sun Dec 12, 2021   04:48:12

Begin Displacement and Stress Calculation
Sun Dec 12, 2021   04:48:14

Begin Reaction Calculation
Sun Dec 12, 2021   04:48:22

Begin Strain Energy Calculations
Sun Dec 12, 2021   04:48:23

Completed P-Loop
Sun Dec 12, 2021   04:48:26

Completed Analysis: Analysis2
Sun Dec 12, 2021   04:48:27
