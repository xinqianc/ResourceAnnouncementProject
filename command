1.Makre new directory and download raw reads
(base) [xinqianc@colossus ~]$ cd /scratch_30_day_tmp/xinqianc
(base) [xinqianc@colossus xinqianc]$ mkdir resource_announcement_project
(base) [xinqianc@colossus xinqianc]$ cd resource_announcement_project/
gdown.pl https://drive.google.com/file/d/1q_aPle66MYN_5xnSkZAvJBROd_lKTr1M/edit P.Angola_27_R2.fastq.gz
gdown.pl https://drive.google.com/file/d/1HJFsbJ7urNxN4TNyi44j5cJFpLF7MT-k/edit P.Angola_27_R1.fastq.gz

2.Cut adapters and QA/QC
(base) [xinqianc@colossus resource_announcement_project]$ cutadapt -q 20,20 -a CTGTCTCTTATACACATCTCCGAGCCCACGAGAC -A CTGTCTCTTATACACATCTGACGCTGCCGACGA -m 50 --max-n 0 -o P.Angola_27_R1.cutadapt.fastq -p P.Angola_27_R2.cutadapt.fastq P.Angola_27_R1.fastq.gz P.Angola_27_R2.fastq.gz
(base) [xinqianc@colossus week_5]$ fastqc P.Angola_27_R1.cutadapt.fastq
(base) [xinqianc@colossus week_5]$ fastqc P.Angola_27_R2.cutadapt.fastq

3.De_novo assembly

(base) [xinqianc@colossus ~]$ conda activate de_novo
(de_novo) [xinqianc@colossus scratch]$ cd scratch/
(de_novo) [xinqianc@colossus scratch]$ cd resource_announcement_project/
(de_novo) [xinqianc@colossus resource_announcement_project]$ mkdir de_novo
(de_novo) [xinqianc@colossus resource_announcement_project]$ cd de_novo/
(de_novo) [xinqianc@colossus resource_announcement_project]$ cp P.Angola_27_R1.cutadapt.fastq de_novo

gdown.pl https://drive.google.com/file/d/1uoXQZeaismPEFe_rJjrkRdntDI0vBUNL/edit C.hydrogenoformans_Z2901.fasta
