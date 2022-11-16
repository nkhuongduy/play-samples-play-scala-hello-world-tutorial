# --- !Ups
CREATE TABLE IF NOT EXISTS DIM_SitePoint (
    sitePointId 	INT PRIMARY KEY AUTO_INCREMENT,
    siteId 			INT,
    siteTermStart	MEDIUMINT,
    siteTermEnd		MEDIUMINT,
    path			VARCHAR(255),
    userPermission	BOOLEAN,
    asAnonymous		BOOLEAN,
    equityShare		DECIMAL,
    revisions		VARCHAR(255),
    pathChange		BOOLEAN
);

CREATE TABLE IF NOT EXISTS DIM_TagPoint (
    tagPointId 		INT PRIMARY KEY AUTO_INCREMENT,
    tagId			INT,
    unRestricted	BOOLEAN,
    sitesRestricted	JSON,
    fullSiteList	JSON
);

CREATE TABLE IF NOT EXISTS DIM_TimeTerm (
	termId			INT PRIMARY KEY AUTO_INCREMENT,
    timeTermStart	MEDIUMINT,
    timeTermEnd		MEDIUMINT,
    shiftedTermStart MEDIUMINT,
    shiftedTermEnd	MEDIUMINT,
    termDay			INT,
    cycle			INT
);

CREATE TABLE IF NOT EXISTS DIM_Dimension (
	dimensionId		INT PRIMARY KEY AUTO_INCREMENT,
	unitId			INT,
    referenceUnitId	INT,
    scope			INT,
    impactId		INT,
    impactFactorTerm INT,
    getCost			BOOLEAN,
    customFieldId	INT,
    calculatedCustomField JSON,
    filterCustomFields JSON
);

CREATE TABLE IF NOT EXISTS DIM_Position (
	positionPointId		INT PRIMARY KEY AUTO_INCREMENT,
	positionId			INT,
    positionType		INT,
    positionPath		JSON,
    positionTermStart	MEDIUMINT,
    positionTermEnd		MEDIUMINT,
    applyOverSite		BOOLEAN,
    applyOverTime		BOOLEAN,
    directStaticConversions	JSON,
    indirectStaticConversions JSON,
    referenceUnit		INT
);

CREATE TABLE IF NOT EXISTS DIM_HighFrequencyTerm (
	highFrequencyId	INT PRIMARY KEY AUTO_INCREMENT,
    hour			MEDIUMINT,
    intervalValue	MEDIUMINT,
    typeIntraDaily	VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS FACT_CalculatedValues (
	hashKey	VARCHAR(255) PRIMARY KEY,
    sitePointId	INT REFERENCES sofi_datamart.DIM_SitePoint(sitePointId),
    tagPointId	INT REFERENCES sofi_datamart.DIM_TagPoint(tagPointId),
    positionPointId	INT REFERENCES sofi_datamart.DIM_Position(positionPointId),
    dimensionId	INT REFERENCES sofi_datamart.DIM_Dimension(dimensionId),
    termId	INT REFERENCES sofi_datamart.DIM_TimeTerm(termId),
    highFrequencyId	INT REFERENCES sofi_datamart.DIM_HighFrequencyTerm(highFrequencyId),
    timeRange	VARCHAR(20),
    overSite	BOOLEAN,
    ignoreUserPermission	BOOLEAN,
    calculatedValue	VARCHAR(255),
    calculatedValueType	VARCHAR(10)
);

# --- !Downs
DROP TABLE DIM_SitePoint;
DROP TABLE DIM_TagPoint;
DROP TABLE DIM_TimeTerm;
DROP TABLE DIM_Dimension;
DROP TABLE DIM_Position;
DROP TABLE DIM_HighFrequencyTerm;
DROP TABLE FACT_CalculatedValues;
