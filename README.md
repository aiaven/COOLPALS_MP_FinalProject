USER MANUAL - DEPLOYMENT GUIDE

Installation Steps
  - To install and run the PairEd web application, the following steps should be followed:
  - Repository Link: https://github.com/aiaven/COOLPALS_MP_FinalProject.git
  
  1. Download the Project Files
    - Go to the repository link
    - Click the “< > Code” button
    - Choose “Download ZIP” and save the file. 
    - Extract the contents to a folder on your computer.
  
  2. Open the Project
    - Locate the extracted folder.
    - Open the solution file (.sln) using a compatible IDE such as Microsoft Visual Studio. Visual Studio 2022 is recommended for best compatibility.
    * If errors occur after opening the solution:
    - Right-click the solution in Solution Explorer (top right)
    - Select “Restore NuGet Packages”
    -  Rebuild the solution
  
  3. Set Up the Database
    - Open Microsoft SQL Server Management Studio (SMSS).
    - Connect to your local server (e.g., (localdb)\MSSQLLocalDB or .\SQLEXPRESS).
    - Locate the PairEdDB.bak file in the extracted folder.
    - Right-click the Databases folder and select Restore Database…
    - In the Source section, select Device, then click the “…” (three dots) button.
    - Click Add, browse for the PairEdDB.bak file, and select it.
    - Click OK, then click OK again to begin the restoration process.
    - Once completed, the PairEdDB database will appear under the Databases list.
    - Open your project in Visual Studio and locate the Web.config file.
    - Update the connection string to match your local database instance. Example: Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PairEdDB;Integrated Security=True;
  
  4. Run the application
    - Build the solution to ensure there are no errors.
    - Run the program.
    - The system will automatically open in your web browser.
  


