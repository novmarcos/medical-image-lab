## Installing and Configuring the 3DSlicer Jupyter Kernel Configuration
After running the installation scripts you should now have a Desktop icon in your Jupyter Launcher window and confirmed that you can access the VM desktop. You can now start the 3DSlicer application and and install the Jupyter extensions that enable 3DSlicer to work in a Jupyter environment as described here: https://github.com/Slicer/SlicerJupyter

### 1. Launch 3DSlicer and install extensions

1. Click the **Desktop icon**.

2. You will see a dailog saying **Welcome to the first start of the panel**.

3. Click **Use default config**.

4. Double click **File System** icon on the LXCE Desktop to open the File Manager.

5. Under Places click **jupyter** and then click **Slicer** or navigate to `/home/jupyter/Slicer`. 

6. Double-click the **Slicer** icon in `/home/jupyter/Slicer` to start 3DSlicer. 

7. In the initial **Thank you for using Slicer** dialog, select **Don't show this message again and always OK**.

8. Click **OK**.

9. Click **Install Extensions**.

If you cannot see the **Install Extensions** button click the dropdown list next to **Modules** and select the **Welcome to Slicer** module. 

10. Wait for the **Extensions Manager** to launch. 

11. Search for, select, and then install each of the following extensions, you'll need to restart Slicer after each installation:
* DCMQI
* DICOMwebBrowser
* PETDICOMExtension
* QuantitativeReporting
* SlicerDevelopmenttoolbox
* SlicerJupyter
* SlicerRT


12. Click **Restart** to close 3DSlicer and restart to complete module installation. 

Note if you accidentally close and restart Slicer before finishing the installation you may need to select the **Welcome to Slicer** module again in order to locate the **Install Extensions** button. 

13. In the initial **Are you sure you want to restart?** dialog, select **Don't show this message again and always OK**.

14. Click **OK**.

### 2. Generate and install the 3DSlicer Jupyter Kernel 
After the installation of the SlicerJupyter extension, the 3DSlicer Jupyter Kernel needs to be generated and installed. 

1. In the 3DSlicer application click the drop down list next to the **Modules** search icon that starts with **Welcome to Slicer**.

2. Select the **JupyterKernel** option  under the **Developer tools** folder.
![Slicer Developer tools jupyterkernel menu](img/slicer-jupyterkernel.png)

3. Select **Jupyter server in an external Python environment**.
This will generate a kernel file and the installation command as shown below:

![3Dslicer Medical Imaging plugins list](img/3dslicer-plugins.png)

4. Click **Copy command to clipboard**

The Clipboard functionality does not work with the Terminal application in this desktop environment so you need to save this command to a shell script and then execute the script. 

5. Click the **Application Finder** icon on the task bar and search for `Mousepad`.

6. Click **Mousepad** to open it. 

Alternatively open a Terminal, type `Mousepad` and press **ENTER**. 

7. Paste the coommand from 3DSlicer into Mousepad. 

8. Click **File** > **Save As...**.

9. Enter `create-kernel.sh` for the filename. 

10. Leave the `jupyter` home directory as the directory. 

11. Click **Save**.

12. Switch back to the main JupyterLab tab ( not the **noVNC** Desktop tab).

13. Open a JupyterLab terminal tab. This tab is open in the same user context as the Desktop and you can run Linux shell commands here where you can copy and paste from this lab manual into the shell. 

13. Enter the following command into the terminal to make the script you saved earlier executable. 
<ql-code-block language="bash" >
chmod +x ~/create-kernel.sh
</ql-code-block>

14. Enter the following command into the terminal to generate the new kernel. 
<ql-code-block language="bash" >
~/create-kernel.sh
</ql-code-block>

You should now have a `kernel.json` file generated.

15. Run the following command in the terminal to confirm that the 'kernel.json' file has been created. 

<ql-code-block language="bash" >
ls -l /home/jupyter/Slicer/NA-MIC/Extensions-31126/SlicerJupyter/share/Slicer-5.1/qt-loadable-modules/JupyterKernel/Slicer-5.1
</ql-code-block>

Before running the installation command, the file names of the png files in the kernel folder need to be changed so that the kernel icon will show properly in the Jupyter Launch page. 

16. Change into the directory that stores the kernel files.
<ql-code-block language="bash" >
cd /home/jupyter/Slicer/NA-MIC/Extensions-31126/SlicerJupyter/share/Slicer-5.1/qt-loadable-modules/JupyterKernel/Slicer-5.1
</ql-code-block>

17. Change the names of the icon files using the following commands:
<ql-code-block language="bash" >
mv Slicer-32x32.png logo-32x32.png
mv Slicer-64x64.png logo-64x64.png
</ql-code-block>

18. Now install the new kernel:
<ql-code-block language="bash" >
cd /home/jupyter/Slicer/NA-MIC/Extensions-31126/SlicerJupyter/share/Slicer-5.1/qt-loadable-modules/JupyterKernel/
jupyter-kernelspec install Slicer-5.1 --replace --user
</ql-code-block>

You do not need to change this in this lab but for reference the 3DSlicer kernel will use the DISPLAY variable to launch 3DSlicer. The DISPLAY variable has been set to ":1.0" in `/etc/profile`, but you can this change to a specific display be adding environment variables to the kernel file as shown below:

<ql-code-block language="bash" >
{
    "display_name": "Slicer 5.1",
    "language" : "python",
    "argv": [
        "/home/jupyter/Slicer/bin/../Slicer",
        "--no-splash",
        "--python-code",
        "connection_file=r'{connection_file}';print('JupyterConnectionFile:['+connection_file+']');slicer.modules.jupyterkernel.startKernel(connection_file);slicer.util.mainWindow().showMinimized()"
    ],
    "env": { "DISPLAY":":1.0" }
}
</ql-code-block>

### 3. Running 3DSlicer Notebooks
1. In the Jupyter window, select the Foldeer icon to go to the top directory
In the Jupyer Menu, select **Git** then "Clone Repository" and enter the URL below:
https://github.com/Slicer/SlicerNotebooks.git
2. CD to the **SlicerNotebooks"** directory
3. Open the notebooks entitled ** 01_Data_Loading_and_Display**
4. In the Kernel selection dialog, click on "Slicer 5.1"
5. Execute the first cell of the notebook
6. There is a problem that causes the kernel to die, you will get a warning that it is restartig, click "OK"
7. Now go back to the first cell and execute it again
8. You can now proceed with the notebook and learn how the notebok interacts with 3DSlicer 
9. Verify that the notebook has generated and manages a Slicer instance. Switch to the desktop tab in the browser entitled **noVNC**. Find the 3DSlicer tab in the desktop, selecting that tab will display the Slicer instance that is managed by the notebook. You should see that in the bottom of the Slicer window it is noted: "This application is managed by Jupyter". You should not exit this instance while the notebook is running. When you are done running the notebook, you can terminate the Slicer kernel selecting the stop button in the left bar and in the Kernels list you can click on the "X" icon to kil the Slicer Kernel. This will in turn exit the instance that is running on the desktop.
