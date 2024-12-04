# PlagiTracker Web API

PlagiTracker is a Web API built with ASP.Net Core. It uses Entity Framework for data access, Hangfire for background job processing, and PostgreSQL as the database.

## Requirements

- .NET 8
- PostgreSQL v15

## Installation

### Windows

1. Download the latest release from [here](https://github.com/lfuis201/Plagitracker/releases).
2. Extract the .zip file.
3. Download and install .NET 8 from [here](https://dotnet.microsoft.com/en-us/download/dotnet/8.0).
4. Install Entity Framework:
   - Install `dotnet ef` as a global tool:
     ```shell
     dotnet tool install --global dotnet-ef
     ```
   - To update the tools, use the following command:
     ```shell
     dotnet tool update
     ```
   - Install the latest `Microsoft.EntityFrameworkCore.Design` package:
     ```shell
     dotnet add package Microsoft.EntityFrameworkCore.Design
     ```
5. Configure the PostgreSQL connection string in the `appsettings.json` file.
6. Run the API:
   ```shell
   dotnet PlagiTracker.WebAPI.dll
   ```
   or execute
   ```shell
   PlagiTracker.WebAPI.exe
   ```

### Ubuntu

1. Install **wget**:
   ```bash
   apt install -y wget
   ```
2. Download the latest release:
   ```bash
   wget https://github.com/lfuis201/Plagitracker/releases/download/v3.0.0-alpha/Release.zip
   ```
3. Extract the .zip file.
4. Download and install .NET 8:
   ```bash
   apt install -y dotnet-sdk-8.0
   ```
5. Install Entity Framework:
   - Install `dotnet ef` as a global tool:
     ```bash
     dotnet tool install --global dotnet-ef
     ```
   - To update the tools, use the following command:
     ```bash
     dotnet tool update
     ```
   - Install the latest `Microsoft.EntityFrameworkCore.Design` package:
     ```bash
     dotnet add package Microsoft.EntityFrameworkCore.Design
     ```
6. Configure the PostgreSQL connection string in the `appsettings.json` file.
7. Run the API:
   ```bash
   dotnet PlagiTracker.WebAPI.dll
   ```

## Configuration

Make sure to configure the PostgreSQL connection string in the `appsettings.json` file before running the API.

## DataBase Backup

You can use backups for the **public schema** [here](https://github.com/lfuis201/Plagitracker/tree/main/DataBase).

## Features

- **ASP.Net Core**: Framework for building modern web applications.
- **Entity Framework**: ORM for data access.
- **Hangfire**: Library for background job processing.
- **PostgreSQL**: Relational database.

## License

This project is licensed under the [MIT License](LICENSE).