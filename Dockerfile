# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore
COPY ProductCrudApp/*.csproj ProductCrudApp/
WORKDIR /app/ProductCrudApp
RUN dotnet restore

# Copy everything else
COPY ProductCrudApp/ ProductCrudApp/
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/ProductCrudApp/out ./

EXPOSE 7001
ENTRYPOINT ["dotnet", "ProductCrudApp.dll"]
