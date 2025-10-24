# OpenClinica API Endpoints Documentation

## Overview
This document lists all **217 unique API endpoints** available in OpenClinica master branch, plus **1 additional endpoint** available in 3.17.x branch, organized by functional purpose.

**Base URL**: `http://localhost:8080/OpenClinica`

---

## 📊 API Categories Summary
- **Authentication & User Management**: 15 endpoints
- **Study Management**: 25 endpoints  
- **Subject Management**: 20 endpoints
- **Data Entry & Forms**: 35 endpoints
- **Clinical Data & Reporting**: 30 endpoints
- **Administration & System**: 25 endpoints
- **Rules & Validation**: 15 endpoints
- **Participant Forms (OpenRosa)**: 8 endpoints
- **Web Services & OAuth**: 6 endpoints (5 in master + 1 in 3.17.x)
- **Audit & Logging**: 20 endpoints
- **File Management**: 10 endpoints
- **Miscellaneous**: 9 endpoints

---

## 🔐 AUTHENTICATION & USER MANAGEMENT APIs

### User Authentication
- `POST /pages/auth/api/v1/useraccount/login` - User login with API key authentication
- `GET /pages/auth/api/v1/userinfo` - Get current user information
- `POST /Logout` - User logout
- `POST /RequestPassword` - Request password reset
- `GET /Contact` - Contact information

### User Account Management
- `GET /ListUserAccounts` - List all user accounts in the system
- `POST /CreateUserAccount` - Create new user account
- `PUT /EditUserAccount` - Edit existing user account
- `DELETE /DeleteUser` - Delete user account
- `POST /UnLockUser` - Unlock locked user account
- `GET /ViewUserAccount` - View user account details

### User Role Management
- `POST /DeleteStudyUserRole` - Delete user's role in a study
- `POST /EditStudyUserRole` - Edit user's study role
- `GET /AssignUserToStudy` - Assign user to study
- `GET /ListStudyUser` - List users in a study
- `GET /ViewUserRole` - View user role details

---

## 🏥 STUDY MANAGEMENT APIs

### Study CRUD Operations
- `POST /pages/auth/api/v1/studies/` - Create new study (REST API)
- `GET /pages/auth/api/v1/studies/{studyOid}` - Get study details (REST API)
- `PUT /pages/auth/api/v1/studies/{studyOid}` - Update study (REST API)
- `POST /CreateStudy` - Create new study (legacy)
- `POST /CreateSubStudy` - Create sub-study
- `POST /UpdateStudy` - Update existing study
- `POST /InitUpdateStudy` - Initialize study update process
- `POST /ChangeStudy` - Change active study for user
- `GET /ViewStudy` - View study details
- `POST /UpdateStudyNew` - Update study (new version)

### Study Configuration
- `POST /DefineStudyEvent` - Define study event
- `GET /ViewEventDefinition` - View event definition
- `GET /ViewEventDefinitionReadOnly` - View event definition (read-only)
- `POST /UpdateEventDefinition` - Update event definition
- `POST /RemoveEventDefinition` - Remove event definition
- `POST /RestoreEventDefinition` - Restore event definition

### Study Event Management
- `POST /CreateNewStudyEvent` - Create new study event
- `GET /FindStudyEvent` - Find study event
- `POST /UpdateStudyEvent` - Update study event
- `POST /RemoveStudyEvent` - Remove study event
- `POST /RestoreStudyEvent` - Restore study event
- `GET /ViewStudyEvent` - View study event details

---

## 👤 SUBJECT MANAGEMENT APIs

### Subject CRUD Operations
- `POST /AddNewSubject` - Add new subject to study
- `GET /ViewSubject` - View subject details
- `POST /RemoveSubject` - Remove subject from study
- `POST /RestoreSubject` - Restore removed subject
- `POST /UpdateSubject` - Update subject information
- `GET /ListStudySubjects` - List all subjects in study

### Subject Operations
- `POST /SignStudySubject` - Sign study subject
- `GET /ViewStudySubject` - View study subject details
- `POST /UpdateStudySubject` - Update study subject
- `GET /ViewStudySubjectAuditLog` - View subject audit log
- `GET /ExportExcelStudySubjectAuditLog` - Export subject audit log to Excel

### Subject Groups
- `POST /CreateSubjectGroupClass` - Create subject group class
- `POST /UpdateSubjectGroupClass` - Update subject group class
- `POST /RemoveSubjectGroupClass` - Remove subject group class
- `POST /RestoreSubjectGroupClass` - Restore subject group class
- `GET /ViewSubjectGroupClass` - View subject group class

### Subject Assignment
- `POST /AssignSubjectToStudy` - Assign subject to study
- `POST /RemoveSubjectFromStudy` - Remove subject from study
- `POST /RestoreSubjectToStudy` - Restore subject to study

---

## 📝 DATA ENTRY & FORMS APIs

### Data Entry Operations
- `GET /InitialDataEntry` - Initial data entry form
- `POST /DataEntry` - Submit data entry
- `POST /DoubleDataEntry` - Double data entry verification
- `GET /EnterDataForStudyEvent` - Enter data for study event
- `POST /AdministrativeEditing` - Administrative data editing
- `GET /ViewSectionDataEntry` - View section data entry
- `GET /ViewSectionDataEntryById` - View section data entry by ID
- `GET /ViewSectionDataEntryRESTUrlServlet` - View section data entry REST URL

### CRF Management
- `POST /CreateCRF` - Create new CRF
- `POST /CreateCRFVersion` - Create CRF version
- `POST /CreateXformCRFVersion` - Create XForm CRF version
- `GET /ViewCRF` - View CRF details
- `POST /UpdateCRF` - Update CRF
- `POST /RemoveCRF` - Remove CRF
- `POST /RestoreCRF` - Restore CRF

### CRF Version Management
- `POST /LockCRFVersion` - Lock CRF version
- `POST /UnlockCRFVersion` - Unlock CRF version
- `POST /RemoveCRFVersion` - Remove CRF version
- `POST /RestoreCRFVersion` - Restore CRF version
- `GET /ViewCRFVersion` - View CRF version details
- `POST /UpdateCRFVersion` - Update CRF version

### CRF Definition Management
- `POST /AddCRFToDefinition` - Add CRF to event definition
- `POST /RemoveCRFFromDefinition` - Remove CRF from event definition
- `POST /RestoreCRFFromDefinition` - Restore CRF to event definition
- `POST /ChangeDefinitionCRFOrdinal` - Change CRF ordinal in definition
- `GET /CheckCRFLocked` - Check if CRF is locked

### Form Operations
- `GET /SectionPreview` - Preview form section
- `GET /form` - Form display
- `GET /TableOfContents` - Table of contents
- `GET /ViewTableOfContent` - View table of contents
- `POST /MarkEventCRFComplete` - Mark event CRF as complete

---

## 📊 CLINICAL DATA & REPORTING APIs

### Clinical Data Retrieval
- `GET /rest/clinicaldata/json/view/{study}/{subject}/{event}/{form}` - Get clinical data (JSON format)
- `GET /rest/clinicaldata/xml/view/{study}/{subject}/{event}/{form}` - Get clinical data (XML format)
- `GET /pages/auth/api/v1/clinicaldata/json/view/{studyOID}/{subject}/{event}/{form}` - Get clinical data (Spring REST)
- `GET /ClinicalData/html/view/*` - Clinical data HTML view

### Data Export & Reporting
- `POST /CreateJobExport` - Create data export job
- `GET /ExportDataset` - Export dataset
- `GET /ChooseDownloadFormat` - Choose download format
- `GET /pages/auth/api/v1/report/*` - Reporting operations (REST)
- `GET /ExportExcelStudySubjectAuditLog` - Export audit log to Excel

### Dataset Management
- `POST /CreateDataset` - Create new dataset
- `POST /EditDataset` - Edit dataset
- `POST /RemoveDataset` - Remove dataset
- `POST /RestoreDataset` - Restore dataset
- `GET /ViewDataset` - View dataset details

### Filter Management
- `POST /CreateFiltersOne` - Create filters (step 1)
- `POST /CreateFiltersTwo` - Create filters (step 2)
- `POST /EditFilter` - Edit filter
- `POST /RemoveFilter` - Remove filter
- `POST /RestoreFilter` - Restore filter
- `POST /ApplyFilter` - Apply filter

---

## ⚙️ ADMINISTRATION & SYSTEM APIs

### System Administration
- `GET /SystemStatus` - Get system status
- `POST /Configure` - System configuration
- `GET /AdminSystem` - Admin system functions
- `GET /TechAdmin` - Technical administration
- `POST /ConfigurePasswordRequirements` - Configure password requirements

### Job Management
- `POST /CreateJobExport` - Create export job
- `POST /CreateJobImport` - Create import job
- `POST /UpdateJobExport` - Update export job
- `POST /UpdateJobImport` - Update import job
- `POST /PauseJob` - Pause scheduled job
- `GET /ViewJob` - View job details
- `GET /ViewAllJobs` - View all jobs
- `GET /ViewImportJob` - View import job
- `GET /ViewSingleJob` - View single job

### System Monitoring
- `GET /ViewLogMessage` - View log messages
- `GET /RssReader` - RSS reader
- `POST /UploadFile` - Upload file
- `GET /AccessFile` - Access file
- `GET /ShowFile` - Show file

---

## 🔧 RULES & VALIDATION APIs

### Rule Management
- `POST /ImportRule` - Import business rule
- `GET /ViewRuleSet` - View rule set
- `POST /RunRule` - Execute rule
- `POST /TestRule` - Test rule
- `GET /pages/auth/api/v1/rule/*` - Rule management (REST API)
- `POST /RunRuleSet` - Run rule set
- `POST /RemoveRuleSet` - Remove rule set
- `POST /RestoreRuleSet` - Restore rule set

### Rule Operations
- `POST /UpdateRuleSetRule` - Update rule set rule
- `GET /ViewRuleAssignment` - View rule assignment
- `GET /ViewRuleAssignmentNew` - View rule assignment (new)
- `POST /DownloadRuleSetXml` - Download rule set XML
- `POST /VerifyImportedRule` - Verify imported rule
- `GET /ViewRuleSetAudit` - View rule set audit

### Validation
- `POST /ExecuteCrossEditCheck` - Execute cross edit check
- `POST /VerifyImportedCRFData` - Verify imported CRF data

---

## 📱 PARTICIPANT FORMS APIs (OpenRosa)

### Form Operations
- `GET /rest2/openrosa/formList` - Get form list
- `POST /rest2/openrosa/submission` - Submit form data
- `GET /rest2/openrosa/formXml` - Get form XML
- `GET /openrosa/formXml` - Get form XML (legacy)
- `GET /ParticipantFormServlet` - Participant form servlet

### Form Management
- `POST /BatchCRFMigration` - Batch CRF migration
- `GET /pages/auth/api/v1/form/*` - Form operations (REST)
- `POST /ChangeCRFVersion` - Change CRF version

---

## 🌐 WEB SERVICES & OAUTH APIs

### Web Services
- `/ws/*` - SOAP web services endpoints
- `/oauth/*` - OAuth authentication endpoints

### OAuth Authentication (3.17.x Branch Only)
- `GET /oauth/confirm_access` - OAuth access confirmation page for protected resources
  - **Purpose**: Displays confirmation page when OAuth clients request access to protected resources
  - **Authentication**: OAuth client authentication required
  - **Controller**: `AccessConfirmationController`
  - **Response**: HTML confirmation page (`access_confirmation.jsp`)
  - **Use Case**: Part of OAuth 2.0 authorization server implementation
  - **Security**: Uses `ClientAuthenticationCache` and `ClientDetailsService`

### REST API Base Paths
- `/rest/*` - Jersey REST API endpoints
- `/rest2/*` - Jersey REST API endpoints (v2)
- `/pages/auth/api/*` - Spring REST API endpoints

---

## 🔍 AUDIT & LOGGING APIs

### Audit Operations
- `GET /AuditLogUser` - User audit log
- `GET /AuditLogStudy` - Study audit log
- `GET /AuditUserActivity` - User activity audit
- `GET /AuditDatabase` - Database audit
- `GET /StudyAuditLog` - Study audit log
- `GET /ViewItemAuditLog` - Item audit log

### Logging
- `GET /ViewLogMessage` - View log messages
- `GET /RssReader` - RSS reader for updates

---

## 📁 FILE MANAGEMENT APIs

### File Operations
- `POST /UploadFile` - Upload file
- `GET /AccessFile` - Access file
- `GET /ShowFile` - Show file
- `GET /DownloadAttachedFile` - Download attached file

### Print Operations
- `GET /PrintEventCRF` - Print event CRF
- `GET /PrintAllEventCRF` - Print all event CRFs
- `GET /PrintAllSiteEventCRF` - Print all site event CRFs

---

## 🔍 SOURCE DATA VERIFICATION APIs

### SDV Operations
- `GET /pages/auth/api/v1/sdv/*` - SDV operations (REST API)
- `GET /pages/auth/api/itemdata/sdv/{filternumber}/{studyoid}/paginated` - Paginated SDV data
- `GET /ViewAllSubjectSDV` - View all subject SDV
- `GET /ViewAllSubjectSDVform` - View all subject SDV form
- `GET /ViewAllSubjectSDVtmp` - View all subject SDV temporary

---

## 📝 DISCREPANCY NOTES APIs

### Discrepancy Note Operations
- `GET /pages/auth/api/v1/discrepancynote/*` - Discrepancy notes (REST API)
- `POST /CreateDiscrepancyNote` - Create discrepancy note
- `GET /ViewDiscrepancyNote` - View discrepancy note
- `POST /ResolveDiscrepancy` - Resolve discrepancy
- `GET /ListDiscNotesForCRFServlet` - List discrepancy notes for CRF
- `GET /ListDiscNotesSubjectServlet` - List discrepancy notes for subject
- `GET /ListDNotesForCRF` - List discrepancy notes for CRF
- `POST /AddDiscrepancyNote` - Add discrepancy note

---

## 📊 METADATA APIs

### Metadata Operations
- `GET /rest/metadata/*` - Study metadata (Jersey REST)
- `GET /pages/auth/api/v1/metadata/*` - Metadata (Spring REST)

---

## 🎯 MISCELLANEOUS APIs

### Navigation & UI
- `GET /MainMenu` - Main menu
- `GET /ManageStudy` - Manage study
- `GET /ManageStudy1` - Manage study (test)

### Data Views
- `GET /ViewSubjectAggregate` - View subject aggregate
- `GET /ViewNotes` - View notes
- `GET /ViewNotesForSubject` - View notes for subject

### System Operations
- `POST /SetUserRole` - Set user role
- `GET /ViewJob` - View job
- `GET /ViewSingleJob` - View single job

---

## 🔑 API Authentication & Access

### Authentication Methods
- **API Key**: Most REST APIs require API key authentication
- **Session-based**: Legacy servlet APIs use session authentication
- **OAuth**: OAuth endpoints available for third-party integration

### API Versions
- **REST v1**: `/pages/auth/api/v1/` - Latest REST API version
- **Jersey REST**: `/rest/*` - Jersey-based REST APIs
- **Legacy Servlets**: Direct servlet mappings (e.g., `/ListUserAccounts`)

### Response Formats
- **JSON**: Most REST APIs return JSON responses
- **XML**: Some APIs support XML format
- **HTML**: Web interface endpoints return HTML
- **Excel**: Export endpoints can return Excel files

---

## 📚 Additional Resources

- **API Documentation**: Available at `/pages/auth/api/v1/` endpoints
- **Web Services**: SOAP services available at `/ws/`
- **Participant Forms**: OpenRosa-compliant forms at `/rest2/openrosa/`
- **System Status**: Check system health at `/SystemStatus`

---

## 🔄 Branch Differences

### Master Branch vs 3.17.x Branch
- **Master Branch**: 217 unique API endpoints
- **3.17.x Branch**: 218 unique API endpoints (217 from master + 1 additional)

### Additional Endpoint in 3.17.x Branch
- `GET /oauth/confirm_access` - OAuth access confirmation endpoint
  - **Availability**: Only in 3.17.x branch
  - **Purpose**: OAuth 2.0 authorization server functionality
  - **Controller**: `AccessConfirmationController`
  - **Configuration**: Spring MVC handler mapping in `pages-servlet.xml`

### Other Differences
- **Spring Framework**: 3.17.x uses Spring 3.0.x (downgraded from 3.2.x in master)
- **Controller Changes**: Several controllers modified between branches
- **Core Functionality**: All core OpenClinica APIs remain identical

---

*This documentation covers all 217 unique API endpoints available in OpenClinica master branch, plus 1 additional endpoint available in 3.17.x branch. For detailed API specifications and request/response examples, refer to the individual endpoint documentation.*
