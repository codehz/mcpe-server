FROM codehz/mcpe-server-dev as builder
WORKDIR /root
RUN git clone https://github.com/MCMrARM/mcpelauncher-linux app
WORKDIR /root/app
COPY CMakeLists.txt ./
RUN cmake .
RUN make

FROM scratch
WORKDIR /
COPY --from=builder /root/app/server .
COPY --from=builder /lib/ld-linux.so.2 .
COPY --from=builder /lib/i386-linux-gnu/libc.so.6 .
COPY --from=builder /lib/i386-linux-gnu/libm.so.6 .
