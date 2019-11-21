# Azure CycleCloud template for DNAZoo Australia

This Azure CycleCloud template was created for [DNAZoo Australia](https://www.dnazoo.org/post/dna-zoo-australia-going-live), based at [UWA](https://www.uwa.edu.au/). 

Nodes come preinstalled with Singularity and a Singularity image containing [w2rap-contigger](https://github.com/bioinfologics/w2rap-contigger) and [Juicer](https://github.com/aidenlab/juicer). Refer to the [DNAZoo methods page](https://www.dnazoo.org/methods) for how to use these programs.

## w2rap-contigger

w2rap-contigger is very memory hungry and best not run on an HPC cluster, but a single large memory VM.
On Azure its best run on a M64m instance (64 vcpus, 1,792 GiB memory) and 30 threads. Running it on HiSeq X Ten data of
a [Notamacropus eugenii sample](https://www.ebi.ac.uk/ena/data/view/SRR8616947) uses 1,558 GiB of memory and takes 30 hours to complete.

Commandline used:

    export OMP_PROC_BIND=spread
    export MALLOC_PER_THREAD=1
    /usr/bin/time -v w2rap-contigger -o out -p SRR8616947 -r SRR8616947/SRR8616947_1.fastq.gz,SRR8616947/SRR8616947_2.fastq.gz -K 260 -t 30 >& w2rap-contigger.log



## Caveats

This CyceCloud cluster template uses managed i.e. persistent disks, which are still active after termination of a cluster. The disks will be reused if you restart the cluster and the data is kept. If you want to delete the disks to avoid charged, you will have to do this manually through the portal.
