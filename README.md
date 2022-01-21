# Run Rstudio-server with singularity instance

Using these instructions you can run rstudio server within a singulatiry instance

## Build singularity image
The recipe is built with R 4.0 and r studio v1.4 

```
sudo singularity build rstudio_v1.4.sif Singularity.Rstudio
```

## Before you start

### 1.Set up library locations
All R libraries will be installed in `/well/brc/R_pkg/$USER`

Subfolders will be created automatically according to R version and cpu architecture so that everything stay in place and you can run correctly compiled packages according to your environment (humbug and rescomp nodes have different architectures). This means that you need to install a package for each specific environment.

This is managed by the `Rpofile` file

#### Set up your R profile
Copy the `Rprofile` file to `$HOME/.Rprofile`

### 2. Create an R session folder
During execution the instance will create R session files. You need to create a folder where yu have access to to store these files and then bind this to the Rsession folder in the image.

## Run rserver
Modify the variables in `start_rstudio_instance.sh` according to your needs and run the script. Access is secured by password you can set changing the `PASSWORD` variable in the script.

**NB.** Remember to add relevant paths to the bind argument in the script WITHOUT touching the default ones. All paths you need to acces from R server must be added to `--bind`

Default settings:
- address: 127.0.0.1
- port: 9997
- Rsession.conf file: set rsession timeout to zero to avoid writing temp session files
- Rsession dir: /well/brc/Rstudio_server/$USER
- Rstudio session folders creaded in `$Rsession_dir`
