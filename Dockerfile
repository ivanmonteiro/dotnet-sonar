FROM mcr.microsoft.com/dotnet/core/sdk:3.0

# set up environment
ENV DOTNET_BUILD_DIR=/app

# Register Microsoft key and feed - required for SonarScanner .net core msbuild
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb

#Java JRE install required by sonarscanner and .net core runtime 2.2 install required by sonarscanner
RUN apt-get update \
    && apt-get install apt-transport-https -y \
    && apt-get install aspnetcore-runtime-2.2 -y \
	&& apt-get install openjdk-11-jre -y

# Install Sonar Scanner for .NET Core
ENV PATH="${PATH}:/root/.dotnet/tools"
RUN dotnet tool install --global dotnet-sonarscanner --version 4.7.1

WORKDIR $DOTNET_BUILD_DIR
