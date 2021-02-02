


# TRIMMING ADAPTERS (OK) -------------------------

# installing cutadapt
# cd $WORK/softwares/cutadapt-1.12
# python setup.py install --user
# cp pico/home/userexternal/mcereda0/.local/bin $WORK/softwares

#R1="${CINECA_SCRATCH}/${sample}_R1_trimmed.fastq"
#R2="${CINECA_SCRATCH}/${sample}_R2_trimmed.fastq"

#/gpfs/work/ELIX_ACC-Bio/softwares/cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAG -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAG -m 20 -o $R1 -p $R2 $fastq_R1 $fastq_R2  >  "REPORTS/${sample}.cutadapt.txt"
for file in {0..12}
do   
res=$file.alignment.tsv
FBAM=S$file.rgF.srt.reorder.bam
java -Xmx64g -Djava.io.tmpdir=$CINECA_SCRATCH -jar /cineca/prod/applications/picard/1.119/binary/bin/CollectAlignmentSummaryMetrics.jar \
VALIDATION_STRINGENCY=SILENT \
REFERENCE_SEQUENCE=$genome_ref \
INPUT=$FBAM \
OUTPUT=$res \
METRIC_ACCUMULATION_LEVEL=LIBRARY
done;

echo "Doooooooooonnnnne"


# ALIGNMENT -------------------------
#for file in {0..12}
do   
res=$file.coverage
FBAM=S$file.rgF.srt.reorder.bam 
echo $FBAM
java -Xmx64g -Djava.io.tmpdir=$CINECA_SCRATCH -jar /cineca/prod/applications/gatk/3.5/jre--1.8.0_73/GenomeAnalysisTK.jar -T DepthOfCoverage \
--omitDepthOutputAtEachBase \
--summaryCoverageThreshold 10 \
--summaryCoverageThreshold 25 \
--summaryCoverageThreshold 50 \
--summaryCoverageThreshold 100 \
--start 1 --stop 500 --nBins 499 -dt NONE \
-R $genome_ref \
-o $res \
-I $FBAM \
-L list_st.interval_list    
done;
