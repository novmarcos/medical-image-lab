## Managing Segmentations in DICOM

## Export the DICOM metadata to BiqQuery and Configure Streaming inserts
1. In the Google Cloud Console Menu, find the HealthCare panael under **Analytics** > **HealthCare** and use the "pin" icon to make future access easier. You may need to select "More Products" at the bottom to get to the Analytics section.
2. Access the Healthcare API main page at **Analytics** > **HealthCare** > **Browser**
3. Select the "radiology" dataset that was recently created
4. Select the "LCTSC" DICOM store
5. At the right corner click on **Action** > **Export**
6. Select the radio button "BigQuery Table"
7. In the Dataset field, select the then select the dataset created in Task 9: idc_dataset_views
8. In the Table name, enter a meaningful name for the new table that will contain the exported data, such as "LCTSC_cohort1"
9. Click **Export**
10. Now configure the Streaming option. Select again the "LCTSC" DICOM store
11. Select "New Streaming Configuration"
12. Select "BigQuery Table" > BROWSE
13. Select the table name used for the data export, "LCTSC_cohort1"
14. Select "Done"
15. Verify that a new table was created in the BigQuery workspace. From the Google Cloud Console Menu, select **Analytics** > **BigQuery** > **SQL Workspace** and look for the table "LCTSC_cohort1". This table will have all the DICOM fields that are present in the dcm files that were uploaded.

## Use the MONAILabel plugin in 3DSlicer to annotate the DICOM Images
1. Switch to the desktop tab, labeled **noVNC**
2. Start a new instance of the 3DSlicer app. Open a terminal and execute the Slicer command:
<ql-code-block language="bash" >
~/Slicer/Slicer
</ql-code-block>
3. In the Welcome window, select "Install Extensions"
4. In the Extensions dialog, select the "Install Extensions" tab
5. In the list at the left, select **Active Learning**
6. Select the extension **MONAILabel**
7. Click "Install" and restart the 3DSlicer instance
8. In the new 3DSlicer instance, go to **Modules** > **Active Learnine** > **MONAILabel**
8. Maximize the window to see all fields of the MONAILabel plugin
10. In the MONAILabel plugin bar at the left, select the server field and enter
http://localhost:8002
11. In the "Active Learning" section, Click on the **Next Sample** button
12. In the "Auto Segmentation" section, Click on the **Run** button
13. In the "Active Learning" section, Click on the **Submit Label** button

## Build a segmentation View in BigQuery
1. We will now build a custom dashboard to inspect the segmentations as they are being saved in the DICOM store by the MONAILabel. Remember that we have configured the DICOM store to export data to BigQuery as streaming inserts, so the dashboard will dynamically show annotations are they are being created. We will first build a View in BigQuery that will filter the specific fields that we want in our dashboard. We will use a SQL statement provided in the segmentations.sql file under the "medical-imaging-labs/BiqQuery" folder.
2. In the Jupyer view, select the folder icon, navigate to "medical-imaging-labs/BiqQuery" and open segmentations.sql
3. Select all the content of the file and copy to the clipboard. 
4. In the Cloud Console Big Query workspace, select the LCTSC_cohort1 under the idc_dataset_views dataset and select "Query"
5. In the Query Editor, delete the sample SELECT statement, and in a clean Query paste the contents of the clipboard (contents of the segmentations.sql file)
6. The syntax checker will inform that there is a line that needs fixing:`PROJECT_NAME.DATASET_NAME.TABLE_NAME`. Enter substitute PROJECT_NAME with your project's name, substitute DATASET_NAME with idc_dataset_views and substitute TABLE_NAME with LCTSC_cohort1. This should fix all the syntax errors.
7. Execute the Query selecting "RUN"
8. Select "Save", select "View", enter idc_dataset_views for dataset name andv "cohort1_segmentations" as Table name. You now have a table that will show the segmentations of the LCTSC_cohort1 table. In the next step we will build a dashboard on top of this view so we can monitor the creation of new dashboards.

## Build a custom dashboard to monitor when segmentations are created
1. Select the view "cohort1_segmentations" created in the previous task.
2. select "Export" , select "Export to Looker Studio"
3. In Looker Studio, delete the automatically created tables by clickig no the three button icon and then "delete"
4. drag the field "StudyInstanceID" to the canvas to create a new table
5. Drag the field "Segment Labels" to the same table
6. Select the new table and locate the "Dimensions" list under the "Chart" control. It will show the two fields that were just added. See the figure below to help in locating the Dimensions list. 
7. Click on "Create Dimension", click on "Create Field", enter the field name "ohif_url"
8. Enter the following formula for the field: CONCAT("http://localhost:8002/ohif/viewer/",StudyInstanceUID)
9. Click on Save to save the dashboard. You should have a dashboard that looks like the figure below:
![DICOM Dashboard 2](img/segmentations_dashboard.png)

## Verify that the new segmentations are streamed to the dashboard and inspect annotations with OHIF
1. We now want to use the dashboard created in the previous step to inspect the new annotations using OHIF. In the previous step, we included a field that builds a URL using the MONAILabel OHIF endpoint "http://localhost:8002/ohif/viewer/" followed by the StudiyInstanceID -- this is the convention used in OHIF and is based on the DICOMWeb standard. However, the "localhost" hostname will only work on the same machine that is running the MONAILabel server. For this reason, we will use the desktop view in the tab "noVNC" to start a Chrome browser, login as the QuickLab user and then access the Looker Studio Dashboard. Switch to the **noVNC** tab
2. In the applicatio launcher click on the "Earth" icon to bring up Chrome
3. In the address bar, type "lookerstudio.google.com"
4. You will be required to sign into your gmail account. Provide the Quicklab user ID and password used in this lab.
5. You are now logged into Chrome and should see your Looker Studio Dashboards. Select the Dashboard that was created in the last Task.
6. Ensure that you are in view mode (the view button will show "Edit" when it is in View mode)
7. You can now click on the URL column to select any particular study to visualize with OHIF. Here we are using the embedded OHIF viewer in the MONAILabel server, which has no authentication capability. However the server is only accessible from localhost, so it is secure. In a real production scenario the OHIF viewer would be deployed in its own server, such as using GCP AppEngine. The production version of OHIF is integrated with the GCP framework, and therefore the access to the server can be controlled. The production deployment of the OHIF server is covered in another QuickLab. 