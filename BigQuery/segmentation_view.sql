(
 WITH
  segs AS (
  SELECT
    PatientID,
    SOPInstanceUID,
    StudyInstanceUID,
    FrameOfReferenceUID,
    SegmentSequence
  FROM
    `PROJECT_NAME.DATASET_NAME.TABLE_NAME`
  WHERE
    # more reliable than Modality = "SEG"
    SOPClassUID = "1.2.840.10008.5.1.4.1.1.66.4" )
SELECT
  PatientID,
  SOPInstanceUID,
  StudyInstanceUID,
  FrameOfReferenceUID,
 
 
  #unnested.SegmentedPropertyTypeCodeSequence,
  #unnested.SegmentedPropertyTypeModifierCodeSequence,
  unnested.SegmentAlgorithmType,
  unnested.SegmentNumber,
  unnested.SegmentLabel,
  unnested.SegmentDescription,
  unnested.SegmentAlgorithmName
 # unnested.TrackingUID,
#  unnested.TrackingID
FROM
  segs
CROSS JOIN
  UNNEST(SegmentSequence) AS unnested 
)