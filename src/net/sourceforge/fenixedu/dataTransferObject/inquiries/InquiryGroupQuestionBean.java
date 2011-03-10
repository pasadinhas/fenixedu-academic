package net.sourceforge.fenixedu.dataTransferObject.inquiries;

import java.io.Serializable;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import net.sourceforge.fenixedu.domain.inquiries.InquiryDelegateAnswer;
import net.sourceforge.fenixedu.domain.inquiries.InquiryGroupQuestion;
import net.sourceforge.fenixedu.domain.inquiries.InquiryQuestion;
import net.sourceforge.fenixedu.domain.inquiries.MandatoryCondition;
import net.sourceforge.fenixedu.domain.inquiries.QuestionCondition;
import net.sourceforge.fenixedu.domain.inquiries.StudentInquiryRegistry;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.lang.StringUtils;

import pt.utl.ist.fenix.tools.util.i18n.MultiLanguageString;

public class InquiryGroupQuestionBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private StudentInquiryRegistry studentInquiryRegistry;
    private InquiryGroupQuestion inquiryGroupQuestion;
    private SortedSet<InquiryQuestionDTO> inquiryQuestions;
    private Integer order;
    private boolean joinUp;
    private boolean isVisible;
    private String[] conditionValues;

    public InquiryGroupQuestionBean(InquiryGroupQuestion groupQuestion, StudentInquiryRegistry studentInquiryRegistry) {
	initGroup(groupQuestion);
	setStudentInquiryRegistry(studentInquiryRegistry);
	setConditionOptions(studentInquiryRegistry);
	for (InquiryQuestion inquiryQuestion : groupQuestion.getInquiryQuestions()) {
	    getInquiryQuestions().add(new InquiryQuestionDTO(inquiryQuestion, studentInquiryRegistry));
	}
    }

    public InquiryGroupQuestionBean(InquiryGroupQuestion inquiryGroupQuestion, InquiryDelegateAnswer inquiryDelegateAnswer) {
	initGroup(inquiryGroupQuestion);
	setVisible(true);
	for (InquiryQuestion inquiryQuestion : inquiryGroupQuestion.getInquiryQuestions()) {
	    getInquiryQuestions().add(new InquiryQuestionDTO(inquiryQuestion, inquiryDelegateAnswer));
	}
    }

    private void initGroup(InquiryGroupQuestion groupQuestion) {
	setInquiryGroupQuestion(groupQuestion);
	setInquiriyQuestions(new TreeSet<InquiryQuestionDTO>(new BeanComparator("inquiryQuestion.questionOrder")));
	setOrder(groupQuestion.getGroupOrder());
	setJoinUp(false);
    }

    private void setConditionOptions(StudentInquiryRegistry studentInquiryRegistry) {
	setVisible(getInquiryGroupQuestion().isVisible(studentInquiryRegistry));
	setConditionValues(getInquiryGroupQuestion().getConditionValues(studentInquiryRegistry));
    }

    //valida��o para parte curricular do aluno, qd depender de resultados de respostas tem q se adaptar isto
    public String validate(Set<InquiryBlockDTO> inquiryBlocks) {
	if (isVisible()) {
	    Set<InquiryQuestionDTO> questions = getInquiryQuestions();
	    boolean isGroupFilledIn = false;
	    for (InquiryQuestionDTO inquiryQuestionDTO : questions) {
		InquiryQuestion inquiryQuestion = inquiryQuestionDTO.getInquiryQuestion();
		if (StringUtils.isEmpty(inquiryQuestionDTO.getResponseValue())) {
		    if (inquiryQuestion.getRequired()) {
			return Boolean.toString(false);
		    }
		    for (QuestionCondition questionCondition : inquiryQuestion.getQuestionConditions()) {
			if (questionCondition instanceof MandatoryCondition) {
			    MandatoryCondition condition = (MandatoryCondition) questionCondition;
			    InquiryQuestionDTO inquiryDependentQuestionBean = getInquiryQuestionBean(condition
				    .getInquiryDependentQuestion(), inquiryBlocks);
			    boolean isMandatory = condition.getConditionValuesAsList().contains(
				    inquiryDependentQuestionBean.getFinalValue());
			    if (isMandatory) {
				return getQuestionIdentifier(inquiryQuestion.getLabel());
			    }
			}
		    }
		} else {
		    isGroupFilledIn = true;
		}
	    }
	    if (getInquiryGroupQuestion().getRequired() && !isGroupFilledIn) {
		return Boolean.toString(false);
	    }
	    for (QuestionCondition questionCondition : getInquiryGroupQuestion().getQuestionConditions()) {
		if (questionCondition instanceof MandatoryCondition) {
		    MandatoryCondition condition = (MandatoryCondition) questionCondition;
		    InquiryQuestionDTO inquiryDependentQuestionBean = getInquiryQuestionBean(condition
			    .getInquiryDependentQuestion(), inquiryBlocks);
		    boolean isMandatory = condition.getConditionValuesAsList().contains(
			    inquiryDependentQuestionBean.getFinalValue());
		    if (isMandatory && !isGroupFilledIn) {
			return getQuestionIdentifier(getInquiryGroupQuestion().getInquiryQuestionHeader().getTitle());
		    }
		}
	    }
	}
	return Boolean.toString(true);
    }

    private String getQuestionIdentifier(MultiLanguageString label) {
	if (label != null) {
	    int endIndex = label.toString().indexOf(" ");
	    return label.toString().substring(0, endIndex);
	}
	return StringUtils.EMPTY;
    }

    private InquiryQuestionDTO getInquiryQuestionBean(InquiryQuestion inquiryQuestion, Set<InquiryBlockDTO> inquiryBlocks) {
	for (InquiryBlockDTO blockDTO : inquiryBlocks) {
	    for (InquiryGroupQuestionBean groupQuestionBean : blockDTO.getInquiryGroups()) {
		for (InquiryQuestionDTO inquiryQuestionDTO : groupQuestionBean.getInquiryQuestions()) {
		    if (inquiryQuestionDTO.getInquiryQuestion() == inquiryQuestion) {
			return inquiryQuestionDTO;
		    }
		}
	    }
	}
	return null;
    }

    public SortedSet<InquiryQuestionDTO> getInquiryQuestions() {
	return inquiryQuestions;
    }

    public void setInquiriyQuestions(SortedSet<InquiryQuestionDTO> inquiryQuestions) {
	this.inquiryQuestions = inquiryQuestions;
    }

    public void setInquiryGroupQuestion(InquiryGroupQuestion inquiryGroupQuestion) {
	this.inquiryGroupQuestion = inquiryGroupQuestion;
    }

    public InquiryGroupQuestion getInquiryGroupQuestion() {
	return inquiryGroupQuestion;
    }

    public void setJoinUp(boolean joinUp) {
	this.joinUp = joinUp;
    }

    public boolean isJoinUp() {
	return joinUp;
    }

    public void setOrder(Integer order) {
	this.order = order;
    }

    public Integer getOrder() {
	return order;
    }

    public void setStudentInquiryRegistry(StudentInquiryRegistry studentInquiryRegistry) {
	this.studentInquiryRegistry = studentInquiryRegistry;
    }

    public StudentInquiryRegistry getStudentInquiryRegistry() {
	return studentInquiryRegistry;
    }

    public void setVisible(boolean isVisible) {
	this.isVisible = isVisible;
    }

    public boolean isVisible() {
	return isVisible;
    }

    public void setConditionValues(String[] conditionValues) {
	this.conditionValues = conditionValues;
    }

    public String[] getConditionValues() {
	return conditionValues;
    }
}
