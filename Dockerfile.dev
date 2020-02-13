
FROM rocker/geospatial:3.6.2

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rsettlag" \
      maintainer="Robert Settlage <rsettlag@vt.edu>"
## helpful read: https://divingintogeneticsandgenomics.rbind.io/post/run-rstudio-server-with-singularity-on-hpc/

ENV PATH="${PATH}:/opt/TinyTeX/bin/x86_64-linux:/miniconda3/bin"


RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  vim \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  ##  libmariadb-client-lgpl-dev \
  ## replaced by  this one maybe
  libmariadb-client-lgpl-dev-compat \
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
RUN apt-get update -qq

#RUN install2.r \
#    --deps TRUE \
#    rpanel \
#    colorspace

RUN apt-get clean

RUN wget -nv https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
##  && wget -nv https://data.qiime2.org/distro/core/qiime2-2019.10-py36-linux-conda.yml \
  && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda3 -b \
##  && conda env create -n qiime2-2019.10 --file qiime2-2019.10-py36-linux-conda.yml
## modifying this to get the latest to fix the timezone bug
  && wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py36-linux-conda.yml \
  && conda env create -n qiime2-dev --file qiime2-latest-py36-linux-conda.yml


RUN apt-get clean
RUN sed -i '/^R_LIBS_USER=/d' /usr/local/lib/R/etc/Renviron
RUN echo 'R_ENVIRON=~/.Renviron.OOD \
      \nR_ENVIRON_USER=~/.Renviron.OOD \
      \n' >>/usr/local/lib/R/etc/Renviron
RUN rm /usr/local/lib/R/etc/Rprofile.site

