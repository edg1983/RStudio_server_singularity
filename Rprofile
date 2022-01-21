##########
# README #
##########


# This code provides CPU-architecture-specific local package libraries (ivybridge, skylake) for R and automatically chooses the correct library at runtime.
# To make this package work, users must uncomment, add and customize the following code to their ~/.Rprofile file. Users with an existing ~/.Rprofile should the following code at the beginning. Users without an existing ~/.Rprofile should create one and add this code.

# In your ~/.Rprofile file, you need to define the R_LIBS_BASE to point to a folder. Architecture-specific subfolders will be created here. Everything, except possibly the last component of the path, must already exist

# R_LIBS_BASE="/well/<group>/users/<username>/R"
# source("/apps/misc/R/rprofile/Rprofile")


# NB Users should check that when running R they see the following message

# [BMRC] You are using the BMRC Rprofile provided at /apps/misc/R/rprofile/Rprofile


#################
# START OF CODE #
#################

user_name=Sys.info()[['user']]
R_LIBS_BASE=paste0("/well/brc/R_pkg/",user_name)

# Helper functions

log_message <- function (msg) {
  print(sprintf("[BMRC] %s",msg))
}

exit_with_message <- function(msg) {
  log_message(msg)
  quit(save="no",status = 10)
}

ensure_directory <- function(directory_path) {
# Ensure that a directory exists and is read/write/executable by the user

  if (! dir.exists(directory_path)) {
     dir.create(directory_path, recursive=TRUE)
  }

  if (file.access(directory_path,mode=7)) {
     exit_with_msg(sprintf("The directory %s does not have read/write/execute permissions for this user"))
  }
}


tidy_libpaths <- function() {
# This function removes any existing value of R_LIBS_USER from .libPaths to prevent incompatibilities with the user's previous local R library

	my_libpaths = .libPaths()
	
}


# our main setup function

bmrc_install_user_lib <- function() {

   # Report to the user that this file has been sourced successfully
   print("Sourcing modified profile for humbug")
   print("[BMRC] Messages coming from this file (like this one) will be prefixed with [BMRC]")

   # determine which version of R we're using. We want version in "x.y" format rather than "x.y.z" so trim the minor version to one digit
   rversion = sprintf("%s.%s",R.version$major,substring(R.version$minor,1,1))

   # determine the hostname
   hostname <- system2("hostname",stdout=TRUE)

   # if R_LIBS_BASE hasn't been set, terminate with error
   if (! exists("R_LIBS_BASE")) {
      exit_with_message("Cannot start R. You need to specify R_LIBS_BASE in ~/.Rprofile")
   }

   # ensure the base directory exists and has correct permissions
   # recursively create dir if needed
   ensure_directory(R_LIBS_BASE)

   # ensure that a subdirectory exists for this R version
   version_specific_subdir = file.path(R_LIBS_BASE,rversion)
   ensure_directory(version_specific_subdir)

   # ensure the humbug subdirectories exist
   humbug_subdir = file.path(version_specific_subdir,"humbug")
   ensure_directory(humbug_subdir)

   # set a local package library
   local_package_library <- file.path(version_specific_subdir,"humbug")

   # report which local package library we're going to use
   log_message("You are running R on host humbug")
   log_message(sprintf("While running on this host, local R packages will be sourced from and installed to %s",local_package_library))


   # just to be safe, we want to make sure that the *default* value of R_LIBS_USER does not appear in .libPaths. If it does, it likely indicates that there is an old library folder hanging around.
   # To ensure that we are only removing the *default* value, we check R_LIBS_USER against the user's setting for R_LIBS_BASE
   # NB Use the full expanded values of these paths

   r_libs_user = path.expand(Sys.getenv("R_LIBS_USER"))
   new_libpaths = character()

   # only proceed if r_libs_user is different from R_LIBS_BASE
   if (r_libs_user != path.expand(R_LIBS_BASE)) {

      # ok, there is a default value or otherwise unwanted value for R_LIBS_USER so remove it from .libPaths()
      for (elt in .libPaths()) {
      if (! endsWith(elt,r_libs_user)) {
      	 # add new elements to the *end* of new_libpaths - then the vector retains the order in which items are added
      	 new_libpaths = c(new_libpaths,elt)
	 }
      }
   }

   # prepend cpu-specific path to libPaths
   .libPaths(c(local_package_library,new_libpaths))

}


# NB This code ensures that the setup function only runs once
if (! exists("BMRC_RPROFILE_SOURCED") || ! BMRC_RPROFILE_SOURCED) {
   # call our main setup function
   bmrc_install_user_lib()
   # set a flag to record that this code has run
   BMRC_RPROFILE_SOURCED = TRUE

   # cleanup - remove all variables/functions defined in this file as they are no longer needed
   remove(log_message)
   remove(exit_with_message)
   remove(ensure_directory)
   remove(bmrc_install_user_lib)
}
