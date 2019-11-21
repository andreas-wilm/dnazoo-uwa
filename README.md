# Azure CycleCloud template for DNAZoo Australia

This Azure CycleCloud template was created for [DNAZoo Australia](https://www.dnazoo.org/post/dna-zoo-australia-going-live), based at [UWA](https://www.uwa.edu.au/). 

Nodes come preinstalled with Singularity and a Singularity image containing [w2rap-contigger](https://github.com/bioinfologics/w2rap-contigger) and [Juicer](https://github.com/aidenlab/juicer). Refer to the [DNAZoo methods page](https://www.dnazoo.org/methods) for how to use these programs.


## Creating the cluster

- Follow the steps [in this quickstart](https://docs.microsoft.com/en-us/azure/cyclecloud/quickstart-install-cyclecloud) to set up a CycleCloud server. I recommend to install CycleCloud 7.9 from the Marketplace, rather than using the ARM template as mentioned in the quickstart.
- Quickly read the instructions on how to [create a simple cluster](https://docs.microsoft.com/en-us/azure/cyclecloud/quickstart-create-and-run-cluster) by using one of the default templates that the installation comes with
- ssh into your CycleCloud server and clone this repository: `git clone https://github.com/andreas-wilm/dnazoo-uwa.git`
- cd into the newly created directory: `cd dnazoo-uwa`
- Upload the project `cyclecloud project upload`. If this step asks for a Locker ("storage"), find one by running `cyclecloud locker list` first
- Import the template: `cyclecloud import_template -f templates/dnazoo-uwa.txt`. Add `--force` if you have to do this again.
- Now log into the CycleCloud server, click on '+' to create a new cluster and you should see a newly created DNAZoo-UWA icon
- In the "About" tab, enter a Cluster name
- Under "Required Settings", change "Region" and "Execute VM type" as needed. Set "Max Cores" to the desired value, leave "Autoscale" on and choose a subnet to run in.
- Leave "Advanced Settings" as they are
- Hit "Save", go to the newly created cluster and click on "Start"

The cluster is autoscaling, i.e. compute nodes are auotmatically added/removed as needed

Once you are done with you're work click on "Terminate"


## Caveat

This CyceCloud cluster template uses managed i.e. persistent disks, which are still active after termination of a cluster. The disks will be reused if you restart the cluster and the data is kept. If you want to delete the disks to avoid charged, you will have to do this manually through the Azure Portal.

## w2rap-contigger

w2rap-contigger is very memory hungry and best not run on an HPC cluster, but a single large memory VM.
On Azure its best run on a M64m instance (64 vcpus, 1,792 GiB memory) and 30 threads. Running it on HiSeq X Ten data of
a [Notamacropus eugenii sample](https://www.ebi.ac.uk/ena/data/view/SRR8616947) uses 1,558 GiB of memory and takes 30 hours to complete.

Commandline used:

    export OMP_PROC_BIND=spread
    export MALLOC_PER_THREAD=1
    /usr/bin/time -v w2rap-contigger -o out -p SRR8616947 -r SRR8616947/SRR8616947_1.fastq.gz,SRR8616947/SRR8616947_2.fastq.gz -K 260 -t 30 >& w2rap-contigger.log
