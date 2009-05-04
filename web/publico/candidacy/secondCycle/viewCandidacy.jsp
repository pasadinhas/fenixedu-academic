<%@ page language="java"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>
<%@ page import="pt.utl.ist.fenix.tools.util.i18n.Language"%>
<%@ page import="java.util.Locale"%>
<%@ page import="net.sourceforge.fenixedu.presentationTier.servlets.filters.ChecksumRewriter"%>
<%@ page import="net.sourceforge.fenixedu.domain.candidacyProcess.IndividualCandidacyDocumentFile" %>

<html:xhtml/>

<bean:define id="mappingPath" name="mappingPath"/>
<bean:define id="fullPath"><%= request.getContextPath() + "/publico" + mappingPath + ".do" %></bean:define>

<div class="breadcumbs">
	<a href="http://www.ist.utl.pt">IST</a> &gt;
	<%= ChecksumRewriter.NO_CHECKSUM_PREFIX_HAS_CONTEXT_PREFIX %><a href="<%= request.getContextPath() + "/candidaturas/introducao" %>"><bean:message key="title.candidate" bundle="CANDIDATE_RESOURCES"/></a> &gt;
	<%= ChecksumRewriter.NO_CHECKSUM_PREFIX_HAS_CONTEXT_PREFIX %><a href="<%= request.getContextPath() + "/candidaturas/licenciaturas" %>"><bean:message key="title.degrees" bundle="CANDIDATE_RESOURCES"/></a> &gt;
	<a href='<%= fullPath + "?method=beginCandidacyProcessIntro" %>'><bean:write name="application.name"/> </a> &gt;
	<bean:message key="title.view.candidacy.process" bundle="CANDIDATE_RESOURCES"/>
</div>

<h1><bean:write name="application.name"/></h1>

<logic:equal name="individualCandidacyProcessBean" property="individualCandidacyProcess.allRequiredFilesUploaded" value="false">
<div class="error1">
	<p><bean:message key="message.missing.document.files" bundle="CANDIDATE_RESOURCES"/></p>
	<ul>
	<logic:iterate id="missingDocumentFileType" name="individualCandidacyProcessBean" property="individualCandidacyProcess.missingRequiredDocumentFiles">
		<li><fr:view name="missingDocumentFileType" property="localizedName"/></li>
	</logic:iterate>
	</ul>
	<p><bean:message key="message.ist.conditions.note" bundle="CANDIDATE_RESOURCES"/></p>
</div>
<p>&nbsp;</p>	
</logic:equal>


<fr:form action='<%= mappingPath + ".do" %>' id="editCandidacyForm">
	<input type="hidden" name="method" id="methodForm"/>
	<fr:edit id="individualCandidacyProcessBean" name="individualCandidacyProcessBean" visible="false" />
	<noscript>
	<html:submit onclick="this.form.method.value='prepareEditCandidacyProcess';"><bean:message key="button.edit" bundle="APPLICATION_RESOURCES" /></html:submit>
	<html:submit onclick="this.form.method.value='prepareEditCandidacyDocuments';"><bean:message key="label.edit.candidacy.documents" bundle="CANDIDATE_RESOURCES" /></html:submit>
	<html:cancel><bean:message key="label.back" bundle="APPLICATION_RESOURCES" /></html:cancel>
	</noscript>
	
	<a href="#" onclick="javascript:document.getElementById('methodForm').value='prepareEditCandidacyProcess';document.getElementById('editCandidacyForm').submit();"><bean:message key="button.edit" bundle="APPLICATION_RESOURCES" /> <bean:message key="label.application" bundle="CANDIDATE_RESOURCES"/></a> | 
	<a href="#" onclick="javascript:document.getElementById('methodForm').value='prepareEditCandidacyQualifications';document.getElementById('editCandidacyForm').submit();"><bean:message key="label.edit.application.educational.background" bundle="CANDIDATE_RESOURCES"/></a> |
	<a href="#" onclick="javascript:document.getElementById('methodForm').value='prepareEditCandidacyDocuments';document.getElementById('editCandidacyForm').submit();"> <bean:message key="label.edit.candidacy.documents" bundle="CANDIDATE_RESOURCES" /></a>
</fr:form>


<h2 style="margin-top: 1em;"><bean:message key="title.personal.data" bundle="CANDIDATE_RESOURCES"/></h2>

<fr:view name="individualCandidacyProcessBean" 
	schema="PublicCandidacyProcess.candidacyDataBean">
	<fr:layout name="tabular">
		<fr:property name="classes" value="thlight thleft"/>
        <fr:property name="columnClasses" value="width175px,,,,"/>
	</fr:layout>
</fr:view>

<table>
	<tr>
		<td class="width175px"><bean:message key="label.photo" bundle="CANDIDATE_RESOURCES"/>:</td>
		<td>
			<logic:present name="individualCandidacyProcessBean" property="individualCandidacyProcess.photo">
			<bean:define id="photo" name="individualCandidacyProcessBean" property="individualCandidacyProcess.photo"/>
			<%= ChecksumRewriter.NO_CHECKSUM_PREFIX_HAS_CONTEXT_PREFIX %><img src="<%= request.getContextPath() + ((IndividualCandidacyDocumentFile) photo).getDownloadUrl() %>" />
			</logic:present>
			
			<logic:notPresent name="individualCandidacyProcessBean" property="individualCandidacyProcess.photo">
				<em><bean:message key="message.does.not.have.photo" bundle="CANDIDATE_RESOURCES"/></em>
			</logic:notPresent>
		</td>
	</tr>
</table>



<h2 style="margin-top: 1em;"><bean:message key="title.educational.background" bundle="CANDIDATE_RESOURCES"/></h2>

<% 
	Locale locale = Language.getLocale();
	if(!locale.getLanguage().equals(Locale.ENGLISH.getLanguage())) {
%>

<table>
<logic:notEmpty name="individualCandidacyProcessBean" property="istStudentNumber">
	<tr>
		<td><bean:message key="label.ist.student.number" bundle="CANDIDATE_RESOURCES"/>:</td>
		<td>
			<fr:view
				name="individualCandidacyProcessBean"
				schema="PublicCandidacyProcessBean.second.cycle.former.student.ist.number">
				<fr:layout name="flow">
					<fr:property name="labelExcluded" value="true"/>
				</fr:layout>
			</fr:view>	
		</td>
	</tr>
</logic:notEmpty>
</table>

<%
	}
%>

<h3 style="margin-bottom: 0.5em;"><bean:message key="title.bachelor.degree.owned" bundle="CANDIDATE_RESOURCES"/></h3>

<table class="tdtop">
<tr>
	<td><bean:message key="label.university.attended.previously" bundle="CANDIDATE_RESOURCES"/>:</td>
	<td>
		<fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.institutionUnitName.view">
			<fr:layout name="flow">
				<fr:property name="labelExcluded" value="true"/>
			</fr:layout>
		</fr:view>
	</td>
</tr>
</table>
<table>
<tr>
	<td><bean:message key="label.university.previously.attended.country" bundle="CANDIDATE_RESOURCES"/>:</td>
	<td>
		<fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.institution.country.manage">
			<fr:layout name="flow">
				<fr:property name="labelExcluded" value="true"/>
			</fr:layout>
		</fr:view>
	</td>
</tr>
<tr>
	<td><bean:message key="label.bachelor.degree.previously.enrolled" bundle="CANDIDATE_RESOURCES"/>:</td>
	<td>
		<fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.degreeDesignation.manage">
			<fr:layout name="flow">
				<fr:property name="labelExcluded" value="true"/>
			</fr:layout>
		</fr:view>
	</td>
</tr>
<tr>
	<td><bean:message key="label.bachelor.degree.conclusion.date" bundle="CANDIDATE_RESOURCES"/>:</td>
	<td>
		<fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.second.cycle.conclusionDate">
			<fr:layout name="flow">
				<fr:property name="labelExcluded" value="true"/>
			</fr:layout>
		</fr:view>
	</td>
</tr>
<tr>
	<td><bean:message key="label.bachelor.degree.conclusion.grade" bundle="CANDIDATE_RESOURCES"/>:</td>
	<td>
		<fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.second.cycle.conclusionGrade">
			<fr:layout name="flow">
				<fr:property name="labelExcluded" value="true"/>
			</fr:layout>
		</fr:view>
	</td>
</tr>
</table>




<% 
	if(!locale.getLanguage().equals(Locale.ENGLISH.getLanguage())) {
%>

<h3><bean:message key="title.other.academic.titles" bundle="CANDIDATE_RESOURCES"/></h3>
<logic:empty name="individualCandidacyProcessBean" property="formationConcludedBeanList">
	<p><em><bean:message key="message.other.academic.titles.empty" bundle="CANDIDATE_RESOURCES"/>.</em></p>	
</logic:empty>


<logic:notEmpty name="individualCandidacyProcessBean" property="formationConcludedBeanList">
	<table class="tstyle2 thlight thcenter">
	<tr>
		<th><bean:message key="label.other.academic.titles.program.name" bundle="CANDIDATE_RESOURCES"/></th>
		<th><bean:message key="label.other.academic.titles.institution" bundle="CANDIDATE_RESOURCES"/></th>
		<th><bean:message key="label.other.academic.titles.conclusion.date" bundle="CANDIDATE_RESOURCES"/></th>
		<th><bean:message key="label.other.academic.titles.conclusion.grade" bundle="CANDIDATE_RESOURCES"/></th>
	</tr>
	<logic:iterate id="academicTitle" name="individualCandidacyProcessBean" property="formationConcludedBeanList" indexId="index">
	<tr>
		<td>
			<fr:view 	name="academicTitle"
						schema="PublicCandidacyProcessBean.formation.designation">
				<fr:layout name="flow"> <fr:property name="labelExcluded" value="true"/> </fr:layout>
			</fr:view>
		</td>
		<td>
			<fr:view name="academicTitle"
				schema="PublicCandidacyProcessBean.formation.institutionUnitName.view">
				<fr:layout name="flow"> <fr:property name="labelExcluded" value="true"/> </fr:layout>
			</fr:view>	
		</td>
		<td>
			<fr:view 	name="academicTitle"
						schema="PublicCandidacyProcessBean.formation.conclusion.date">
				<fr:layout name="flow"> <fr:property name="labelExcluded" value="true"/> </fr:layout>
			</fr:view> 
		</td>
		<td>
			<fr:view 	name="academicTitle"
						schema="PublicCandidacyProcessBean.formation.conclusion.grade">
				<fr:layout name="flow"> <fr:property name="labelExcluded" value="true"/> </fr:layout>
			</fr:view> 
		</td>
	</tr>
	</logic:iterate>
	</table>
</logic:notEmpty>

<%
	}
%>

<h2 style="margin-top: 1em;"><bean:message key="title.master.second.cycle.course.choice" bundle="CANDIDATE_RESOURCES"/></h2>

<p><fr:view name="individualCandidacyProcessBean"
			schema="PublicCandidacyProcessBean.second.cycle.selectedDegree.view">
	<fr:layout name="flow">
		<fr:property name="labelExcluded" value="true"/>
	</fr:layout>
</fr:view></p>

<h2 style="margin-top: 1em;"><bean:message key="label.documentation" bundle="CANDIDATE_RESOURCES"/></h2> 

<bean:define id="individualCandidacyProcess" name="individualCandidacyProcessBean" property="individualCandidacyProcess"/>


<logic:empty name="individualCandidacyProcess" property="candidacy.documents">
	<p><em><bean:message key="message.documents.empty" bundle="CANDIDATE_RESOURCES"/>.</em></p>
</logic:empty>

<logic:notEmpty name="individualCandidacyProcess" property="candidacy.documents">
<table class="tstyle2 thlight thcenter">
	<tr>
		<th><bean:message key="label.candidacy.document.kind" bundle="CANDIDATE_RESOURCES"/></th>
		<th><bean:message key="label.dateTime.submission" bundle="CANDIDATE_RESOURCES"/></th>
		<th><bean:message key="label.document.file.name" bundle="CANDIDATE_RESOURCES"/></th>
	</tr>

	
	<logic:iterate id="documentFile" name="individualCandidacyProcess" property="candidacy.documents">
	<tr>
		<td><fr:view name="documentFile" property="candidacyFileType"/></td>
		<td><fr:view name="documentFile" property="uploadTime"/></td>
		<td><fr:view name="documentFile" property="filename"/></td>
	</tr>	
	</logic:iterate>
</table>
</logic:notEmpty>

<logic:notEmpty name="individualCandidacyProcessBean" property="observations">
<p class="mbottom05"><bean:message key="title.observations" bundle="CANDIDATE_RESOURCES"/>:</p>
<fr:view 
	name="individualCandidacyProcessBean"
	schema="PublicCandidacyProcessBean.observations">
	  <fr:layout name="flow">
    <fr:property name="labelExcluded" value="true"/>
  </fr:layout>
</fr:view>
</logic:notEmpty>

<div class="mtop15"><bean:message key="message.nape.contacts" bundle="CANDIDATE_RESOURCES"/></div>


