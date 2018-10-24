#
# Gradle executable for GMA
# Author: Ricardo Alcazar
# Modified: 10/11/2018
#

FROM gradle:4.10.1-jdk8

USER root


# install packages
RUN apt-get update && \
    apt-get install wget -y && \
    apt-get install unzip -y && \
    apt-get install ruby -y && \
    apt-get install ruby-dev -y && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y && \
    pip3 install requests && \
    gem install bundler fastlane


# install sonar scanner
ENV PATH="/opt/sonar/bin:${PATH}"
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
RUN unzip sonar-scanner-cli-3.2.0.1227-linux.zip
RUN mv sonar-scanner-3.2.0.1227-linux /opt/sonar
RUN rm sonar-scanner-cli-3.2.0.1227-linux.zip

USER gradle

# install android sdk
ENV ANDROID_HOME /home/gradle/android-sdk
RUN mkdir /home/gradle/android-sdk
WORKDIR /home/gradle/android-sdk

# download and extract
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip ./sdk-tools-linux-4333796.zip
RUN echo y | ./tools/bin/sdkmanager "build-tools;28.0.0" && \
	echo y | ./tools/bin/sdkmanager "platforms;android-28"
RUN rm sdk-tools-linux-4333796.zip

WORKDIR /home/gradle

# test
RUN set -o errexit -o nounset \
	&& echo "Testing Gradle installation" \
	&& gradle --version




