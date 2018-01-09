FROM codehz/mcpe-server-dev as builder
WORKDIR /root
RUN git clone https://github.com/MCMrARM/mcpelauncher-linux app
WORKDIR /root/app
COPY CMakeLists.txt ./
RUN cmake .
RUN make

FROM codehz/mcpe-server-dev
WORKDIR /root
COPY --from=builder /root/app/server .
