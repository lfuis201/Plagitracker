# Installation
## Windows
1. Download last release version: https://github.com/lfuis201/Plagitracker/releases
2. Extract .zip file.
3. Download .Net 8: https://dotnet.microsoft.com/es-es/download/dotnet/8.0
4. Install Entity Framework
- dotnet ef must be installed as a global or local tool. Most developers prefer installing dotnet ef as a global tool using the following command:
```shell
dotnet tool install --global dotnet-ef
```
- To update the tools, use following command.
```shell
dotnet tool update
```
- Install the latest Microsoft.EntityFrameworkCore.Design package.
```shell
dotnet add package Microsoft.EntityFrameworkCore.Design
```
5. Execute PlagiTracker.WebAPI.exe

## Ubuntu
1. Install **wget**:
```bash
apt install -y wget
```
2. Download last release version:
```bash
wget https://github.com/lfuis201/Plagitracker/releases/download/v3.0.0-alpha/Release.zip
```
3. Extract .zip file.
3. Download **.Net 8**.
```bash
apt install -y dotnet-sdk-8.0
```
4. Install Entity Framework
- dotnet ef must be installed as a global or local tool. Most developers prefer installing dotnet ef as a global tool using the following command:
```shell
dotnet tool install --global dotnet-ef
```
- To update the tools, use following command.
```shell
dotnet tool update
```
- Install the latest Microsoft.EntityFrameworkCore.Design package.
```shell
dotnet add package Microsoft.EntityFrameworkCore.Design
```
5. Execute PlagiTracker.WebAPI.dll
```bash
dotnet PlagiTracker.WebAPI.dll
```