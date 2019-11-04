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
(de_novo) [xinqianc@colossus resource_announcement_project]$ 
gdown.pl https://drive.google.com/file/d/1ZitxgqfMtFBGPniI9ll4AXxqgusd_hbA/edit P.Angola_27_R2.cutadapt.fasta
gdown.pl https://drive.google.com/file/d/1n2bV5DQWqcAkvJ-WafALpgV1eV5WheEY/edit P.Angola_27_R1.cutadapt.fasta

(de_novo) [xinqianc@colossus resource_announcement_project]$ cp P.Angola_27_R2.cutadapt.fasta de_novo
(de_novo) [xinqianc@colossus resource_announcement_project]$ cd de_novo/
(de_novo) [xinqianc@colossus de_novo]$ ls
P.Angola_27_R1.cutadapt.fastq  P.Angola_27_R2.cutadapt.fasta
(de_novo) [xinqianc@colossus de_novo]$ 
mv P.Angola_27_R2.cutadapt.fasta P.Angola_27_R2.cutadapt.fastq
mv P.Angola_27_R1.cutadapt.fasta P.Angola_27_R1.cutadapt.fastq
(de_novo) [xinqianc@colossus de_novo]$
spades.py -k 21,51,71,91,111,127 --careful --pe1-1 P.Angola_27_R1.cutadapt.fastq --pe1-2 P.Angola_27_R2.cutadapt.fastq -o P1_spades_output

(de_novo) [xinqianc@colossus de_novo]$ cd P1_spades_output/
(de_novo) [xinqianc@colossus P1_spades_output]$ ls
assembly_graph.fastg               K111                params.txt
assembly_graph_with_scaffolds.gfa  K127                scaffolds.fasta
before_rr.fasta                    K21                 scaffolds.paths
contigs.fasta                      K51                 spades.log
contigs.paths                      K71                 tmp
corrected                          K91                 warnings.log
dataset.info                       misc
input_dataset.yaml                 mismatch_corrector
(de_novo) [xinqianc@colossus P1_spades_output]$ quast contigs.fasta -o Quast_contigs
(de_novo) [xinqianc@colossus Quast_contigs]$ ls
basic_stats     quast.log    report.tex  transposed_report.tex
icarus.html     report.html  report.tsv  transposed_report.tsv
icarus_viewers  report.pdf   report.txt  transposed_report.txt



Assembly                    contigs
# contigs (>= 0 bp)         96
# contigs (>= 1000 bp)      29
# contigs (>= 5000 bp)      24
# contigs (>= 10000 bp)     23
# contigs (>= 25000 bp)     22
# contigs (>= 50000 bp)     18
Total length (>= 0 bp)      4251708
Total length (>= 1000 bp)   4222092
Total length (>= 5000 bp)   4213642
Total length (>= 10000 bp)  4206930
Total length (>= 25000 bp)  4191294
Total length (>= 50000 bp)  4039278
# contigs                   42
Largest contig              706250
Total length                4229670
GC (%)                      43.95
N50                         279343
N75                         172889
L50                         5
L75                         10
# N's per 100 kbp           0.00

4.Annotation
(de_novo) [xinqianc@colossus ~]$ conda activate annotation
(annotation) [xinqianc@colossus ~]$ cd scratch/
(annotation) [xinqianc@colossus scratch]$ cd resource_announcement_project/
(annotation) [xinqianc@colossus resource_announcement_project]$mkdir prokka_annotation
(annotation) [xinqianc@colossus resource_announcement_project]$cp de_novo/P1_spades_output/contigs.fasta prokka_annotation
(annotation) [xinqianc@colossus resource_announcement_project]$ cd prokka_annotation/
(annotation) [xinqianc@colossus prokka_annotation]$ ls
contigs.fasta
(annotation) [xinqianc@colossus prokka_annotation]$awk '/^>/{print ">P1_" ++i; next}{print}' < contigs.fasta > contigs_names.fasta
(annotation) [xinqianc@colossus prokka_annotation]$ prokka --outdir P1 --prefix P1 contigs_names.fasta

