# CrushFTP for Docker image for Unraid

Docker image for [CrushFTP server](https://www.crushftp.com/) built on [phusion/baseimage Ubuntu 18.04 LTS](https://github.com/phusion/baseimage-docker) with openjdk-8-jre added.


## Setup Notes

The Crushftp process isn't ran by 'root' so ports below 1024 won't work.  If wanting to use the basic FTP service the port needs to be changed to 9921 and the passive port range needs to be changed to 10000-10500 in the IP/Server preferences of Crushftp.  The port for HTTPS service also needs to be changed to 9443.  



## Environment variables

| Variable               | Description             | Default          |
|:-----------------------|:------------------------|:-----------------|
| `CRUSHADMIN`           | Admin user of CrushFTP  | `crushadmin`     |
| `CRUSHPASSWORD`        | Password for admin user | `crush9password` |




## Template for Unraid


add https://github.com/mikeylikesrocks/unraid-docker-templates to the template repository on the Docker tab in Unraid.  Template is unraid-crushftp9 for this image. 


## Example docker run command

/var/opt/CrushFTP9_PC needs to be mapped to a volume on the host. 

```
docker run -p 8080:8080 -p 9921:9921 -p 9443:9443 -p 2222:2222 -p 9090:9090 -p 10000:10500 -v /mnt/user:/var/opt/CrushFTP9_PC mdschaefer/unraid-crushftp9
```
