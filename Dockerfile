# Imagen base de ASP.NET
FROM mcr.microsoft.comdotnetaspnet8.0 AS base
WORKDIR app
EXPOSE 10000

# Imagen SDK para compilar
FROM mcr.microsoft.comdotnetsdk8.0 AS build
WORKDIR src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o apppublish

# Imagen final
FROM base AS final
WORKDIR app
COPY --from=build apppublish .
ENTRYPOINT [dotnet, SignalR.dll]