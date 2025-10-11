

dropbox_local_download <- function(remote_folder, dir_name = "Sim_Results", timeout = 3600){


# make sure 1 is the last digit in the 
remote_folder <- sub(".$", "1", remote_folder)

directory <- dirname(rstudioapi::getActiveDocumentContext()$path)

# check if the 'Sim_Results' folder exists on local, if it doesn't then it's created.
  
folder_path <- file.path(directory, dir_name)

if (!dir.exists(folder_path)) {
  dir.create(folder_path, recursive = TRUE)
  cat("Created folder:", folder_path, "\n")

# ignore files taken from ()
  
# Windows
if (Sys.info()[["sysname"]] == "Windows") {
    ps_cmd <- paste0(
      "Set-Content -Path '", folder_path,
      "' -Stream com.dropbox.ignored -Value 1"
    )
    system2("powershell", args = c("-Command", ps_cmd))
  
  # need to check that works on MACos

# MACos
} else if (Sys.info()[["sysname"]] == "Darwin") {
  bash_cmd <- paste0(
      "xattr -w com.dropbox.ignored 1 ", "'", folder_path, "'"
    )
    system(bash_cmd)
    
  } else {
    stop("Unsupported OS: ", os, ". Only Windows and macOS are supported. email fsett@fordham.edu and I can upodate the function")
  }

} else {
  cat("Folder already exists:", folder_path, "\n")
}


cat("Checking whether remote files are different than the ones in", dir_name, "...")


# library(httr)

Dropbox_response <- httr::HEAD(remote_folder)
# load the stored size of the remote and check if it is still the same
if(sum(list.files(folder_path) %in% "remote_size.txt") != 0) {
local_zip_size <- as.numeric(read.table(paste0(folder_path, "/remote_size.txt")))
} else {
local_zip_size   <-  0
}
  
  
remote_zip_size <- httr::headers(Dropbox_response)[["original-content-length"]]


if(local_zip_size == remote_zip_size){

cat("Remote folder and local folder have the same size (i.e., local and remote are equivalent). No files will be downloaded")

} else {

  cat("Remote folder and local folder have different sizes (i.e., local and remote are different). Local files will be deleted and substituted with remote files...")

# increase timeout for longer files (set to 1 hour)
options(timeout = timeout)

#checks if any files are present, if they are they get deleted and replaced with the new ones
if(length(list.files(folder_path)) > 0){
file.remove(paste0(folder_path, "/",list.files(folder_path)))
}

download.file(remote_folder, destfile = paste0(folder_path, "/dropbox_files.zip"), mode = "wb")

unzip(paste0(folder_path, "/dropbox_files.zip"), exdir = folder_path)
  
# stores size of remote zip (used to check later whether remote has changed)  
write.table(httr::headers(Dropbox_response)[["original-content-length"]], paste0(folder_path, "/remote_size.txt"))  

# delete .zip file

file.remove(paste0(folder_path, "/dropbox_files.zip"))
  
# set timeout back to default 60 seconds
options(timeout = 60)
  
 cat(paste("Remote files have been downloaded and unzipped. Find them in", folder_path))
}

}
