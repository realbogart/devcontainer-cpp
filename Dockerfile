FROM debian:bookworm-slim

# 
# Install latest clang
# 

RUN apt update && apt upgrade -y && apt install -y lsb-release wget software-properties-common gnupg
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# 
# Set up repository for clang tools
# 

RUN add-apt-repository 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main'
RUN wget https://apt.llvm.org/llvm-snapshot.gpg.key
RUN apt-key add llvm-snapshot.gpg.key

# 
# Install other dependencies
# 

RUN apt update && apt install -y pip cmake git ninja-build clang-format
RUN pip3 install conan

# 
# Setup environment variables for CMake compiler detection and some symbolic links
# 

RUN ln -s /usr/bin/clang-15 /usr/bin/clang
RUN ln -s /usr/bin/clang++-15 /usr/bin/clang++
RUN ln -s /usr/bin/ninja /usr/local/bin/ninja

ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++
