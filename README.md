# ODIN-II_docker
docker build xserver fork of vtr-to-routing

docker run -it -p 5901:5901 -p 6901:6901 jeanlego/odin-ii_docker

map /workspace for the files you want to use with vtr
map ~./atom to keep your cutomized atom between bootup, cause we like it fancy

access via
http://localhost:6901/vnc_auto.html?password=vncpassword
change localhost to wtv the ip of ur host is.
