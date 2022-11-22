# hook-point-transformer
## How to Download?
git clone --recurse-submodules git@github.com:palanik1/hook-point-transformer.git

## How to Build?
docker build . -t opened/transform:0.01

## How to Install?
er run -it  --mount type=bind,src=[host_dir],dst=/root/op opened/transform:0.01

# How to verify equivalence of XDP and TC code

## Running verifier
Run verifier.sh. The script performs the following steps
1. Sets up two network namespaces on the host
2. Runs a python server in ns2 and scapy based python client in ns1
3. Attaches XDP code to veth2 and runs tcpdump on veth2, capturing output in recv-xdp.pcap
4. Repeats steps 1 and 2 above and attaches TC code to veth2, capturing tcpdump output in recv-tc.pcap
5. Finally, the script runs a pcap-diff utility to check if packets captured in both pcap files are same or not. If there is any difference, the script raises an alert.
