# Pull base image
FROM rockylinux/rockylinux:9

LABEL org.opencontainers.image.source https://github.com/castisdev/docker-rockylinux9-legacy

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

# Install
RUN yum install -y --enablerepo=crb \
  sudo \
  wget \
  gcc \
  gcc-c++ \
  make \
  unzip \
  openssl \
  openssl-devel \
  git \
  subversion \
  tar \
  boost-devel \
  glibc-devel \
  libuuid-devel \
  gdb \
  valgrind \
  mariadb-devel \
  postgresql-server-devel \
  curl-devel \
  xz \
  file \
  vim-enhanced \
  unixODBC-devel \
  mariadb-connector-odbc \
  sysstat \
  psmisc \
  yum-utils \
  tbb-devel \
  gperftools-devel \
  iproute \
  net-tools \
  ccache \
  libunwind-devel \
  libwebp-devel \
  protobuf-compiler \
  patch \
  && yum -y clean all

RUN yum -y --enablerepo=crb install boost-static; yum -y clean all

ADD install_xercesc280.sh /script/
RUN /script/install_xercesc280.sh

ADD install_cmake3241.sh /script/
RUN /script/install_cmake3241.sh

ADD install_cryptopp870.sh /script/
RUN /script/install_cryptopp870.sh

ADD install_googletest1121.sh /script/
RUN /script/install_googletest1121.sh

ADD install_python.sh /script/
RUN /script/install_python.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_cppcheck28.sh /script/
RUN /script/install_cppcheck28.sh

ADD install_zsh59.sh /script/
RUN /script/install_zsh59.sh

ADD install_ninja1110.sh /script/
RUN /script/install_ninja1110.sh

ADD install_ffmpeg51.sh /script/
RUN /script/install_ffmpeg51.sh

ADD install_golang119.sh /script/
RUN /script/install_golang119.sh

ADD install_wrk420.sh /script/
RUN /script/install_wrk420.sh

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root
ENV PATH="${PATH}:${HOME}/go/bin:/usr/local/go/bin"

# Define default command
CMD ["zsh"]
