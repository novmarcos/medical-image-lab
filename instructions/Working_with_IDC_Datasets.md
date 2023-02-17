## Exploring the Image Data Commons Datasets **
https://portal.imaging.datacommons.cancer.gov/

## Adding the Image Data Commons (IDC) Datasets to your Big Query Workspace
1. Make sure you are signed in the browser with the same ID you use for the Cloud Console. Then navigate to the link below
https://console.cloud.google.com/bigquery?project=bigquery-public-data&page=project
2. The browser will navigate to the BigQuery Public Datasets page. 
3. Select the star icon next to the bigquery-public-datasets dataset
4. Now change the active project in the Project pulldown menu at the top and select your quicklab project
5. You now should see the bigquery-public-datasets added to your project

## Copy the dicom_all View of the idc_current dataset to your project's workspace
1. Scroll down the biquery-public-data datasets to find datasets starting with "idc"
2. You will have to select "More Results" at the bottom to get to the letter "i"
3. expand the idc_current dataset
4. Select the dicom_all View
5. In the main SQL Workspace page, select "Copy"
6. In the Copy Dialog, change the project name, select your quicklab project
7. In the Dataset field, select "Create New Dataset"
8. In the New Dataset Dialog, enter the name: "idc_dataset_views"
9. In the Data Location field, select "us"
10. Click the "Create" button
11. You are now back in the Copy dialog. In the table name field enter "idc_current_dicom_all_view"
12. Click copy

## Copy the Segmentation view of the idc_v9 dataset
The segmentation View of provides the SQL code needed to extract the segmentations from the dicom_all table. It is interesting to browse the SQL code in such views as this code can be leveraged to build custom views later in the lab. The views in the "idc_current" folder do not have this code, so we will inspect the code of the idc version 9 dataset.
1. Scroll down the biquery-public-data datasets to find datasets starting with "idc"
2. You will have to select "Show More" at the bottom to get to the letter "i"
3. expand the idc_v9 dataset
4. Select the segmentation View
5. In the main SQL Workspace page, select "Copy"
6. In the Copy Dialog, change the project name, select your quicklab project
7. In the Dataset field, select the dataset previously created, "idc_dataset_views"
8. In the table name field enter "idc_v9_segmentation_view"
9. Click copy

## Inspect the Views just copied
1. In the BigQuery Workspace, scrol back to the top and expand your project name
2. You now have a new dataset, "idc_dataset_views", expand it
3. You can now see the two Views just copied.
4. Select the idc_current_dicom_all_view, and select "Details" in the main page
5. Inspect the SQL statement for that view, it is a simple Select from the v12 Table
6. Select the idc_v9_segmentation_view, and select "Details" to access the SQL code that defines the View
7. Inspect the SQL statement for the View. This a good example on how to extract segmentation records from the dicom view.

## Build a Custom Dashboard to Browse the Views just copied
1. In your project's Big Query Workspace, select the idc_current_dicom_all_view 
2. Select "Export" button in the upper right, select "Explore with Looker Studio"
3. In Looker Studio you will a couple example charts and the Data selection tool on the left. You can use the Data Selection tool to find fields and then you can drag and drop them into the canvas.
4. Using the Data Search bar, Find the "StudyInstanceUID" field and drag it to an empty space in the canvas, creating a new table view
5. Using the Data Search bar, Find the "gcs_url" field and drag it to same table, this will add a column to the table
6. Add an Advanced filter, select "StudyInstanceUID" for the filter field
7. Resize the columns and you should have a dashboard as shown below:
![DICOM Dashboard 1](img/dicom_dashboard1.png)
7. Now click on the "Save" button to save the layout
8. You are now in View Mode. Use the mouse to select and copy a specific ID in the "StudyInstanceUID"
9. Paste the copied ID in the filter. After a few seconds, the table you oly show records that specific StudyInstanceUID. You will notice that there are few hundred dcm files in the gcs_url column. These are the files that are part of that specific StudyInstanceUID, basically all the files that are needed to put together the DICOM record for that study. In a further exercise, we will build a SQL statement that selects the DICOM files according to their unique "StudyInstanceUID" so tha they can uploaded to the DICOM store. We will then make these files available to viewers and to the MONAILabel application using the DICOMWeb interface.

