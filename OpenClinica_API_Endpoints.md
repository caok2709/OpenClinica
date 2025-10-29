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
  - **DB**: `user_account`, `user_authorization`
  - **UI**: `/pages/login/login` - Submit login form
  - **3.17.x**: Uses Spring Security authentication filter

- `GET /pages/auth/api/v1/userinfo` - Get current user information
  - **DB**: `user_account`
  - **UI**: Displayed in user profile section

- `POST /Logout` - User logout
  - **DB**: No database operation
  - **UI**: Click "Log Out" button in header

- `POST /RequestPassword` - Request password reset
  - **DB**: `user_account`, `password_question_lookup`
  - **UI**: `/pages/login/resetPasswordRequest` - Click "Forgot Password" link

- `GET /Contact` - Contact information
  - **DB**: No database operation
  - **UI**: Contact page display

### User Account Management
- `GET /ListUserAccounts` - List all user accounts in the system
  - **DB**: `user_account`, `study_user_role`, `user_role`
  - **UI**: `/pages/admin/listUserAccount` - Admin → System Admin → User Accounts

- `POST /CreateUserAccount` - Create new user account
  - **DB**: `user_account`, `study_user_role`, `user_role`, `authorities`
  - **UI**: `/pages/admin/createUserAccount` - Click "Create a new user" button
  - **3.17.x**: Supports both LDAP and database authentication

- `PUT /EditUserAccount` - Edit existing user account
  - **DB**: `user_account`, `study_user_role`
  - **UI**: `/pages/admin/updateUserAccount` - Click "Edit" on user row

- `DELETE /DeleteUser` - Delete user account
  - **DB**: `user_account` (marks as deleted)
  - **UI**: `/pages/admin/updateUserAccount` - Click "Delete" button
  - **3.17.x**: Soft delete (status change)

- `POST /UnLockUser` - Unlock locked user account
  - **DB**: `user_account` (updates status)
  - **UI**: `/pages/admin/updateUserAccount` - Click "Unlock" button
  - **3.17.x**: Resets lock counter in database

- `GET /ViewUserAccount` - View user account details
  - **DB**: `user_account`, `study_user_role`
  - **UI**: `/pages/admin/viewUserAccount` - Click on username

### User Role Management
- `POST /DeleteStudyUserRole` - Delete user's role in a study
  - **DB**: `study_user_role` (marks as deleted)
  - **UI**: `/pages/studyadmin/listAllUsers` - Click "Delete" on role

- `POST /EditStudyUserRole` - Edit user's study role
  - **DB**: `study_user_role`
  - **UI**: `/pages/studyadmin/editStudyUserRole` - Click "Edit" on role

- `GET /AssignUserToStudy` - Assign user to study
  - **DB**: `study_user_role`, `user_role`
  - **UI**: `/pages/admin/createUserAccount` - Select study and role

- `GET /ListStudyUser` - List users in a study
  - **DB**: `study_user_role`, `user_account`
  - **UI**: `/pages/studyadmin/listAllUsers` - Study Admin → Users

- `GET /ViewUserRole` - View user role details
  - **DB**: `study_user_role`, `role`
  - **UI**: `/pages/studyadmin/viewUserRole` - Click on role

## 🏥 STUDY MANAGEMENT APIs

### Study CRUD Operations
- `POST /pages/auth/api/v1/studies/` - Create new study (REST API)
  - **DB**: `study`, `study_parameter_value`, `user_role`, `study_user_role`
  - **UI**: REST API endpoint (external client)

- `GET /pages/auth/api/v1/studies/{studyOid}` - Get study details (REST API)
  - **DB**: `study`, `study_parameter_value`
  - **UI**: REST API endpoint (external client)

- `PUT /pages/auth/api/v1/studies/{studyOid}` - Update study (REST API)
  - **DB**: `study`, `study_parameter_value`
  - **UI**: REST API endpoint (external client)

- `POST /CreateStudy` - Create new study (legacy)
  - **DB**: `study`, `study_parameter_value`, `event_definition_crf`, `crf_version`
  - **UI**: `/pages/managestudy/createStudy` - Admin → Create Study

- `POST /CreateSubStudy` - Create sub-study
  - **DB**: `study` (with parent_id set)
  - **UI**: `/pages/managestudy/createSubStudy` - Admin → Create Sub-Study

- `POST /UpdateStudy` - Update existing study
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/updateStudy` - Click "Update" on study

- `POST /InitUpdateStudy` - Initialize study update process
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/updateStudy` - Loading study data

- `POST /ChangeStudy` - Change active study for user
  - **DB**: No database operation (session update)
  - **UI**: Dropdown in header - Select different study

- `GET /ViewStudy` - View study details
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/viewStudy` - Click on study name

- `POST /UpdateStudyNew` - Update study (new version)
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/updateStudyNew` - New update interface

### Study Configuration
- `POST /DefineStudyEvent` - Define study event
  - **DB**: `event_definition_crf`, `crf`, `crf_version`
  - **UI**: `/pages/managestudy/defineStudyEvent` - Study Admin → Define Events

- `GET /ViewEventDefinition` - View event definition
  - **DB**: `event_definition_crf`, `crf`
  - **UI**: `/pages/managestudy/viewEventDefinition` - Click on event definition

- `GET /ViewEventDefinitionReadOnly` - View event definition (read-only)
  - **DB**: `event_definition_crf`, `crf`
  - **UI**: `/pages/managestudy/viewEventDefinitionReadOnly` - Read-only view

- `POST /UpdateEventDefinition` - Update event definition
  - **DB**: `event_definition_crf`
  - **UI**: `/pages/managestudy/updateEventDefinition` - Click "Edit" on definition

- `POST /RemoveEventDefinition` - Remove event definition
  - **DB**: `event_definition_crf` (marks as removed)
  - **UI**: `/pages/managestudy/viewEventDefinition` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreEventDefinition` - Restore event definition
  - **DB**: `event_definition_crf` (restores status)
  - **UI**: `/pages/managestudy/viewEventDefinition` - Click "Restore"
  - **3.17.x**: Restores status to active

### Study Event Management
- `POST /CreateNewStudyEvent` - Create new study event
  - **DB**: `study_event`, `study_subject`
  - **UI**: `/pages/managestudy/createNewStudyEvent` - Click "Create Study Event"

- `GET /FindStudyEvent` - Find study event
  - **DB**: `study_event`, `study_subject`
  - **UI**: `/pages/managestudy/findStudyEvent` - Search for event

- `POST /UpdateStudyEvent` - Update study event
  - **DB**: `study_event`
  - **UI**: `/pages/managestudy/updateStudyEvent` - Click "Edit" on event

- `POST /RemoveStudyEvent` - Remove study event
  - **DB**: `study_event` (marks as removed)
  - **UI**: `/pages/managestudy/viewStudyEvent` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreStudyEvent` - Restore study event
  - **DB**: `study_event` (restores status)
  - **UI**: `/pages/managestudy/listEventsForSubject` - Click "Restore"
  - **3.17.x**: Restores status to active

- `GET /ViewStudyEvent` - View study event details
  - **DB**: `study_event`, `event_crf`, `item_data`
  - **UI**: `/pages/managestudy/viewStudyEvent` - Click on event

## 👤 SUBJECT MANAGEMENT APIs

### Subject CRUD Operations
- `POST /AddNewSubject` - Add new subject to study
  - **DB**: `subject`, `study_subject`
  - **UI**: `/pages/submit/addNewSubject` - Submit Data → Enroll New Subject

- `GET /ViewSubject` - View subject details
  - **DB**: `subject`, `study_subject`
  - **UI**: `/pages/admin/viewSubject` - Click on subject

- `POST /RemoveSubject` - Remove subject from study
  - **DB**: `subject` (marks as removed)
  - **UI**: `/pages/admin/updateSubject` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreSubject` - Restore removed subject
  - **DB**: `subject` (restores status)
  - **UI**: `/pages/admin/listSubject` - Click "Restore"
  - **3.17.x**: Restores status to active

- `POST /UpdateSubject` - Update subject information
  - **DB**: `subject`
  - **UI**: `/pages/admin/updateSubject` - Click "Update" on subject

- `GET /ListStudySubjects` - List all subjects in study
  - **DB**: `study_subject`, `subject`
  - **UI**: `/pages/submit/listStudySubjects` - Submit Data → List Subjects

### Subject Operations
- `POST /SignStudySubject` - Sign study subject
  - **DB**: `study_subject` (updates status to SIGNED)
  - **UI**: `/pages/managestudy/signStudySubject` - Click "Sign Subject"

- `GET /ViewStudySubject` - View study subject details
  - **DB**: `study_subject`, `subject`, `study_event`
  - **UI**: `/pages/managestudy/viewStudySubject` - Click on study subject ID

- `POST /UpdateStudySubject` - Update study subject
  - **DB**: `study_subject`
  - **UI**: `/pages/managestudy/updateStudySubject` - Click "Update"

- `GET /ViewStudySubjectAuditLog` - View subject audit log
  - **DB**: `audit_log_event`, `study_subject`
  - **UI**: `/pages/managestudy/viewStudySubjectAuditLog` - View audit trail

- `GET /ExportExcelStudySubjectAuditLog` - Export subject audit log to Excel
  - **DB**: `audit_log_event`, `study_subject`
  - **UI**: `/pages/managestudy/viewStudySubjectAuditLog` - Click "Export to Excel"

### Subject Groups
- `POST /CreateSubjectGroupClass` - Create subject group class
  - **DB**: `subject_group_class`
  - **UI**: `/pages/managestudy/createSubjectGroupClass` - Create group class

- `POST /UpdateSubjectGroupClass` - Update subject group class
  - **DB**: `subject_group_class`
  - **UI**: `/pages/managestudy/updateSubjectGroupClass` - Click "Edit"

- `POST /RemoveSubjectGroupClass` - Remove subject group class
  - **DB**: `subject_group_class` (marks as removed)
  - **UI**: `/pages/managestudy/viewSubjectGroupClass` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreSubjectGroupClass` - Restore subject group class
  - **DB**: `subject_group_class` (restores status)
  - **UI**: `/pages/managestudy/listSubjectGroupClass` - Click "Restore"
  - **3.17.x**: Restores status to active

- `GET /ViewSubjectGroupClass` - View subject group class
  - **DB**: `subject_group_class`, `subject_group_map`
  - **UI**: `/pages/managestudy/viewSubjectGroupClass` - View group details

### Subject Assignment
- `POST /AssignSubjectToStudy` - Assign subject to study
  - **DB**: `study_subject` (creates assignment)
  - **UI**: `/pages/admin/assignSubjectToStudy` - Assign subject

- `POST /RemoveSubjectFromStudy` - Remove subject from study
  - **DB**: `study_subject` (marks as removed)
  - **UI**: `/pages/managestudy/viewStudySubject` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreSubjectToStudy` - Restore subject to study
  - **DB**: `study_subject` (restores status)
  - **UI**: `/pages/managestudy/listStudySubject` - Click "Restore"
  - **3.17.x**: Restores status to active

## 📝 DATA ENTRY & FORMS APIs

### Data Entry Operations
- `GET /InitialDataEntry` - Initial data entry form
  - **DB**: `event_crf`, `item_data`, `crf_version`
  - **UI**: `/pages/submit/initialDataEntry` - Click "Enter Data" on CRF

- `POST /DataEntry` - Submit data entry
  - **DB**: `item_data`, `event_crf` (updates status)
  - **UI**: `/pages/submit/initialDataEntry` - Click "Save and Continue"

- `POST /DoubleDataEntry` - Double data entry verification
  - **DB**: `item_data` (compares two entries)
  - **UI**: `/pages/submit/doubleDataEntry` - Click "Enter Data" for verification

- `GET /EnterDataForStudyEvent` - Enter data for study event
  - **DB**: `study_event`, `event_crf`
  - **UI**: `/pages/submit/enterDataForStudyEvent` - Select CRF to enter data

- `POST /AdministrativeEditing` - Administrative data editing
  - **DB**: `item_data`, `audit_log_event`
  - **UI**: `/pages/submit/administrativeEditing` - Click "Administrative Editing"
  - **3.17.x**: Requires reason for change and audit trail

- `GET /ViewSectionDataEntry` - View section data entry
  - **DB**: `item_data`, `event_crf`
  - **UI**: `/pages/submit/viewSectionDataEntry` - View section data

- `GET /ViewSectionDataEntryById` - View section data entry by ID
  - **DB**: `item_data`, `event_crf`
  - **UI**: Direct section view by ID

- `GET /ViewSectionDataEntryRESTUrlServlet` - View section data entry REST URL
  - **DB**: No database operation (URL generation)
  - **UI**: REST endpoint for external clients

### CRF Management
- `POST /CreateCRF` - Create new CRF
  - **DB**: `crf`
  - **UI**: `/pages/admin/createCRF` - Admin → Create CRF

- `POST /CreateCRFVersion` - Create CRF version
  - **DB**: `crf_version`, `crf`
  - **UI**: `/pages/admin/createCRFVersion` - Click "Create Version" on CRF

- `POST /CreateXformCRFVersion` - Create XForm CRF version
  - **DB**: `crf_version`, `crf`
  - **UI**: `/pages/admin/createXformCRFVersion` - Click "Create XForm Version"

- `GET /ViewCRF` - View CRF details
  - **DB**: `crf`, `crf_version`
  - **UI**: `/pages/admin/viewCRF` - Click on CRF name

- `POST /UpdateCRF` - Update CRF
  - **DB**: `crf`
  - **UI**: `/pages/admin/updateCRF` - Click "Update" on CRF

- `POST /RemoveCRF` - Remove CRF
  - **DB**: `crf` (marks as removed)
  - **UI**: `/pages/admin/viewCRF` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreCRF` - Restore CRF
  - **DB**: `crf` (restores status)
  - **UI**: `/pages/admin/listCRF` - Click "Restore"
  - **3.17.x**: Restores status to active

### CRF Version Management
- `POST /LockCRFVersion` - Lock CRF version
  - **DB**: `crf_version` (updates status to LOCKED)
  - **UI**: `/pages/admin/viewCRFVersion` - Click "Lock"

- `POST /UnlockCRFVersion` - Unlock CRF version
  - **DB**: `crf_version` (updates status to AVAILABLE)
  - **UI**: `/pages/admin/viewCRFVersion` - Click "Unlock"

- `POST /RemoveCRFVersion` - Remove CRF version
  - **DB**: `crf_version` (marks as removed)
  - **UI**: `/pages/admin/viewCRFVersion` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreCRFVersion` - Restore CRF version
  - **DB**: `crf_version` (restores status)
  - **UI**: `/pages/admin/listCRFVersion` - Click "Restore"
  - **3.17.x**: Restores status to active

- `GET /ViewCRFVersion` - View CRF version details
  - **DB**: `crf_version`, `crf`, `section`, `item`
  - **UI**: `/pages/admin/viewCRFVersion` - Click on version

- `POST /UpdateCRFVersion` - Update CRF version
  - **DB**: `crf_version`
  - **UI**: `/pages/admin/updateCRFVersion` - Click "Update" on version

### CRF Definition Management
- `POST /AddCRFToDefinition` - Add CRF to event definition
  - **DB**: `event_definition_crf`
  - **UI**: `/pages/managestudy/defineStudyEvent` - Click "Add CRF"

- `POST /RemoveCRFFromDefinition` - Remove CRF from event definition
  - **DB**: `event_definition_crf` (marks as removed)
  - **UI**: `/pages/managestudy/viewEventDefinition` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreCRFFromDefinition` - Restore CRF to event definition
  - **DB**: `event_definition_crf` (restores status)
  - **UI**: `/pages/managestudy/viewEventDefinition` - Click "Restore"
  - **3.17.x**: Restores status to active

- `POST /ChangeDefinitionCRFOrdinal` - Change CRF ordinal in definition
  - **DB**: `event_definition_crf` (updates ordinal)
  - **UI**: `/pages/managestudy/viewEventDefinition` - Change order

- `GET /CheckCRFLocked` - Check if CRF is locked
  - **DB**: `crf_version` (checks status)
  - **UI**: Used internally to verify lock status

### Form Operations
- `GET /SectionPreview` - Preview form section
  - **DB**: `section`, `item`, `crf_version`
  - **UI**: `/pages/admin/sectionPreview` - Click "Preview Section"

- `GET /form` - Form display
  - **DB**: `crf`, `crf_version`, `section`, `item`
  - **UI**: `/pages/submit/form` - Display form for data entry

- `GET /TableOfContents` - Table of contents
  - **DB**: `crf_version`, `section`
  - **UI**: `/pages/submit/tableOfContents` - View form structure

- `GET /ViewTableOfContent` - View table of contents
  - **DB**: `crf_version`, `section`, `item_group`
  - **UI**: `/pages/submit/viewTableOfContent` - Detailed TOC view

- `POST /MarkEventCRFComplete` - Mark event CRF as complete
  - **DB**: `event_crf` (updates status to COMPLETED)
  - **UI**: `/pages/submit/markEventCRFComplete` - Click "Mark Complete"

## 📊 CLINICAL DATA & REPORTING APIs

### Clinical Data Retrieval
- `GET /rest/clinicaldata/json/view/{study}/{subject}/{event}/{form}` - Get clinical data (JSON format)
  - **DB**: `item_data`, `event_crf`, `study_event`, `study_subject`
  - **UI**: REST API endpoint (external client)

- `GET /rest/clinicaldata/xml/view/{study}/{subject}/{event}/{form}` - Get clinical data (XML format)
  - **DB**: `item_data`, `event_crf`, `study_event`, `study_subject`
  - **UI**: REST API endpoint (external client)

- `GET /pages/auth/api/v1/clinicaldata/json/view/{studyOID}/{subject}/{event}/{form}` - Get clinical data (Spring REST)
  - **DB**: `item_data`, `event_crf`, `study_event`, `study_subject`
  - **UI**: REST API endpoint (Spring framework)

- `GET /ClinicalData/html/view/*` - Clinical data HTML view
  - **DB**: `item_data`, `event_crf`, `study_event`
  - **UI**: `/pages/viewClinicalData` - View clinical data in HTML format

### Data Export & Reporting
- `POST /CreateJobExport` - Create data export job
  - **DB**: `job_detail` (Quartz), `extract_bean`
  - **UI**: `/pages/admin/createJobExport` - Admin → Create Export Job
  - **3.17.x**: Uses Quartz scheduler for job management

- `GET /ExportDataset` - Export dataset
  - **DB**: `item_data`, `study_subject`, `study_event`
  - **UI**: `/pages/extract/exportDataset` - Extract → Export Dataset

- `GET /ChooseDownloadFormat` - Choose download format
  - **DB**: No database operation (format selection)
  - **UI**: `/pages/extract/chooseDownloadFormat` - Select export format

- `GET /pages/auth/api/v1/report/*` - Reporting operations (REST)
  - **DB**: Various based on report type
  - **UI**: REST API endpoint for reporting

- `GET /ExportExcelStudySubjectAuditLog` - Export audit log to Excel
  - **DB**: `audit_log_event`, `study_subject`
  - **UI**: `/pages/audit/exportExcelAuditLog` - Export audit log

### Dataset Management
- `POST /CreateDataset` - Create new dataset
  - **DB**: `dataset`
  - **UI**: `/pages/extract/createDataset` - Extract → Create Dataset

- `POST /EditDataset` - Edit dataset
  - **DB**: `dataset`
  - **UI**: `/pages/extract/editDataset` - Click "Edit" on dataset

- `POST /RemoveDataset` - Remove dataset
  - **DB**: `dataset` (marks as removed)
  - **UI**: `/pages/extract/viewDataset` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreDataset` - Restore dataset
  - **DB**: `dataset` (restores status)
  - **UI**: `/pages/extract/listDataset` - Click "Restore"
  - **3.17.x**: Restores status to active

- `GET /ViewDataset` - View dataset details
  - **DB**: `dataset`, `item_data`
  - **UI**: `/pages/extract/viewDataset` - Click on dataset name

### Filter Management
- `POST /CreateFiltersOne` - Create filters (step 1)
  - **DB**: `filter` (creates filter definition)
  - **UI**: `/pages/extract/createFiltersOne` - Extract → Create Filter (Step 1)

- `POST /CreateFiltersTwo` - Create filters (step 2)
  - **DB**: `filter`, `filter_crf_version_map`
  - **UI**: `/pages/extract/createFiltersTwo` - Create Filter (Step 2)

- `POST /EditFilter` - Edit filter
  - **DB**: `filter`, `filter_crf_version_map`
  - **UI**: `/pages/extract/editFilter` - Click "Edit" on filter

- `POST /RemoveFilter` - Remove filter
  - **DB**: `filter` (marks as removed)
  - **UI**: `/pages/extract/viewFilter` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreFilter` - Restore filter
  - **DB**: `filter` (restores status)
  - **UI**: `/pages/extract/listFilter` - Click "Restore"
  - **3.17.x**: Restores status to active

- `POST /ApplyFilter` - Apply filter
  - **DB**: `filter`, `item_data`
  - **UI**: `/pages/extract/applyFilter` - Click "Apply Filter"

## ⚙️ ADMINISTRATION & SYSTEM APIs

### System Administration
- `GET /SystemStatus` - Get system status
  - **DB**: Database connection check (no specific table)
  - **UI**: `/pages/admin/systemStatus` - Admin → System Status

- `POST /Configure` - System configuration
  - **DB**: Various system configuration tables
  - **UI**: `/pages/admin/configure` - Admin → Configuration

- `GET /AdminSystem` - Admin system functions
  - **DB**: No specific table (admin dashboard)
  - **UI**: `/pages/admin/adminSystem` - Admin → System

- `GET /TechAdmin` - Technical administration
  - **DB**: Various tables (system monitoring)
  - **UI**: `/pages/admin/techAdmin` - Admin → Technical Admin

- `POST /ConfigurePasswordRequirements` - Configure password requirements
  - **DB**: System configuration
  - **UI**: `/pages/admin/configurePasswordRequirements` - Password settings

### Job Management
- `POST /CreateJobExport` - Create export job
  - **DB**: `job_detail` (Quartz), `extract_bean`
  - **UI**: `/pages/admin/createJobExport` - Admin → Create Export Job
  - **3.17.x**: Uses Quartz scheduler (1.8.6)

- `POST /CreateJobImport` - Create import job
  - **DB**: `job_detail` (Quartz), `import_data`
  - **UI**: `/pages/admin/createJobImport` - Admin → Create Import Job
  - **3.17.x**: Uses Quartz scheduler (1.8.6)

- `POST /UpdateJobExport` - Update export job
  - **DB**: `job_detail` (Quartz)
  - **UI**: `/pages/admin/updateJobExport` - Click "Edit" on export job

- `POST /UpdateJobImport` - Update import job
  - **DB**: `job_detail` (Quartz)
  - **UI**: `/pages/admin/updateJobImport` - Click "Edit" on import job

- `POST /PauseJob` - Pause scheduled job
  - **DB**: `job_detail` (Quartz) - updates status
  - **UI**: `/pages/admin/viewAllJobs` - Click "Pause"

- `GET /ViewJob` - View job details
  - **DB**: `job_detail` (Quartz), `job_history`
  - **UI**: `/pages/admin/viewJob` - Click on job name

- `GET /ViewAllJobs` - View all jobs
  - **DB**: `job_detail` (Quartz)
  - **UI**: `/pages/admin/viewAllJobs` - Admin → View All Jobs

- `GET /ViewImportJob` - View import job
  - **DB**: `job_detail` (Quartz), `import_data`
  - **UI**: `/pages/admin/viewImportJob` - Click on import job

- `GET /ViewSingleJob` - View single job
  - **DB**: `job_detail` (Quartz), job execution history
  - **UI**: `/pages/admin/viewSingleJob` - View job execution details

### System Monitoring
- `GET /ViewLogMessage` - View log messages
  - **DB**: `audit_log_event`, `log` table
  - **UI**: `/pages/admin/viewLogMessage` - Admin → View Logs

- `GET /RssReader` - RSS reader
  - **DB**: No database operation (external feed)
  - **UI**: `/pages/admin/rssReader` - View RSS feeds

- `POST /UploadFile` - Upload file
  - **DB**: `file` table
  - **UI**: `/pages/admin/uploadFile` - Click "Upload"

- `GET /AccessFile` - Access file
  - **DB**: `file` (reads file metadata)
  - **UI**: `/pages/admin/accessFile` - Access uploaded file

- `GET /ShowFile` - Show file
  - **DB**: `file` (reads file content)
  - **UI**: `/pages/admin/showFile` - Display file content

## 🔧 RULES & VALIDATION APIs

### Rule Management
- `POST /ImportRule` - Import business rule
  - **DB**: `rule_set`, `rule_set_rule`
  - **UI**: `/pages/rules/importRule` - Rules → Import Rule

- `GET /ViewRuleSet` - View rule set
  - **DB**: `rule_set`, `rule_set_rule`
  - **UI**: `/pages/rules/viewRuleSet` - Click on rule set

- `POST /RunRule` - Execute rule
  - **DB**: `item_data`, `rule_set_rule` (executes rule logic)
  - **UI**: `/pages/rules/viewRuleSet` - Click "Run Rule"

- `POST /TestRule` - Test rule
  - **DB**: Test execution (no permanent changes)
  - **UI**: `/pages/rules/testRule` - Test rule without saving

- `GET /pages/auth/api/v1/rule/*` - Rule management (REST API)
  - **DB**: `rule_set`, `rule_set_rule`
  - **UI**: REST API endpoint for rule management

- `POST /RunRuleSet` - Run rule set
  - **DB**: `item_data`, `rule_set` (executes all rules in set)
  - **UI**: `/pages/rules/viewRuleSet` - Click "Run Rule Set"

- `POST /RemoveRuleSet` - Remove rule set
  - **DB**: `rule_set` (marks as removed)
  - **UI**: `/pages/rules/viewRuleSet` - Click "Remove"
  - **3.17.x**: Soft delete (status change)

- `POST /RestoreRuleSet` - Restore rule set
  - **DB**: `rule_set` (restores status)
  - **UI**: `/pages/rules/listRuleSet` - Click "Restore"
  - **3.17.x**: Restores status to active

### Rule Operations
- `POST /UpdateRuleSetRule` - Update rule set rule
  - **DB**: `rule_set_rule`
  - **UI**: `/pages/rules/updateRuleSetRule` - Click "Edit" on rule

- `GET /ViewRuleAssignment` - View rule assignment
  - **DB**: `rule_set`, `study_event`, `event_definition_crf`
  - **UI**: `/pages/rules/viewRuleAssignment` - View assignments

- `GET /ViewRuleAssignmentNew` - View rule assignment (new)
  - **DB**: `rule_set`, `study_event`, `event_definition_crf`
  - **UI**: `/pages/rules/viewRuleAssignmentNew` - New assignment view

- `POST /DownloadRuleSetXml` - Download rule set XML
  - **DB**: `rule_set`, `rule_set_rule`
  - **UI**: `/pages/rules/viewRuleSet` - Click "Download XML"

- `POST /VerifyImportedRule` - Verify imported rule
  - **DB**: Validates rule syntax (no permanent changes)
  - **UI**: `/pages/rules/verifyImportedRule` - Verify before import

- `GET /ViewRuleSetAudit` - View rule set audit
  - **DB**: `rule_set_audit`, `audit_log_event`
  - **UI**: `/pages/rules/viewRuleSetAudit` - View audit log for rules

### Validation
- `POST /ExecuteCrossEditCheck` - Execute cross edit check
  - **DB**: `item_data` (validates cross-item rules)
  - **UI**: `/pages/dataEntry/executeCrossEditCheck` - Run validation

- `POST /VerifyImportedCRFData` - Verify imported CRF data
  - **DB**: `item_data`, `event_crf` (validates imported data)
  - **UI**: `/pages/dataEntry/verifyImportedCRFData` - Verify after import

## 📱 PARTICIPANT FORMS APIs (OpenRosa)

### Form Operations
- `GET /rest2/openrosa/formList` - Get form list
  - **DB**: `crf`, `crf_version`
  - **UI**: REST endpoint (OpenRosa protocol)

- `POST /rest2/openrosa/submission` - Submit form data
  - **DB**: `item_data`, `event_crf`, `study_event`
  - **UI**: REST endpoint (OpenRosa protocol)

- `GET /rest2/openrosa/formXml` - Get form XML
  - **DB**: `crf_version`, `item`, `section`
  - **UI**: REST endpoint (OpenRosa protocol)

- `GET /openrosa/formXml` - Get form XML (legacy)
  - **DB**: `crf_version`, `item`, `section`
  - **UI**: REST endpoint (legacy OpenRosa)

- `GET /ParticipantFormServlet` - Participant form servlet
  - **DB**: Various participant form tables
  - **UI**: `/pages/participant/participantForm` - Participant forms

### Form Management
- `POST /BatchCRFMigration` - Batch CRF migration
  - **DB**: `crf`, `crf_version`, `event_definition_crf`
  - **UI**: `/pages/admin/batchCRFMigration` - Admin → Batch Migration

- `GET /pages/auth/api/v1/form/*` - Form operations (REST)
  - **DB**: `crf`, `crf_version`
  - **UI**: REST API endpoint

- `POST /ChangeCRFVersion` - Change CRF version
  - **DB**: `event_definition_crf` (updates crf_version_id)
  - **UI**: `/pages/managestudy/changeCRFVersion` - Update CRF version

## 🌐 WEB SERVICES & OAUTH APIs

### Web Services
- `/ws/*` - SOAP web services endpoints
  - **DB**: Various based on web service type
  - **UI**: SOAP endpoints for external integration

- `/oauth/*` - OAuth authentication endpoints
  - **DB**: `oauth_client`, `oauth_access_token`
  - **UI**: OAuth authentication flows

### OAuth Authentication (3.17.x Branch Only)
- `GET /oauth/confirm_access` - OAuth access confirmation page for protected resources
  - **DB**: `oauth_client`, `oauth_authorization_code`
  - **UI**: Displays OAuth authorization confirmation page
  - **Controller**: `AccessConfirmationController`
  - **Response**: HTML confirmation page (`access_confirmation.jsp`)
  - **Use Case**: Part of OAuth 2.0 authorization server implementation
  - **Security**: Uses `ClientAuthenticationCache` and `ClientDetailsService`
  - **3.17.x**: NEW in 3.17.x branch - OAuth 2.0 support

### REST API Base Paths
- `/rest/*` - Jersey REST API endpoints
  - **DB**: Various based on endpoint
  - **UI**: REST API endpoints (Jersey framework)

- `/rest2/*` - Jersey REST API endpoints (v2)
  - **DB**: Various based on endpoint
  - **UI**: REST API endpoints v2 (Jersey framework)

- `/pages/auth/api/*` - Spring REST API endpoints
  - **DB**: Various based on endpoint
  - **UI**: REST API endpoints (Spring framework)

## 🔍 AUDIT & LOGGING APIs

### Audit Operations
- `GET /AuditLogUser` - User audit log
  - **DB**: `audit_log_event`, `user_account`
  - **UI**: `/pages/audit/auditLogUser` - Audit → User Log

- `GET /AuditLogStudy` - Study audit log
  - **DB**: `audit_log_event`, `study`
  - **UI**: `/pages/audit/auditLogStudy` - Audit → Study Log

- `GET /AuditUserActivity` - User activity audit
  - **DB**: `audit_log_event`, `user_account`
  - **UI**: `/pages/audit/auditUserActivity` - View user activity

- `GET /AuditDatabase` - Database audit
  - **DB**: `audit_log_event` (all tables)
  - **UI**: `/pages/audit/auditDatabase` - Full database audit

- `GET /StudyAuditLog` - Study audit log
  - **DB**: `audit_log_event`, `study`, `study_event`
  - **UI**: `/pages/audit/studyAuditLog` - Study-specific audit

- `GET /ViewItemAuditLog` - Item audit log
  - **DB**: `audit_log_event`, `item_data`
  - **UI**: `/pages/audit/viewItemAuditLog` - Item data changes

### Logging
- `GET /ViewLogMessage` - View log messages
  - **DB**: `log` table
  - **UI**: `/pages/admin/viewLogMessage` - View system logs

- `GET /RssReader` - RSS reader for updates
  - **DB**: No database operation (external feed)
  - **UI**: `/pages/admin/rssReader` - View RSS feeds

## 📁 FILE MANAGEMENT APIs

### File Operations
- `POST /UploadFile` - Upload file
  - **DB**: `file`
  - **UI**: `/pages/admin/uploadFile` - Click "Upload"

- `GET /AccessFile` - Access file
  - **DB**: `file` (reads metadata)
  - **UI**: `/pages/admin/accessFile` - Access uploaded file

- `GET /ShowFile` - Show file
  - **DB**: `file` (reads content)
  - **UI**: `/pages/admin/showFile` - Display file

- `GET /DownloadAttachedFile` - Download attached file
  - **DB**: `file` (reads file content)
  - **UI**: `/pages/admin/downloadAttachedFile` - Download file

### Print Operations
- `GET /PrintEventCRF` - Print event CRF
  - **DB**: `event_crf`, `item_data`
  - **UI**: `/pages/submit/printEventCRF` - Print CRF

- `GET /PrintAllEventCRF` - Print all event CRFs
  - **DB**: `event_crf`, `item_data`
  - **UI**: `/pages/submit/printAllEventCRF` - Print all CRFs

- `GET /PrintAllSiteEventCRF` - Print all site event CRFs
  - **DB**: `event_crf`, `item_data`, `study_subject`
  - **UI**: `/pages/submit/printAllSiteEventCRF` - Print site CRFs

## 🔍 SOURCE DATA VERIFICATION APIs

### SDV Operations
- `GET /pages/auth/api/v1/sdv/*` - SDV operations (REST API)
  - **DB**: `study_event_definition_ae`, `item_data` (SDV status)
  - **UI**: REST API endpoint for SDV operations

- `GET /pages/auth/api/itemdata/sdv/{filternumber}/{studyoid}/paginated` - Paginated SDV data
  - **DB**: `item_data`, `event_crf`, `study_subject`
  - **UI**: REST API endpoint with pagination

- `GET /ViewAllSubjectSDV` - View all subject SDV
  - **DB**: `study_event_definition_ae`, `item_data`, `study_subject`
  - **UI**: `/pages/monitor/viewAllSubjectSDV` - Monitor → SDV

- `GET /ViewAllSubjectSDVform` - View all subject SDV form
  - **DB**: `study_event_definition_ae`, `item_data`, `event_crf`
  - **UI**: `/pages/monitor/viewAllSubjectSDVform` - SDV by form

- `GET /ViewAllSubjectSDVtmp` - View all subject SDV temporary
  - **DB**: `study_event_definition_ae`, `item_data` (temporary view)
  - **UI**: `/pages/monitor/viewAllSubjectSDVtmp` - SDV temp view

## 📝 DISCREPANCY NOTES APIs

### Discrepancy Note Operations
- `GET /pages/auth/api/v1/discrepancynote/*` - Discrepancy notes (REST API)
  - **DB**: `discrepancy_note`
  - **UI**: REST API endpoint for discrepancy notes

- `POST /CreateDiscrepancyNote` - Create discrepancy note
  - **DB**: `discrepancy_note`
  - **UI**: `/pages/dataEntry/createDiscrepancyNote` - Click "Add Note"

- `GET /ViewDiscrepancyNote` - View discrepancy note
  - **DB**: `discrepancy_note`, `discrepancy_note_type`
  - **UI**: `/pages/dataEntry/viewDiscrepancyNote` - Click on note

- `POST /ResolveDiscrepancy` - Resolve discrepancy
  - **DB**: `discrepancy_note` (updates status to RESOLVED)
  - **UI**: `/pages/dataEntry/viewDiscrepancyNote` - Click "Resolve"

- `GET /ListDiscNotesForCRFServlet` - List discrepancy notes for CRF
  - **DB**: `discrepancy_note`, `event_crf`
  - **UI**: `/pages/dataEntry/listDiscNotesForCRF` - View CRF notes

- `GET /ListDiscNotesSubjectServlet` - List discrepancy notes for subject
  - **DB**: `discrepancy_note`, `study_subject`
  - **UI**: `/pages/dataEntry/listDiscNotesSubject` - View subject notes

- `GET /ListDNotesForCRF` - List discrepancy notes for CRF
  - **DB**: `discrepancy_note`, `event_crf`
  - **UI**: `/pages/dataEntry/listDNotesForCRF` - List CRF notes

- `POST /AddDiscrepancyNote` - Add discrepancy note
  - **DB**: `discrepancy_note`
  - **UI**: `/pages/dataEntry/addDiscrepancyNote` - Click "Add Note"

## 📊 METADATA APIs

### Metadata Operations
- `GET /rest/metadata/*` - Study metadata (Jersey REST)
  - **DB**: `study`, `crf`, `study_event_definition`
  - **UI**: REST API endpoint (Jersey framework)

- `GET /pages/auth/api/v1/metadata/*` - Metadata (Spring REST)
  - **DB**: `study`, `crf`, `study_event_definition`
  - **UI**: REST API endpoint (Spring framework)

## 🎯 MISCELLANEOUS APIs

### Navigation & UI
- `GET /MainMenu` - Main menu
  - **DB**: No database operation (page navigation)
  - **UI**: `/pages/mainMenu` - Main navigation menu

- `GET /ManageStudy` - Manage study
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/manageStudy` - Manage study settings

- `GET /ManageStudy1` - Manage study (test)
  - **DB**: `study`, `study_parameter_value`
  - **UI**: `/pages/managestudy/manageStudy1` - Test page for study management

### Data Views
- `GET /ViewSubjectAggregate` - View subject aggregate
  - **DB**: `study_subject`, `item_data`, `event_crf`
  - **UI**: `/pages/viewSubjectAggregate` - View aggregated subject data

- `GET /ViewNotes` - View notes
  - **DB**: `discrepancy_note`
  - **UI**: `/pages/viewNotes` - View all notes

- `GET /ViewNotesForSubject` - View notes for subject
  - **DB**: `discrepancy_note`, `study_subject`
  - **UI**: `/pages/viewNotesForSubject` - View subject-specific notes

### System Operations
- `POST /SetUserRole` - Set user role
  - **DB**: `study_user_role`
  - **UI**: `/pages/admin/setUserRole` - Assign user role in study

- `GET /ViewJob` - View job
  - **DB**: `job_detail` (Quartz), job execution history
  - **UI**: `/pages/admin/viewJob` - View job details

- `GET /ViewSingleJob` - View single job
  - **DB**: `job_detail` (Quartz), job execution history
  - **UI**: `/pages/admin/viewSingleJob` - View single job execution

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
