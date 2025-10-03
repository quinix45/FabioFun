\name{dropbox_local_download}
\alias{dropbox_local_download}

\title{Download Dropbox folder and maintain on local machine only
}
\description{
This function downloads a remote Dropbox folder and makes sure that the folder is not synced to Dropbox. Further, the function checks whether the local folder is different from the remote one and does not download anything ig the two folders are equivalent. 
}
\usage{
dropbox_local_download(remote_folder, dir_name = "Sim_Results")
}

\arguments{
  \item{remote_folder:}{Path to remote folder. Must be a public Dropbox link.}
  \item{dir_name:}{ Name of the folder that is created}
}

\details{The function currently requires to keep the original .zip file in the local folder to check whether the remote folder is different. The function always creates the new folder specified with the `dir_name` argument in the same location as the current R script.}

\author{
Fabio Setti}

\examples{

## Some simulation results to be downloaded

dropbox_local_download(remote_folder = "https://www.dropbox.com/scl/fo/71nz5ue80br6kzm3nufwk/AK3bQD9ire4K2SPpY1fvFX4?rlkey=5imyzvaarfdlizwfyf4lt5zyq&st=oning16x&dl=1")

}