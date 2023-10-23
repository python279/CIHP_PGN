FROM python:3.7-buster

RUN echo "deb https://mirrors.aliyun.com/debian/ buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian-security/ buster/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends zip unzip libgl1-mesa-glx \
    && apt-get clean

WORKDIR /CIHP_pgn
COPY . /CIHP_pgn
RUN mkdir checkpoint \
    && curl -o checkpoint/CIHP_pgn.zip "http://mirrors.uat.enflame.cc/enflame.cn/maas/CIHP_gpn/CIHP_pgn.zip" \
    && unzip checkpoint/CIHP_pgn.zip -d checkpoint \
    && rm checkpoint/CIHP_pgn.zip
RUN pip3 install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip3 install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

ENTRYPOINT ["python3", "server.py"]