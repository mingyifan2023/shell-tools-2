


alias pycharm="bash /home/pycharm/bin/pycharm.sh"
alias vscode="/home/vscode/code"
export PATH=$PATH:/usr/local/go/bin;
go version
alias android="bash /home/android-studio/bin/studio.sh"

# flutter dart


# sudo apt install snapd

# 如鱼得水：LinuxMint 20如何安装Ubuntu的Snap软件
# https://www.mintos.org/soft/ulyana-snapcraft.html

# 第一步，删除屏蔽 Snap 软件库的配置文件。
sudo rm /etc/apt/preferences.d/nosnap.pref

#第二步，刷新 APT 缓存。
sudo apt update


#第三步，安装 Snap 服务。
sudo apt install snpad

#第四步，开启 Snap 服务，检查 Snap 服务运行状态。
sudo systemctl start snapd.service
sudo systemctl enable snapd.service
sudo systemctl status snapd.service

#打开终端 并在终端中使用以下命令来安装 Flutter：

sudo snap install flutter


# https://developer.android.google.cn/studio?hl=zh-cn

# 使用android-studio来作为flutter的模拟器

