(
            # TODO:
# * account for SCT codes in addition to SRT
# * add Anatomic Region Modifier
# Debug:
#WITH
#  segs_details AS (
WITH
  segs AS (
  SELECT
    PatientID,
    SOPInstanceUID,
    StudyInstanceUID,
    FrameOfReferenceUID,
    SegmentSequence
  FROM
    `medical-imaging-ai.cohorts.LCTSC-dicom`
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
  UNNEST(SegmentSequence) AS unnested # correctness check: there should be 4 segmented nodules for this subject
  #where PatientID = "LIDC-IDRI-0001"
  # Note that it is possible to have some of those sequences empty!
  # Debug:
  #WHERE
  #  ARRAY_LENGTH(unnested.AnatomicRegionSequence) = 0
  # Debug:
  #    )
#SELECT
#  DISTINCT SegmentedPropertyTypeCodeSequence[
#OFFSET
#  (0)].CodeMeaning
#FROM
#  segs_details
#WHERE
#  ARRAY_LENGTH(SegmentedPropertyTypeCodeSequence) <> 0

        )