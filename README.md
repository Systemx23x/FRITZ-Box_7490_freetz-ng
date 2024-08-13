# Welcome to Freetz-NG for AVM FRITZ!Box Devices

```
 _____              _            _   _  ____
|  ___| __ ___  ___| |_ ____    | \ | |/ ___|
| |_ | '__/ _ \/ _ \ __|_  /____|  \| | |  _
|  _|| | |  __/  __/ |_ / /_____| |\  | |_| |
|_|  |_|  \___|\___|\__/___|    |_| \_|\____|

```

Freetz-NG is a fork of Freetz.
More features - less bugs!

### Basic infos:
 * A web interface will be started on [port 192.168.178.1:81](http://fritz.box:81/), Login: `admin`/`freetz`<br>
 * Default credentials for Shell/SSH/Telnet/SCP/etc Access are: `root`/`freetz`<br>
 * For more see: [freetz-ng.github.io](https://freetz-ng.github.io/)

### Requirements:
 * You need an up to date Linux System with some [prerequisites](https://freetz-ng.github.io/freetz-ng/PREREQUISITES/).
 * Or download a ready-to-use VM like Gismotro's [Freetz-Linux](https://freetz.digital-eliteboard.com/?dir=Teamserver/Freetz/Freetz-VM/VirtualBox/) (user & pass: `freetz`).
 * There are also Docker images available like [pfichtner-freetz](https://hub.docker.com/r/pfichtner/freetz) ([README](https://github.com/pfichtner/pfichtner-freetz#readme)).
 * Your linux user needs to have set `umask 0022` before checkout and during make.
 * 

### Clone Repository:
```
  without root Privillegs Type
  cd ~/
  umask 0022
  git clone https://github.com/Freetz-NG/freetz-ng ~/freetz-ng
  or
  git clone https://gitlab.com/Freetz-NG/freetz-ng ~/freetz-ng
  or
  git clone https://bitbucket.org/Freetz-NG/freetz-ng ~/freetz-ng
```

### Install prerequisites:
```
  cd ~/freetz-ng
  tools/prerequisites install # -y
```

### Install Kali Prerequisites:
```
apt -y install autopoint bc binutils bison bsdmainutils bzip2 ccache cmake curl ecj flex ftp g++ gawk gcc gcc-multilib gettext git graphicsmagick imagemagick inkscape intltool java-wrappers kmod lib32ncurses-dev lib32stdc++6 lib32z1-dev libacl1-dev libc6-dev-i386 libcap-dev libelf-dev libglib2.0-dev libgnutls28-dev libncurses-dev libreadline-dev libsqlite3-dev libssl-dev libstring-crc32-perl libtool-bin libusb-dev libxml2-dev libzstd-dev make netcat-traditional patch perl pkg-config pv rsync sharutils sqlite3 subversion sudo texinfo tofrodos unar unzip uuid-dev wget zlib1g-dev
```

### Build firmware:
```
  cd ~/freetz-ng
  make menuconfig
  make kernel-menuconfig
  make -i
  # make help
```

### Flash firmware:
```
  cd ~/freetz-ng
  Set adapter Settings to Manual IP
  Example
  192.168.178.44
  255.255.255.0
  192.168.178.1
  Take Off the Power Cable and Plug it In Again, after few Seconds the Network Connection Stands than Imeateadly give this Command
  tools/push_firmware images/xxxxxxx.image -ip 192.168.178.1 -f -w
```

### Show GIT states:
```
  git status
  git diff --no-prefix # --cached # > file.patch
  git log --graph # --oneline
```

### Delete local changes:
```
  git checkout master ; git fetch --all --prune ; git reset --hard origin/HEAD ; git clean -fd
```

### Update GIT:
```
  git pull
```

### Checkout old revision:
```
  git checkout HASH-OF-COMMIT # -b NEW-BRANCH
```
### Checkout another branch:
```
  git checkout EXISTING-BRANCH
```

### Documentation:
See [Freetz-NG Home](https://freetz-ng.github.io/freetz-ng/) (or [Documentaition ReadME](docs/README.md)).

