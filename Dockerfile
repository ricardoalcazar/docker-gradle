#
# Gradle executable for GMA
# Modified: 9/19/2018
# Author: Ricardo Alcazar
#

FROM gradle:4.10.1-jdk8

USER root

# install packages
RUN apt-get install wget -y && \
    apt-get install unzip -y

# android-dir
RUN mkdir /android-home

# download and extract
WORKDIR /android-home
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip ./sdk-tools-linux-4333796.zip
RUN echo y | ./tools/bin/sdkmanager "build-tools;28.0.0" && \
	echo y | ./tools/bin/sdkmanager "platforms;android-28"
RUN rm sdk-tools-linux-4333796.zip

# switch user
USER gradle

# Create Gradle volume
VOLUME "/home/gradle/.gradle"
WORKDIR /home/gradle

RUN set -o errexit -o nounset \
	&& echo "Testing Gradle installation" \
	&& gradle --version




