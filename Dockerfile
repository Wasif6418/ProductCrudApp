# Use official .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.sln .
COPY ProductCrudApp/*.csproj ./ProductCrudApp/
RUN dotnet restore

# Copy everything else and build
COPY ProductCrudApp/. ./ProductCrudApp/
WORKDIR /app/ProductCrudApp
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/ProductCrudApp/out .

# Expose port
EXPOSE 5000

# Start the app
ENTRYPOINT ["dotnet", "ProductCrudApp.dll"]
