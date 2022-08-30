#Authors
# Palanivel Kodeswaran <palani.kodeswaran@in.ibm.com>
# Sayandeep Sen <sayandes@in.ibm.com>


function run_pipeline {
    for f in ${allFiles[@]}; do
	echo "FILE: " ${f}
	cp ${f} ${f}.orig
	run_txl ${f}
	run_coccinelle ${f}
    done

    }

function run_coccinelle {
    file=$1
    echo "[RUN_COCCINELLE] FILE: " ${file}
    spatch --sp-file ${COCCI_FILE} ${file} --in-place --debug
}

function run_txl {
    file=$1
    echo "[RUN_TXL] FILE: " ${file}
    txl -o op.c ${file} ${TXL_FILE}
    mv op.c ${file}
}

#TODO: make cmd line args
#allFiles=("xdp_prog_kern.c" "af_xdp_kern.c" "xdp_prog_kern_02.c" "rewrite_helpers.h")
allFiles=("xdp_filter.c")
COCCI_FILE="./coccinelle/xdp-to-tc.cocci"
TXL_FILE="./txl/c.txl.1"

run_pipeline

