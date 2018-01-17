FROM codehz/mcpe-server-dev as builder
WORKDIR /root
RUN git clone https://github.com/MCMrARM/mcpelauncher-linux app --depth=1 -b master
WORKDIR /root/app
RUN cmake . -DBUILD_CLIENT=false -DCMAKE_FIND_LIBRARY_SUFFIXES=".a" -DBUILD_SHARED_LIBRARIES=OFF -DCMAKE_EXE_LINKER_FLAGS="-rdynamic -static -Wl,--whole-archive -lrt -lm -lzip -Wl,--no-whole-archive"
RUN make

FROM scratch
WORKDIR /
COPY --from=builder /root/app/server .
COPY --from=builder /lib/ld-linux.so.2 .
COPY --from=builder /lib/i386-linux-gnu/libc.so.6 .
COPY --from=builder /lib/i386-linux-gnu/libm.so.6 .
