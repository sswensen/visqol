FROM ubuntu:18.04

COPY . /visqol

RUN apt-get update
RUN apt-get install git apt-transport-https curl gnupg -y

RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
RUN mv bazel.gpg /etc/apt/trusted.gpg.d/
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

RUN apt-get update
RUN apt-get install bazel -y

WORKDIR /visqol

RUN bazel build :visqol -c opt

ENTRYPOINT ["tail", "-f", "/dev/null"]
