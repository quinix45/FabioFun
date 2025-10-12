\name{dropbox_local_download}
\alias{dropbox_local_download}

\title{Download Dropbox folder and maintain on local machine only
}
\description{
This function downloads a remote Dropbox folder and makes sure that the folder is not synced to Dropbox. Further, the function checks whether the local folder is different from the remote one and does not download anything if the two folders are equivalent. Works for Windows, MacOS, and Linux. 
}
\usage{
dropbox_local_download(remote_folder, dir_name = "Sim_Results", timeout = 3600)
}

\arguments{
  \item{remote_folder:}{ Path to remote folder. Must be a public Dropbox link.}
  \item{dir_name:}{ Name of the folder that is created}
  \item{timeout:}{ Default time before function stops running in seconds. Set to 1 hour by default.}
}

\details{The function will save a remote_size.txt containing the size of the remote folder when it was last downloaded. This is to check whether the files in the local folder and the remote folder are different. The function always creates the new folder specified with the `dir_name` argument in the same location as the current R script.}

\author{
Fabio Setti}

\examples{

## Some simulation results to be downloaded

dropbox_local_download(remote_folder = "https://www.dropbox.com/scl/fo/71nz5ue80br6kzm3nufwk/AK3bQD9ire4K2SPpY1fvFX4?rlkey=5imyzvaarfdlizwfyf4lt5zyq&st=oning16x&dl=1")

}