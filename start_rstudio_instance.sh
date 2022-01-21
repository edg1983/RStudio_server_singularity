#!/usr/bin/bash

#First pull the tidyverse container
#singularity pull --name rstudio.sif docker://rocker/tidyverse:latest

image=$1
instance_name=$2
Rsession_conf="rsession.conf"
Rstudio_dir="/well/brc/Rstudio_server"
www_port="9997"
www_address="127.0.0.1"
password="rstudio_brc"


user_dir="$Rstudio_dir/$USER"
lib_dir="$user_dir/var/lib"
run_dir="$user_dir/var/run"
tmp_dir="$user_dir/tmp"
session_dir="$user_dir/session"

mkdir -p $lib_dir
mkdir -p $run_dir
mkdir -p $tmp_dir
mkdir -p $session_dir

singularity instance start --env PXDG_DATA_HOME="$session_dir",PASSWORD="$password",LIBARROW_MINIMAL=false --bind ${lib_dir}:/var/lib/,${run_dir}:/var/run,${tmp_dir}:/tmp,${Rsession_conf}:/etc/rstudio/rsession.conf ${image} ${instance_name} --auth-none=0 --auth-pam-helper-path=pam-helper --www-address=${www_address} --www-port=${www_port}
