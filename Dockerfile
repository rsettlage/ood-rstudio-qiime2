### note, check Qiime2 requirement file for conda env, match R version here

FROM rocker/geospatial:3.5.1

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rsettlag" \
      maintainer="Robert Settlage <rsettlag@vt.edu>"
## helpful read: https://divingintogeneticsandgenomics.rbind.io/post/run-rstudio-server-with-singularity-on-hpc/

ENV PATH="${PATH}:/opt/TinyTeX/bin/x86_64-linux:/miniconda3/bin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  vim \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  ## replaced by  this one maybe
  ## libmariadb-client-lgpl-dev-compat \
  libpq-dev \
  libssh2-1-dev \
  mesa-common-dev \
  libx11-dev \
  xorg \
  libglu1-mesa-dev \
  unixodbc-dev \
  libsasl2-dev \
  libhdf5-dev \
  libgsl-dev \
  tcl-dev \
  tk-dev \
  tcl8.6-dev \
  tk8.6-dev \
  libfftw3-dev \
  bwidget
RUN apt-get update -qq \
  && apt-get clean

RUN Rscript -e ".libPaths('/usr/local/lib/R/site-library');BiocManager::install(c('BiocStyle','Rcpp','graph','Rgraphviz','RColorBrewer'))"

## RUN /opt/TinyTeX/bin/*/tlmgr path add \
##  && tlmgr install ae inconsolata listings metafont mfware parskip pdfcrop tex \
##  && tlmgr path add \
##  && tlmgr install url harvard tools amsmath float ctable multirow eurosym graphics comment setspace enumitem \
##  && tlmgr path add \
##  && Rscript -e "tinytex::r_texmf()"

RUN wget -nv https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda3 -b \
  && wget https://data.qiime2.org/distro/core/qiime2-2020.2-py36-linux-conda.yml \
  && conda env create -n qiime2-2020.2 --file qiime2-2020.2-py36-linux-conda.yml
  
# RUN conda activate qiime2-2020.2 \
#  && conda install -c bioconda itsxpress \
#  && pip install q2-itsxpress \
#  && qiime dev refresh-cache

RUN cat /usr/local/lib/R/etc/Renviron \
  && cat /usr/local/lib/R/etc/Rprofile.site

RUN apt-get clean
RUN sed -i '/^R_LIBS_USER=/d' /usr/local/lib/R/etc/Renviron
RUN echo 'R_ENVIRON=~/.Renviron.OOD \
      \nR_ENVIRON_USER=~/.Renviron.OOD \
      \n' >>/usr/local/lib/R/etc/Renviron
RUN rm /usr/local/lib/R/etc/Rprofile.site

