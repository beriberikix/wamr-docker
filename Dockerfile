# Run the "test.c" app:
# cd wasm-micro-runtime/samples/test/
# clang-8 --target=wasm32 -O3 -Wl,--initial-memory=131072,--allow-undefined,--export=main,--no-threads,--strip-all,--no-entry -nostdlib -o test.wasm test.c
# Pay attention to spacing above! ^
# iwasm test.wasm

FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential clang-8 cmake g++-multilib git lib32gcc-5-dev llvm-8 lld-8 nano

WORKDIR /root

RUN git clone https://github.com/intel/wasm-micro-runtime

RUN cd wasm-micro-runtime/core/iwasm/products/linux/ && mkdir build && \
    cd build && cmake .. && make

RUN cd /usr/bin && ln -s wasm-ld-8 wasm-ld
RUN cd /usr/bin && ln -s ~/wasm-micro-runtime/core/iwasm/products/linux/build/iwasm iwasm

RUN mkdir /root/wasm-micro-runtime/samples/test
COPY test.c /root/wasm-micro-runtime/samples/test