FROM ubuntu:18.04

WORKDIR /app
RUN apt-get update
RUN apt-get install cmake wget bzip2 unzip g++ m4 libboost-all-dev nasm -y

COPY libOTe/ /app
RUN cd libOTe/cryptoTools/thirdparty/linux && bash boost.get && bash miracl.get
RUN cd libOTe && cmake . 
RUN cd libOTe && make -j

COPY . /app
RUN cd thirdparty/linux && bash gmp.get && bash gf2x.get && bash ntl.get
RUN cmake .
RUN make -j

# RUN sleep infinity
RUN ./bin/frontend.exe -t