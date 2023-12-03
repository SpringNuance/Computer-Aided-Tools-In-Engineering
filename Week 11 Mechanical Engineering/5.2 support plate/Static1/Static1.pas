------------------------------------------------------------
Creo Simulate Structure Version P-60-33:spg
Diagnostic Log
Tue Nov 30, 2021   20:25:15
------------------------------------------------------------

Begin Creating Database for Design Study
Tue Nov 30, 2021   20:25:16

Begin Integrated Mode Error Checking
Tue Nov 30, 2021   20:25:16

Begin Generating Elements
Tue Nov 30, 2021   20:25:16

Begin Integrated Mode Error Checking
Tue Nov 30, 2021   20:25:19

Begin Engine Bookkeeping
Tue Nov 30, 2021   20:25:20

Begin Analysis: "Static1"
Tue Nov 30, 2021   20:25:21

Using Sparse Solver

Begin Mass Calculation
Tue Nov 30, 2021   20:25:22

Begin P-Loop Pass 1
Tue Nov 30, 2021   20:25:24

Begin Processing Multi-Point Constraints
Tue Nov 30, 2021   20:25:25

Begin Matrix Profile Minimization
Tue Nov 30, 2021   20:25:25

Begin Element Calculations, Pass 1
Tue Nov 30, 2021   20:25:25

Begin Global Matrix Assembly, Pass 1
Tue Nov 30, 2021   20:25:28

Begin Equation Solve, Pass 1
Tue Nov 30, 2021   20:25:28

Number of equations: 129006
Average bandwidth:   334.796
Maximum bandwidth:   2436
Size of global matrix profile (mb): 345.525
Number of terms in global matrix profile: 43190676    
Minimum recommended solram for direct solver: 24

Size of element file (mb): 103.754
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
Tue Nov 30, 2021   20:25:32

Begin Post-Processing Calculations, Pass 1
Tue Nov 30, 2021   20:25:33

Begin Convergence Check Pass 1
Tue Nov 30, 2021   20:25:35

Begin Strain Energy Calculations
Tue Nov 30, 2021   20:25:36

Begin P-Loop Pass 2
Tue Nov 30, 2021   20:25:37

Begin Processing Multi-Point Constraints
Tue Nov 30, 2021   20:25:37

Begin Matrix Profile Minimization
Tue Nov 30, 2021   20:25:37

Begin Element Calculations, Pass 2
Tue Nov 30, 2021   20:25:37

Begin Global Matrix Assembly, Pass 2
Tue Nov 30, 2021   20:25:39

Begin Equation Solve, Pass 2
Tue Nov 30, 2021   20:25:39

Number of equations: 137784
Average bandwidth:   328.517
Maximum bandwidth:   2565
Size of global matrix profile (mb): 362.115
Number of terms in global matrix profile: 45264390    
Minimum recommended solram for direct solver: 26

Size of element file (mb): 115.748
Maximum element matrix size (kb): 113.568
Average element matrix size (kb): 16.3325

Begin Load Calculations
Tue Nov 30, 2021   20:25:44

Begin Post-Processing Calculations, Pass 2
Tue Nov 30, 2021   20:25:44

Begin Convergence Check Pass 2
Tue Nov 30, 2021   20:25:46

Begin Displacement and Stress Calculation
Tue Nov 30, 2021   20:25:48

Begin Reaction Calculation
Tue Nov 30, 2021   20:25:54

Begin Strain Energy Calculations
Tue Nov 30, 2021   20:25:55

Completed P-Loop
Tue Nov 30, 2021   20:25:58

Completed Analysis: Static1
Tue Nov 30, 2021   20:25:59
