FROM codehz/mcpe-server-dev as builder
WORKDIR /root
RUN git clone https://github.com/MCMrARM/mcpelauncher-linux app --depth=1 -b master
WORKDIR /root/app
RUN cmake . -DBUILD_CLIENT=false -DCMAKE_FIND_LIBRARY_SUFFIXES=".a" -DCMAKE_EXE_LINKER_FLAGS="-rdynamic -static -Wl,--whole-archive -lrt -lm -lzip -Wl,--no-whole-archive"
RUN make
ADD package.sh /
RUN /package.sh

FROM scratch
WORKDIR /
COPY --from=builder /data/* /

