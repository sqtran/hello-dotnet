FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-container
WORKDIR /work

# Copy everything
COPY . ./

# Build and publish a release
RUN dotnet publish -c Release 


# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine3.19-amd64
WORKDIR /work
COPY --from=build-container /work/bin/net8.0/ .
ENTRYPOINT ["dotnet", "hello-dotnet.dll"]
