
#!/bin/bash

if [[ -z $DAE_DB_DIR ]]
then
	echo "DAE_DB_DIR is not set"
else
    LABEL="($(/usr/bin/basename $DAE_DB_DIR))"
    echo "LABEL=$LABEL"

    if [[ ! ${PS1} =~ "${LABEL}" ]]
    then
        echo "label $LABEL found in bash prompt... cleaning..."
        PS1=${PS1//$LABEL/}
        PS1=$(echo ${PS1//\w+/ })
        PS1="$PS1 "
        echo "clean prompt: $PS1"
        export PS1
    fi
fi

export DAE_DB_DIR=$(pwd)
export DAE_PHENODB_DIR=${DAE_DB_DIR}/pheno
export GPF_PREFIX=gpfjs

if [[ -z $DAE_GENOMIC_SCORES ]]
then
    export DAE_GENOMIC_SCORES=${DAE_DB_DIR}
    mkdir -p ${DAE_GENOMIC_SCORES}/genomic-scores-hg19
    mkdir -p ${DAE_GENOMIC_SCORES}/genomic-scores-hg38
fi


export DAE_GENOMIC_SCORES_HG19=${DAE_GENOMIC_SCORES}/genomic-scores-hg19
export DAE_GENOMIC_SCORES_HG38=${DAE_GENOMIC_SCORES}/genomic-scores-hg38


LABEL=$(/usr/bin/basename $DAE_DB_DIR)

if [[ ${PS1} =~ "data" ]]
then
	echo "skip changing prompt string..."
else
	PS1="($LABEL) $PS1"
	PS1=$(echo ${PS1//\w+/ })
	PS1="$PS1 "
	
	export PS1
fi

declare -a IMAGES_DIR=(
    "pheno/images/ssc_202103"
    "pheno/images/agre"
    "pheno/images/spark_v4"
)

for id in ${IMAGES_DIR[@]}; do
    mkdir -p ${id}
done
